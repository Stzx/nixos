{ default, force, y, n, u, m, ff, ... }:

{
  CONFIG_PROCESSOR_SELECT = force y;
} // {
  X86_EXTENDED_PLATFORM = default n;
  X86_MCE_INJECT = default n;
  NUMA = default n;
  EFI_MIXED = default n;
} // { }
