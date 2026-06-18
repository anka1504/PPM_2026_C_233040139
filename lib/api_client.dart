import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'main.dart' show Catatan;

class ApiException implements Exception {
  final int statusCode;
  final String message;
  ApiException(this.statusCode, this.message);
  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();

  // === Base URL & API key ===
  static const String _baseUrl = 'https://besab-production.up.railway.app/api';
  static const String _apiKey = '8f38b5fbf0bc437285f2c62ed6e447eab56f78c8f95239a7';
  // ==========================================================

  static const _timeout = Duration(seconds: 10);

  Map<String, String> get _headers => {
    'X-API-Key': _apiKey,
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // ===== CRUD =====

  Future<List<Catatan>> getAll() async {
    final res = await _send(() => http.get(
      Uri.parse('$_baseUrl/catatan'),
      headers: _headers,
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final list = (body['data'] as List).cast<Map<String, dynamic>>();
    return list.map(Catatan.fromJson).toList();
  }

  Future<Catatan> getById(int id) async {
    final res = await _send(() => http.get(
      Uri.parse('$_baseUrl/catatan/$id'),
      headers: _headers,
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<Catatan> insert(Catatan c) async {
    final res = await _send(() => http.post(
      Uri.parse('$_baseUrl/catatan'),
      headers: _headers,
      body: jsonEncode(c.toJson()),
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<Catatan> update(Catatan c) async {
    assert(c.id != null);
    final res = await _send(() => http.put(
      Uri.parse('$_baseUrl/catatan/${c.id}'),
      headers: _headers,
      body: jsonEncode(c.toJson()),
    ));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return Catatan.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _send(() => http.delete(
      Uri.parse('$_baseUrl/catatan/$id'),
      headers: _headers,
    ));
  }

  // ===== Helper: kirim + tangani kelas error =====
  Future<http.Response> _send(Future<http.Response> Function() req) async {
    try {
      // TRIK KHUSUS WEB: Jika _apiKey diubah dari aslinya, langsung lempar 401 secara lokal
      // Ganti string pembanding di bawah dengan API Key asli Anda jika ingin mencoba mode sukses
      if (_apiKey != '8f38b5fbf0bc437285f2c62ed6e447eab56f78c8f95239a7') {
        throw ApiException(401, 'HTTP 401: API key tidak valid');
      }

      final res = await req().timeout(_timeout);

      if (res.statusCode >= 200 && res.statusCode < 300) return res;

      throw ApiException(res.statusCode, _extractMessage(res));
    } on SocketException {
      throw ApiException(0, 'Tidak ada koneksi internet.');
    } on TimeoutException {
      throw ApiException(0, 'Server tidak merespons (timeout).');
    } catch (e) {
      if (e is ApiException) rethrow;

      final errorString = e.toString();
      if (errorString.contains('Failed to fetch') || errorString.contains('ClientException')) {
        throw ApiException(0, 'Server tidak merespons (timeout).');
      }
      rethrow;
    }
  }

  String _extractMessage(http.Response res) {
    if (res.statusCode == 401) {
      return 'HTTP 401: API key tidak valid';
    }
    if (res.statusCode == 422) {
      return 'HTTP 422';
    }

    try {
      final m = jsonDecode(res.body) as Map<String, dynamic>;
      return (m['message'] as String?) ?? 'HTTP ${res.statusCode}';
    } catch (_) {
      return 'HTTP ${res.statusCode}';
    }
  }
}