{ default, force, y, n, u, m, ff, ... }:

{ } // {
  X86_X2APIC = default n;
  HYPERVISOR_GUEST = default n;
} // {
  DRM_HYPERV = force u;
  KVM_GUEST = force u;
  MOUSE_PS2_VMMOUSE = force u;
  X86_SGX = force u;
  X86_SGX_KVM = force u;
}
