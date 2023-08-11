{ default, force, y, n, u, m, ff, ... }:

{
  ACPI_PCI_SLOT = force y;

  ZSWAP_COMPRESSOR_DEFAULT_LZ4 = force y;
  ZSWAP_COMPRESSOR_DEFAULT = force (ff "lz4");
  ZSWAP_ZPOOL_DEFAULT_Z3FOLD = force y;
  ZSWAP_ZPOOL_DEFAULT = force (ff "z3fold");

  MODULE_COMPRESS_ZSTD = force y;
} // {
  ZSWAP_COMPRESSOR_DEFAULT_LZO = force n;
  ZSWAP_ZPOOL_DEFAULT_ZBUD = force n;

  MODULE_COMPRESS_XZ = force n;
} // { }
