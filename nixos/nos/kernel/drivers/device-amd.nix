{ default, force, y, n, u, m, ff, ... }:

{ } // {
  INTEL_IOMMU = force n;

  INTEL_IPS = default n;
  INTEL_SCU_PLATFORM = default n;
} // { }
