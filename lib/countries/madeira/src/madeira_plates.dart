import 'package:license_plate/core/plate_core.dart';
import 'package:license_plate/countries/portugal/portugal_plate.dart';

/// Madeira has no plate design of its own: its vehicles carry the national
/// Portuguese plates, with no regional code (the article: "no link to
/// geographical locations"). These are Portugal's specs, measured there, so
/// their ids stay `pt.*`.
///
/// The one Madeiran value is the district code `M` (Funchal) on trailers and
/// export plates, entered in [trailer]'s `district` field.
///
/// Not implemented, as in `portugal_plate`: the 1998–2005 ribbon series, the
/// 1911–1936 zone plates (`M-000` for Madeira from 1918), tactical military
/// plates. The Moroccan, Cape Verdean, Mozambican and Angolan plates the
/// article's photos include belong to those countries' packages.
abstract final class MadeiraPlates {
  static final PlateSpec private = PortugalPlates.private;
  static final PlateSpec dated = PortugalPlates.dated;
  static final PlateSpec legacy = PortugalPlates.legacy;
  static final PlateSpec usForces = PortugalPlates.usForces;
  static final PlateSpec gnr = PortugalPlates.gnr;
  static final PlateSpec trailer = PortugalPlates.trailer;
  static final PlateSpec diplomatic = PortugalPlates.diplomatic;
  static final PlateSpec historic = PortugalPlates.historic;

  static List<PlateSpec> get all => PortugalPlates.all;
}
