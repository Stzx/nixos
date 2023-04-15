{ default, force, y, n, u, m, ff, ... }:

{ } // {
  XFS_FS = default n;
  NFSD = default n;
  SMB_SERVER = default n;
} // {
  NFSD_V2_ACL = force u;
  NFSD_V3_ACL = force u;
  NFSD_V4 = force u;
  NFSD_V4_SECURITY_LABEL = force u;
}
