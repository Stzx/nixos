{ default, force, y, n, u, m, ff, ... }:

{ } // {
  DRM_AMDGPU = default n;
  DRM_NOUVEAU = default n;
  DRM_I915 = default n;
  DRM_GMA500 = default n;
  FB_NVIDIA = default n;
} // {
  DRM_AMDGPU_CIK = force u;
  DRM_AMDGPU_SI = force u;
  DRM_AMDGPU_USERPTR = force u;
  DRM_AMD_DC_DCN = force u;
  DRM_AMD_DC_HDCP = force u;
  DRM_AMD_DC_SI = force u;
  FB_NVIDIA_I2C = force u;
  HSA_AMD = force u;
  NOUVEAU_LEGACY_CTX_SUPPORT = force u;
}
