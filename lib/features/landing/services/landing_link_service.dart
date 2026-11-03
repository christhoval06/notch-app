import 'package:url_launcher/url_launcher.dart';

abstract interface class LandingLinkService {
  Future<bool> open(String url);
}

class ExternalLandingLinkService implements LandingLinkService {
  const ExternalLandingLinkService();

  @override
  Future<bool> open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !['https', 'mailto'].contains(uri.scheme)) return false;
    try {
      return await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
    } catch (_) {
      return false;
    }
  }
}
