{ default, force, y, n, u, m, ff, ... }:

{
  MZEN = force y;
} // {
  CPU_SUP_INTEL = default n;
  CPU_SUP_HYGON = default n;
  CPU_SUP_CENTAUR = default n;
  CPU_SUP_ZHAOXIN = default n;

  X86_INTEL_LPSS = default n;
  IOSF_MBI = default n;
  X86_MCE_INTEL = default n;
  INTEL_SOC_DTS_THERMAL = default n;
  INT340X_THERMAL = default n;
  DRM_I915 = default n;
  SND_SOC_INTEL_SST_TOPLEVEL = default n;
  SND_SOC_SOF_INTEL_TOPLEVEL = default n;
  MMC_SDHCI_PCI = default n;
  MMC_SDHCI_ACPI = default n;
  INTEL_RAPL = default n;
  PUNIT_ATOM_DEBUG = default n;
} // {
  DRM_I915_GVT = force u;
  DRM_I915_GVT_KVMGT = force u;
  INTEL_IDLE = force u;
  MICROCODE_INTEL = force u;
  SND_SOC_INTEL_SOUNDWIRE_SOF_MACH = force u;
  SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES = force u;
  SND_SOC_SOF_APOLLOLAKE = force u;
  SND_SOC_SOF_CANNONLAKE = force u;
  SND_SOC_SOF_COFFEELAKE = force u;
  SND_SOC_SOF_COMETLAKE = force u;
  SND_SOC_SOF_ELKHARTLAKE = force u;
  SND_SOC_SOF_GEMINILAKE = force u;
  SND_SOC_SOF_HDA_AUDIO_CODEC = force u;
  SND_SOC_SOF_HDA_LINK = force u;
  SND_SOC_SOF_ICELAKE = force u;
  SND_SOC_SOF_JASPERLAKE = force u;
  SND_SOC_SOF_MERRIFIELD = force u;
  SND_SOC_SOF_TIGERLAKE = force u;
  XPOWER_PMIC_OPREGION = force u;
}
