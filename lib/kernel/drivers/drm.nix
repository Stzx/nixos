{ default, force, y, n, u, m, ff, ... }:

{ } // {
  AGP_AMD64 = default n;
  AGP_INTEL = default n;
  AGP_SIS = default n;
  AGP_VIA = default n;
  VGA_SWITCHEROO = default n;
  DRM_I2C_CH7006 = default n;
  DRM_I2C_SIL164 = default n;
  DRM_I2C_NXP_TDA998X = default n;
  DRM_I2C_NXP_TDA9950 = default n;
  DRM_RADEON = default n;
  DRM_VMWGFX = default n;
  DRM_UDL = default n;
  DRM_AST = default n;
  DRM_MGAG200 = default n;
  DRM_QXL = default n;
  DRM_PANEL_RASPBERRYPI_TOUCHSCREEN = default n;
  DRM_PANEL_WIDECHIPS_WS2401 = default n;
  DRM_ANALOGIX_ANX78XX = default n;
  DRM_ETNAVIV = default n;
  DRM_GM12U320 = default n;
  DRM_PANEL_MIPI_DBI = default n;
  TINYDRM_HX8357D = default n;
  TINYDRM_ILI9163 = default n;
  TINYDRM_ILI9225 = default n;
  TINYDRM_ILI9341 = default n;
  TINYDRM_ILI9486 = default n;
  TINYDRM_MI0283QT = default n;
  TINYDRM_REPAPER = default n;
  TINYDRM_ST7586 = default n;
  TINYDRM_ST7735R = default n;
  DRM_XEN_FRONTEND = default n;
  DRM_SSD130X = default n;
  DRM_HYPERV = default n;
  FB_CIRRUS = default n;
  FB_PM2 = default n;
  FB_CYBER2000 = default n;
  FB_ARC = default n;
  FB_N411 = default n;
  FB_HGA = default n;
  FB_OPENCORES = default n;
  FB_S1D13XXX = default n;
  FB_RIVA = default n;
  FB_I740 = default n;
  FB_LE80578 = default n;
  FB_MATROX = default n;
  FB_RADEON = default n;
  FB_ATY128 = default n;
  FB_ATY = default n;
  FB_S3 = default n;
  FB_SAVAGE = default n;
  FB_SIS = default n;
  FB_VIA = default n;
  FB_NEOMAGIC = default n;
  FB_KYRO = default n;
  FB_3DFX = default n;
  FB_VOODOO1 = default n;
  FB_VT8623 = default n;
  FB_TRIDENT = default n;
  FB_ARK = default n;
  FB_PM3 = default n;
  FB_CARMINE = default n;
  FB_SM501 = default n;
  FB_SMSCUFX = default n;
  FB_UDL = default n;
  FB_IBM_GXT4500 = default n;
  FB_VIRTUAL = default n;
  XEN_FBDEV_FRONTEND = default n;
  FB_METRONOME = default n;
  FB_MB862XX = default n;
  FB_HYPERV = default n;
  FB_SSD1307 = default n;
  FB_SM712 = default n;
  LCD_CLASS_DEVICE = default n;
  BACKLIGHT_KTD253 = default n;
  BACKLIGHT_LM3533 = default n;
  BACKLIGHT_MT6370 = default n;
  BACKLIGHT_APPLE = default n;
  BACKLIGHT_QCOM_WLED = default n;
  BACKLIGHT_RT4831 = default n;
  BACKLIGHT_SAHARA = default n;
  BACKLIGHT_ADP8860 = default n;
  BACKLIGHT_ADP8870 = default n;
  BACKLIGHT_PCF50633 = default n;
  BACKLIGHT_LM3639 = default n;
  BACKLIGHT_SKY81452 = default n;
  BACKLIGHT_GPIO = default n;
  BACKLIGHT_LV5207LP = default n;
  BACKLIGHT_BD6107 = default n;
  BACKLIGHT_ARCXCNN = default n;
  BACKLIGHT_RAVE_SP = default n;
} // {
  DRM_DP_AUX_CHARDEV = force u;
  DRM_PANEL_RASPBERRYPI_TOUCHSCREEN = force u;
  DRM_VMWGFX_FBCON = force u;
  DRM_XEN_FRONTEND = force u;
  FB_3DFX_ACCEL = force u;
  FB_ATY_CT = force u;
  FB_ATY_GX = force u;
  FB_HYPERV = force u;
  FB_RIVA_I2C = force u;
  FB_SAVAGE_ACCEL = force u;
  FB_SAVAGE_I2C = force u;
  FB_SIS_300 = force u;
  FB_SIS_315 = force u;
  XEN_FBDEV_FRONTEND = force u;
}
