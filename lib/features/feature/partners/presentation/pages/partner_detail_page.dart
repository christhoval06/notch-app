import 'package:flutter/material.dart';
import 'package:notch_app/data/models/partner.dart';
import 'package:notch_app/features/feature/partners/widgets/partner_detail_view.dart';

class PartnerDetailScreen extends StatelessWidget {
  const PartnerDetailScreen({super.key, required this.partner});

  final Partner partner;

  @override
  Widget build(BuildContext context) {
    return PartnerDetailView(partner: partner);
  }
}
