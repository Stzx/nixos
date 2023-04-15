{ default, force, y, n, u, m, ff, ... }:

{ } // {
  NET_DSA = default n;
  VLAN_8021Q = default n;
  ATALK = default n;
  X25 = default n;
  LAPB = default n;
  PHONET = default n;
  "6LOWPAN" = default n;
  IEEE802154 = default n;
  CAN = default n;
  BT = default n;
  AF_RXRPC = default n;
  WIRELESS = default n;
  RFKILL = default n;
  NET_9P = default n;
  CAIF = default n;
  CEPH_LIB = default n;
  NFC = default n;
  BLK_DEV_RBD = default n;
  WLAN = default n;
  CEPH_FS = default n;
  AFS_FS = default n;
} // {
  BRIDGE_VLAN_FILTERING = force u;
  BT_HCIBTUSB_MTK = force u;
  BT_HCIUART = force u;
  BT_HCIUART_QCA = force u;
  BT_HCIUART_SERDEV = force u;
  BT_QCA = force u;
  CEPH_FSCACHE = force u;
  CEPH_FS_POSIX_ACL = force u;
  RT2800USB_RT53XX = force u;
  RT2800USB_RT55XX = force u;
  RTW88 = force u;
  RTW88_8822BE = force u;
  RTW88_8822CE = force u;
}
