#!/bin/sh
# vim: foldmethod=marker

TARGET_DIR="$HOME/.config/zsh"

mkdir -p "$TARGET_DIR"

conflict_check() {
    test -f "$TARGET_DIR/$1" && {
        echo "I'm not overwriting your $1"
        exit 1
    }
}

conflict_check ".zshrc"
conflict_check ".zprofile"

# zshrc dump {{{
echo "IyB2aW06Zm9sZG1ldGhvZD1tYXJrZXIKIyBBbGlhc2VzIHt7ewphbGlhcyBscz0nbHMgLS1jb2xvcj1hdXRvJwphbGlhcyBsYT0nbHMgLWEgLS1jb2xvcj1hdXRvJwphbGlhcyBsbD0nbHMgLWFsaCAtLWNvbG9yPWF1dG8nCmFsaWFzIGdyZXA9J2dyZXAgLS1jb2xvcj1hdXRvJwphbGlhcyB2aW09J252aW0nCgphbGlhcyBjZj0nZmNkJwoKIyMjIEdpdCB7e3sKYWxpYXMgZ3M9J2dpdCBzdGF0dXMnCmFsaWFzIGdsPSdnaXQgbG9nJwphbGlhcyBnbHA9J2dpdCBsb2cgLXAnCmFsaWFzIGdsZz0nZ2l0IGxvZyAtLWdyYXBoJwoKYWxpYXMgZ2NsPSdfX2Nsb25lX2Zyb21fY2xpcGJvYXJkJwphbGlhcyBnZj0nZ2l0IGZldGNoJwoKYWxpYXMgZ2I9J2dpdCBicmFuY2gnCmFsaWFzIGdiYT0nZ2l0IGJyYW5jaCAtLWFsbCcKYWxpYXMgZ2NoPSdnaXQgY2hlY2tvdXQnCgphbGlhcyBnbT0nZ2l0IG1lcmdlJwphbGlhcyBncD0nZ2l0IHB1bGwnCmFsaWFzIGdwdT0nZ2l0IHB1c2gnCgphbGlhcyBnYz0nZ2l0IGNvbW1pdCcKYWxpYXMgZ2NhPSdnaXQgY29tbWl0IC0tYW1lbmQnCmFsaWFzIGdjbT0nZ2l0IGNvbW1pdCAtbScKCmFsaWFzIGdhPSdnaXQgYWRkJwphbGlhcyBnYXA9J2dpdCBhZGQgLS1wYXRjaCcKYWxpYXMgZ3JtPSdnaXQgcm0nCmFsaWFzIGdyPSdnaXQgcmVzdG9yZScKYWxpYXMgZ3JzPSdnaXQgcmVzdG9yZSAtLXN0YWdlZCcKCmFsaWFzIGdzdD0nZ2l0IHN0YXNoJwoKYWxpYXMgZ2Q9J2dpdCBkaWZmJwphbGlhcyBnZGg9J2dpdCBkaWZmIEhFQUQnCmFsaWFzIGdkcz0nZ2l0IGRpZmYgLS1jYWNoZWQnCgpfX2Nsb25lX2Zyb21fY2xpcGJvYXJkKCkgewogICAgaWYgdGVzdCAteiAiJDEiICYmIHBicGFzdGUgfCBncmVwIC1FaXEgJ14oKGdpdHxzc2h8aHR0cChzKT8pfChnaXRAKFx3fFwuKSspKSg6KC8vKT8pKC4rKShcLmdpdCkoLyk/JCcgOyB0aGVuCiAgICAgICAgZ2l0IGNsb25lICQocGJwYXN0ZSkKICAgIGVsc2UKICAgICAgICBnaXQgY2xvbmUgJEAKICAgIGZpCn0KIyMjIH19fQojIyB9fX0KIyBPcHRpb25zIHt7ewpzZXRvcHQgY29ycmVjdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBBdXRvIGNvcnJlY3QgbWlzdGFrZXMKc2V0b3B0IGV4dGVuZGVkZ2xvYiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgRXh0ZW5kZWQgZ2xvYmJpbmcuIEFsbG93cyB1c2luZyByZWd1bGFyIGV4cHJlc3Npb25zIHdpdGggKgpzZXRvcHQgbm9jYXNlZ2xvYiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBDYXNlIGluc2Vuc2l0aXZlIGdsb2JiaW5nCnNldG9wdCByY2V4cGFuZHBhcmFtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIEFycmF5IGV4cGVuc2lvbiB3aXRoIHBhcmFtZXRlcnMKc2V0b3B0IG5vY2hlY2tqb2JzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgRG9uJ3Qgd2FybiBhYm91dCBydW5uaW5nIHByb2Nlc3NlcyB3aGVuIGV4aXRpbmcKc2V0b3B0IG51bWVyaWNnbG9ic29ydCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgU29ydCBmaWxlbmFtZXMgbnVtZXJpY2FsbHkgd2hlbiBpdCBtYWtlcyBzZW5zZQpzZXRvcHQgbm9iZWVwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBObyBiZWVwCnNldG9wdCBhcHBlbmRoaXN0b3J5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIEltbWVkaWF0ZWx5IGFwcGVuZCBoaXN0b3J5IGluc3RlYWQgb2Ygb3ZlcndyaXRpbmcKc2V0b3B0IGhpc3RpZ25vcmVhbGxkdXBzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgSWYgYSBuZXcgY29tbWFuZCBpcyBhIGR1cGxpY2F0ZSwgcmVtb3ZlIHRoZSBvbGRlciBvbmUKc2V0b3B0IGF1dG9jZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgaWYgb25seSBkaXJlY3RvcnkgcGF0aCBpcyBlbnRlcmVkLCBjZCB0aGVyZS4Kc2V0b3B0IGluY19hcHBlbmRfaGlzdG9yeSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgc2F2ZSBjb21tYW5kcyBhcmUgYWRkZWQgdG8gdGhlIGhpc3RvcnkgaW1tZWRpYXRlbHksIG90aGVyd2lzZSBvbmx5IHdoZW4gc2hlbGwgZXhpdHMuCgp6c3R5bGUgJzpjb21wbGV0aW9uOionIG1hdGNoZXItbGlzdCAnbTp7YS16QS1afT17QS1aYS16fScgICAgICAgIyBDYXNlIGluc2Vuc2l0aXZlIHRhYiBjb21wbGV0aW9uCnpzdHlsZSAnOmNvbXBsZXRpb246KicgbGlzdC1jb2xvcnMgIiR7KHMuOi4pTFNfQ09MT1JTfSIgICAgICAgICAjIENvbG9yZWQgY29tcGxldGlvbiAoZGlmZmVyZW50IGNvbG9ycyBmb3IgZGlycy9maWxlcy9ldGMpCnpzdHlsZSAnOmNvbXBsZXRpb246KicgcmVoYXNoIHRydWUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIGF1dG9tYXRpY2FsbHkgZmluZCBuZXcgZXhlY3V0YWJsZXMgaW4gcGF0aAojIFNwZWVkIHVwIGNvbXBsZXRpb25zCnpzdHlsZSAnOmNvbXBsZXRpb246KicgYWNjZXB0LWV4YWN0ICcqKE4pJwp6c3R5bGUgJzpjb21wbGV0aW9uOionIHVzZS1jYWNoZSBvbgp6c3R5bGUgJzpjb21wbGV0aW9uOionIGNhY2hlLXBhdGggfi8uY29uZmlnL3pzaC9jYWNoZQpISVNURklMRT0kWkRPVERJUi8uemhpc3RvcnkKSElTVFNJWkU9MTAwMDAKU0FWRUhJU1Q9MTAwMDAKV09SRENIQVJTPSR7V09SRENIQVJTLy9cL1smLjtdfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgRG9uJ3QgY29uc2lkZXIgY2VydGFpbiBjaGFyYWN0ZXJzIHBhcnQgb2YgdGhlIHdvcmQKIyB9fX0KIyBLZXliaW5kaW5ncyB7e3sKYmluZGtleSAtZQpiaW5ka2V5ICdeW1s3ficgYmVnaW5uaW5nLW9mLWxpbmUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBIb21lIGtleQpiaW5ka2V5ICdeW1tIJyBiZWdpbm5pbmctb2YtbGluZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBIb21lIGtleQppZiBbWyAiJHt0ZXJtaW5mb1traG9tZV19IiAhPSAiIiBdXTsgdGhlbgogIGJpbmRrZXkgIiR7dGVybWluZm9ba2hvbWVdfSIgYmVnaW5uaW5nLW9mLWxpbmUgICAgICAgICAgICAgICAgIyBbSG9tZV0gLSBHbyB0byBiZWdpbm5pbmcgb2YgbGluZQpmaQpiaW5ka2V5ICdeW1s4ficgZW5kLW9mLWxpbmUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBFbmQga2V5CmJpbmRrZXkgJ15bW0YnIGVuZC1vZi1saW5lICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgRW5kIGtleQppZiBbWyAiJHt0ZXJtaW5mb1trZW5kXX0iICE9ICIiIF1dOyB0aGVuCiAgYmluZGtleSAiJHt0ZXJtaW5mb1trZW5kXX0iIGVuZC1vZi1saW5lICAgICAgICAgICAgICAgICAgICAgICAjIFtFbmRdIC0gR28gdG8gZW5kIG9mIGxpbmUKZmkKYmluZGtleSAnXltbMn4nIG92ZXJ3cml0ZS1tb2RlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgSW5zZXJ0IGtleQpiaW5ka2V5ICdeW1szficgZGVsZXRlLWNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBEZWxldGUga2V5CmJpbmRrZXkgJ15bW0MnICBmb3J3YXJkLWNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIFJpZ2h0IGtleQpiaW5ka2V5ICdeW1tEJyAgYmFja3dhcmQtY2hhciAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBMZWZ0IGtleQpiaW5ka2V5ICdeW1s1ficgaGlzdG9yeS1iZWdpbm5pbmctc2VhcmNoLWJhY2t3YXJkICAgICAgICAgICAgICAgIyBQYWdlIHVwIGtleQpiaW5ka2V5ICdeW1s2ficgaGlzdG9yeS1iZWdpbm5pbmctc2VhcmNoLWZvcndhcmQgICAgICAgICAgICAgICAgIyBQYWdlIGRvd24ga2V5CgojIE5hdmlnYXRlIHdvcmRzIHdpdGggY3RybCthcnJvdyBrZXlzCmJpbmRrZXkgJ15bT2MnIGZvcndhcmQtd29yZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjCmJpbmRrZXkgJ15bT2QnIGJhY2t3YXJkLXdvcmQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjCmJpbmRrZXkgJ15bWzE7NUQnIGJhY2t3YXJkLXdvcmQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjCmJpbmRrZXkgJ15bWzE7NUMnIGZvcndhcmQtd29yZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjCmJpbmRrZXkgJ15IJyBiYWNrd2FyZC1raWxsLXdvcmQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIGRlbGV0ZSBwcmV2aW91cyB3b3JkIHdpdGggY3RybCtiYWNrc3BhY2UKYmluZGtleSAnXltbWicgdW5kbyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgU2hpZnQrdGFiIHVuZG8gbGFzdCBhY3Rpb24KIyB9fX0KIyBUaGVtaW5nIHt7ewphdXRvbG9hZCAtVSBjb21waW5pdCBjb2xvcnMgemNhbGMKY29tcGluaXQgLWQKY29sb3JzCgojIENvbG9yIG1hbiBwYWdlcwpleHBvcnQgTEVTU19URVJNQ0FQX21iPSQnXEVbMDE7MzJtJwpleHBvcnQgTEVTU19URVJNQ0FQX21kPSQnXEVbMDE7MzJtJwpleHBvcnQgTEVTU19URVJNQ0FQX21lPSQnXEVbMG0nCmV4cG9ydCBMRVNTX1RFUk1DQVBfc2U9JCdcRVswbScKZXhwb3J0IExFU1NfVEVSTUNBUF9zbz0kJ1xFWzAxOzQ3OzM0bScKZXhwb3J0IExFU1NfVEVSTUNBUF91ZT0kJ1xFWzBtJwpleHBvcnQgTEVTU19URVJNQ0FQX3VzPSQnXEVbMDE7MzZtJwpleHBvcnQgTEVTUz0tUgojIH19fQojIFBsdWdpbnMge3t7CiMgc3JjciB7e3sKX19zcmNyX3BsdWdsaXN0PSIiCl9fc3Jjcl9wbHVnbGlzdF91cmxzPSIiCgojIF9fc3Jjcl9pbnN0YWxsICA8cmVwb191cmw+ICA8cmVwb19uYW1lPgpfX3NyY3JfaW5zdGFsbCgpIHsKICAgIGlmIFsgLXogIiQoZmluZCAiJFpET1RESVIiIC1tYXhkZXB0aCAxIC10eXBlIGQgLW5hbWUgIiQyIikiIF07IHRoZW4KICAgICAgICBnaXQgY2xvbmUgIiQxIiAiJFpET1RESVIvJDIiCiAgICBlbHNlCiAgICAgICAgX19zcmNyX3BsdWdsaXN0PSIkMiAkX19zcmNyX3BsdWdsaXN0IgogICAgZmkKfQoKX19zcmNyX3VwZGF0ZV9vbmUoKSB7CiAgICBpZiBbIC1uICIkKGZpbmQgIiRaRE9URElSIiAtbWF4ZGVwdGggMSAtdHlwZSBkIC1uYW1lICIkMSIpIiBdOyB0aGVuCiAgICAgICAgY2QgIiQxIgogICAgICAgIF9fYnllPSIkKGdpdCBwdWxsKSIKICAgIGVsc2UKICAgICAgICBjdXJsICIkMSIgLW8gIiQoZWNobyAiJDEiIHwgc2VkIC1FICdzLy4qXC8oLiopJC9cMS8nKSIKICAgIGZpCn0KCnNyY3JfdXBncmFkZSgpIHsKICAgIF9fY3dkPSIkKHB3ZCkiCiAgICBjZCAiJFpET1RESVIiCiAgICBmb3IgcGRpciBpbiAkKGVjaG8gJF9fc3Jjcl9wbHVnbGlzdCk7IGRvCiAgICAgICAgX19zcmNyX3VwZGF0ZV9vbmUgIiRwZGlyIiAmCiAgICBkb25lCiAgICBmb3IgcGRpciBpbiAkKGVjaG8gJF9fc3Jjcl9wbHVnbGlzdF91cmxzKTsgZG8KICAgICAgICBfX3NyY3JfdXBkYXRlX29uZSAiJHBkaXIiICYKICAgIGRvbmUKICAgIGNkICIkX19jd2QiCn0KCiMgc3Jjcl9maWxlICA8c291cmNlX2ZpbGVfdXJsPgpzcmNyX2ZpbGUoKSB7CiAgICBfX2ZpbGVfbmFtZT0iJChlY2hvICIkMSIgfCBzZWQgLUUgJ3MvLipcLyguKikkL1wxLycpIgogICAgaWYgWyAtZiAiJFpET1RESVIvJF9fZmlsZV9uYW1lIiBdOyB0aGVuCiAgICAgICAgX19zcmNyX3BsdWdsaXN0X3VybHM9IiQxICRfX3NyY3JfcGx1Z2xpc3RfdXJscyIKICAgIGVsc2UKICAgICAgICBlY2hvICJHZXR0aW5nICQxIgogICAgICAgIGN1cmwgIiQxIiAtbyAiJFpET1RESVIvJF9fZmlsZV9uYW1lIgogICAgZmkKCiAgICBzb3VyY2UgIiRaRE9URElSLyRfX2ZpbGVfbmFtZSIKfQoKIyBzcmNyX3VwICA8cmVwb191cmw+ICBbcmVsX3BhdGhfdG9fc3JjX2ZpbGVdCnNyY3JfZ2l0KCkgewogICAgX19yZXBvX25hbWU9IiQoZWNobyAiJDEiIHwgc2VkIC1FICdzLy4qXC8oLiopXC5naXQvXDEvJykiCiAgICBfX3NyY3JfaW5zdGFsbCAiJDEiICIkX19yZXBvX25hbWUiCgogICAgaWYgWyAtbiAiJDIiIF07IHRoZW4KICAgICAgICBzb3VyY2UgIiRaRE9URElSLyRfX3JlcG9fbmFtZS8kMiIKICAgIGVsc2UKICAgICAgICBzb3VyY2UgIiRaRE9URElSLyRfX3JlcG9fbmFtZS8kX19yZXBvX25hbWUuenNoIgogICAgZmkKfQojIH19fQoKWlNIX0FVVE9TVUdHRVNUX0JVRkZFUl9NQVhfU0laRT0yMApaU0hfQVVUT1NVR0dFU1RfSElHSExJR0hUX1NUWUxFPSdmZz04JwpzcmNyX2dpdCAiaHR0cHM6Ly9naXRodWIuY29tL3pzaC11c2Vycy96c2gtYXV0b3N1Z2dlc3Rpb25zLmdpdCIKCiMgRW5hYmxlIGZpc2ggc3R5bGUgZmVhdHVyZXMKIyBVc2Ugc3ludGF4IGhpZ2hsaWdodGluZwpzcmNyX2dpdCAiaHR0cHM6Ly9naXRodWIuY29tL3pzaC11c2Vycy96c2gtc3ludGF4LWhpZ2hsaWdodGluZy5naXQiCgojIFVzZSBoaXN0b3J5IHN1YnN0cmluZyBzZWFyY2gKc3Jjcl9maWxlICJodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20venNoLXVzZXJzL3pzaC1oaXN0b3J5LXN1YnN0cmluZy1zZWFyY2gvbWFzdGVyL3pzaC1oaXN0b3J5LXN1YnN0cmluZy1zZWFyY2guenNoIgojIGJpbmQgVVAgYW5kIERPV04gYXJyb3cga2V5cyB0byBoaXN0b3J5IHN1YnN0cmluZyBzZWFyY2gKem1vZGxvYWQgenNoL3Rlcm1pbmZvCmJpbmRrZXkgIiR0ZXJtaW5mb1trY3V1MV0iIGhpc3Rvcnktc3Vic3RyaW5nLXNlYXJjaC11cApiaW5ka2V5ICIkdGVybWluZm9ba2N1ZDFdIiBoaXN0b3J5LXN1YnN0cmluZy1zZWFyY2gtZG93bgpiaW5ka2V5ICdeW1tBJyBoaXN0b3J5LXN1YnN0cmluZy1zZWFyY2gtdXAKYmluZGtleSAnXltbQicgaGlzdG9yeS1zdWJzdHJpbmctc2VhcmNoLWRvd24KCiMgT2ZmZXIgdG8gaW5zdGFsbCBtaXNzaW5nIHBhY2thZ2UgaWYgY29tbWFuZCBpcyBub3QgZm91bmQKIyBpZiBbWyAtciAvdXNyL3NoYXJlL3pzaC9mdW5jdGlvbnMvY29tbWFuZC1ub3QtZm91bmQuenNoIF1dOyB0aGVuCiMgICAgIHNvdXJjZSAvdXNyL3NoYXJlL3pzaC9mdW5jdGlvbnMvY29tbWFuZC1ub3QtZm91bmQuenNoCiMgICAgIGV4cG9ydCBQS0dGSUxFX1BST01QVF9JTlNUQUxMX01JU1NJTkc9MQojIGZpCgpHSVRfUFMxX1NIT1dESVJUWVNUQVRFPSd0cnVlJwpHSVRfUFMxX1NIT1dVTlRSQUNLRURGSUxFUz0ndHJ1ZScKR0lUX1BTMV9TSE9XVVBTVFJFQU09J3ZlcmJvc2UgbmFtZSBnaXQnCkdJVF9QUzFfU0hPV0NPTE9SSElOVFM9J3RydWUnCkdJVF9QUzFfSElERV9JRl9QV0RfSUdOT1JFRD0ndHJ1ZScKIyBtYWtlIGl0IHNvIHRoYXQgeW91IGNhbiBwdWxsIGp1c3QgdGhlIHNvdXJjZSBmaWxlCnNyY3JfZmlsZSAiaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2dpdC9naXQvbWFzdGVyL2NvbnRyaWIvY29tcGxldGlvbi9naXQtcHJvbXB0LnNoIgoKc3Jjcl9maWxlICJodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vY2FtZXJvbi13YWdzL2Z1enp5LWNkL21haW4vZnV6enktY2Quc2giCiMgfX19CiMgU2V0IHRlcm1pbmFsIHRpdGxlIHt7ewojIFNldCB0ZXJtaW5hbCB3aW5kb3cgYW5kIHRhYi9pY29uIHRpdGxlCiMKIyB1c2FnZTogdGl0bGUgc2hvcnRfdGFiX3RpdGxlIFtsb25nX3dpbmRvd190aXRsZV0KIwojIFNlZTogaHR0cDovL3d3dy5mYXFzLm9yZy9kb2NzL0xpbnV4LW1pbmkvWHRlcm0tVGl0bGUuaHRtbCNzczMuMQojIEZ1bGx5IHN1cHBvcnRzIHNjcmVlbiBhbmQgcHJvYmFibHkgbW9zdCBtb2Rlcm4geHRlcm0gYW5kIHJ4dnQKIyAoSW4gc2NyZWVuLCBvbmx5IHNob3J0X3RhYl90aXRsZSBpcyB1c2VkKQpmdW5jdGlvbiB0aXRsZSB7CiAgZW11bGF0ZSAtTCB6c2gKICBzZXRvcHQgcHJvbXB0X3N1YnN0CgogIFtbICIkRU1BQ1MiID09ICp0ZXJtKiBdXSAmJiByZXR1cm4KCiAgIyBpZiAkMiBpcyB1bnNldCB1c2UgJDEgYXMgZGVmYXVsdAogICMgaWYgaXQgaXMgc2V0IGFuZCBlbXB0eSwgbGVhdmUgaXQgYXMgaXMKICA6ICR7Mj0kMX0KCiAgY2FzZSAiJFRFUk0iIGluCiAgICB4dGVybSp8cHV0dHkqfHJ4dnQqfGtvbnNvbGUqfGFuc2l8bWx0ZXJtKnxhbGFjcml0dHl8c3QqKQogICAgICBwcmludCAtUG4gIlxlXTI7JHsyOnF9XGEiICMgc2V0IHdpbmRvdyBuYW1lCiAgICAgIHByaW50IC1QbiAiXGVdMTskezE6cX1cYSIgIyBzZXQgdGFiIG5hbWUKICAgICAgOzsKICAgIHNjcmVlbip8dG11eCopCiAgICAgIHByaW50IC1QbiAiXGVrJHsxOnF9XGVcXCIgIyBzZXQgc2NyZWVuIGhhcmRzdGF0dXMKICAgICAgOzsKICAgICopCiAgICAjIFRyeSB0byB1c2UgdGVybWluZm8gdG8gc2V0IHRoZSB0aXRsZQogICAgIyBJZiB0aGUgZmVhdHVyZSBpcyBhdmFpbGFibGUgc2V0IHRpdGxlCiAgICBpZiBbWyAtbiAiJHRlcm1pbmZvW2ZzbF0iIF1dICYmIFtbIC1uICIkdGVybWluZm9bdHNsXSIgXV07IHRoZW4KICAgICAgZWNob3RpIHRzbAogICAgICBwcmludCAtUG4gIiQxIgogICAgICBlY2hvdGkgZnNsCiAgICBmaQogICAgICA7OwogIGVzYWMKfQoKWlNIX1RIRU1FX1RFUk1fVEFCX1RJVExFX0lETEU9IiUxNTwuLjwlfiU8PCIgIzE1IGNoYXIgbGVmdCB0cnVuY2F0ZWQgUFdEClpTSF9USEVNRV9URVJNX1RJVExFX0lETEU9IiVuQCVtOiV+IgojIH19fQojUHJlICYgUG9zdCBleGVjIHt7ewojIFJ1bnMgYmVmb3JlIHNob3dpbmcgdGhlIHByb21wdApmdW5jdGlvbiBtemNfdGVybXN1cHBvcnRfcHJlY21kIHsKICByZXR1cm4KICAjIFVuY29tbWVudCBiZWxvdyBpZiB5b3Ugd2FudCB0aGlzIGZvciBzb21lIHJlYXNvbgogICNbWyAiJHtESVNBQkxFX0FVVE9fVElUTEU6LX0iID09IHRydWUgXV0gJiYgcmV0dXJuCiAgI3RpdGxlICRaU0hfVEhFTUVfVEVSTV9UQUJfVElUTEVfSURMRSAkWlNIX1RIRU1FX1RFUk1fVElUTEVfSURMRQp9CgojIFJ1bnMgYmVmb3JlIGV4ZWN1dGluZyB0aGUgY29tbWFuZApmdW5jdGlvbiBtemNfdGVybXN1cHBvcnRfcHJlZXhlYyB7CiAgW1sgIiR7RElTQUJMRV9BVVRPX1RJVExFOi19IiA9PSB0cnVlIF1dICYmIHJldHVybgoKICBlbXVsYXRlIC1MIHpzaAoKICAjIHNwbGl0IGNvbW1hbmQgaW50byBhcnJheSBvZiBhcmd1bWVudHMKICBsb2NhbCAtYSBjbWRhcmdzCiAgY21kYXJncz0oIiR7KHopMn0iKQogICMgaWYgcnVubmluZyBmZywgZXh0cmFjdCB0aGUgY29tbWFuZCBmcm9tIHRoZSBqb2IgZGVzY3JpcHRpb24KICBpZiBbWyAiJHtjbWRhcmdzWzFdfSIgPSBmZyBdXTsgdGhlbgogICAgIyBnZXQgdGhlIGpvYiBpZCBmcm9tIHRoZSBmaXJzdCBhcmd1bWVudCBwYXNzZWQgdG8gdGhlIGZnIGNvbW1hbmQKICAgIGxvY2FsIGpvYl9pZCBqb2JzcGVjPSIke2NtZGFyZ3NbMl0jJX0iCiAgICAjIGxvZ2ljIGJhc2VkIG9uIGpvYnMgYXJndW1lbnRzOgogICAgIyBodHRwOi8venNoLnNvdXJjZWZvcmdlLm5ldC9Eb2MvUmVsZWFzZS9Kb2JzLV8wMDI2LVNpZ25hbHMuaHRtbCNKb2JzCiAgICAjIGh0dHBzOi8vd3d3LnpzaC5vcmcvbWxhL3VzZXJzLzIwMDcvbXNnMDA3MDQuaHRtbAogICAgY2FzZSAiJGpvYnNwZWMiIGluCiAgICAgIDwtPikgIyAlbnVtYmVyIGFyZ3VtZW50OgogICAgICAgICMgdXNlIHRoZSBzYW1lIDxudW1iZXI+IHBhc3NlZCBhcyBhbiBhcmd1bWVudAogICAgICAgIGpvYl9pZD0ke2pvYnNwZWN9IDs7CiAgICAgICIifCV8KykgIyBlbXB0eSwgJSUgb3IgJSsgYXJndW1lbnQ6CiAgICAgICAgIyB1c2UgdGhlIGN1cnJlbnQgam9iLCB3aGljaCBhcHBlYXJzIHdpdGggYSArIGluICRqb2JzdGF0ZXM6CiAgICAgICAgIyBzdXNwZW5kZWQ6Kzo1MDcxPXN1c3BlbmRlZCAodHR5IG91dHB1dCkKICAgICAgICBqb2JfaWQ9JHsoaylqb2JzdGF0ZXNbKHIpKjorOipdfSA7OwogICAgICAtKSAjICUtIGFyZ3VtZW50OgogICAgICAgICMgdXNlIHRoZSBwcmV2aW91cyBqb2IsIHdoaWNoIGFwcGVhcnMgd2l0aCBhIC0gaW4gJGpvYnN0YXRlczoKICAgICAgICAjIHN1c3BlbmRlZDotOjY0OTM9c3VzcGVuZGVkIChzaWduYWwpCiAgICAgICAgam9iX2lkPSR7KGspam9ic3RhdGVzWyhyKSo6LToqXX0gOzsKICAgICAgWz9dKikgIyAlP3N0cmluZyBhcmd1bWVudDoKICAgICAgICAjIHVzZSAkam9idGV4dHMgdG8gbWF0Y2ggZm9yIGEgam9iIHdob3NlIGNvbW1hbmQgKmNvbnRhaW5zKiA8c3RyaW5nPgogICAgICAgIGpvYl9pZD0keyhrKWpvYnRleHRzWyhyKSokeyhRKWpvYnNwZWN9Kl19IDs7CiAgICAgICopICMgJXN0cmluZyBhcmd1bWVudDoKICAgICAgICAjIHVzZSAkam9idGV4dHMgdG8gbWF0Y2ggZm9yIGEgam9iIHdob3NlIGNvbW1hbmQgKnN0YXJ0cyB3aXRoKiA8c3RyaW5nPgogICAgICAgIGpvYl9pZD0keyhrKWpvYnRleHRzWyhyKSR7KFEpam9ic3BlY30qXX0gOzsKICAgIGVzYWMKCiAgICAjIG92ZXJyaWRlIHByZWV4ZWMgZnVuY3Rpb24gYXJndW1lbnRzIHdpdGggam9iIGNvbW1hbmQKICAgIGlmIFtbIC1uICIke2pvYnRleHRzWyRqb2JfaWRdfSIgXV07IHRoZW4KICAgICAgMT0iJHtqb2J0ZXh0c1skam9iX2lkXX0iCiAgICAgIDI9IiR7am9idGV4dHNbJGpvYl9pZF19IgogICAgZmkKICBmaQoKICAjIGNtZCBuYW1lIG9ubHksIG9yIGlmIHRoaXMgaXMgc3VkbyBvciBzc2gsIHRoZSBuZXh0IGNtZAogIGxvY2FsIENNRD0kezFbKHdyKV4oKj0qfHN1ZG98c3NofG1vc2h8cmFrZXwtKildOmdzLyUvJSV9CiAgbG9jYWwgTElORT0iJHsyOmdzLyUvJSV9IgoKICB0aXRsZSAnJENNRCcgJyUxMDA+Li4uPiRMSU5FJTw8Jwp9CgphdXRvbG9hZCAtVSBhZGQtenNoLWhvb2sKI2FkZC16c2gtaG9vayBwcmVjbWQgbXpjX3Rlcm1zdXBwb3J0X3ByZWNtZAphZGQtenNoLWhvb2sgcHJlZXhlYyBtemNfdGVybXN1cHBvcnRfcHJlZXhlYwojIH19fQoKCiMgTm9ybWFsbHk6IHNvdXJjZSAvdXNyL3NoYXJlL3pzaC96c2gtbWFpYS1wcm9tcHQKc2V0b3B0IHByb21wdF9zdWJzdApQUk9NUFQ9JyVCJXskZmdbY3lhbl0lfSUoNH58JS0xfi8uLi4vJTJ+fCV+KSV1ICUoPy4leyRmZ1tjeWFuXSV9LiV7JGZnW3JlZF0lfSk+JXskcmVzZXRfY29sb3IlfSViICcKUlBST01QVD0nJChfX2dpdF9wczEgIiAoJXMpIiknCgplY2hvICRVU0VSQCRIT1NUICcgICAnICQodW5hbWUgLXNyKQoK" \
    | base64 -d > "$TARGET_DIR/.zshrc"
# }}}

# zprofile dump {{{
which nvim && EDITOR="$(which nvim)"
echo "
export EDITOR=\"$EDITOR\"
export VISUAL=\"$EDITOR\"

export PATH=\"$PATH:$HOME/bin:$HOME/.local/bin:.\"

export ZDOTDIR=\"$TARGET_DIR\"
" > "$TARGET_DIR/.zprofile"
# }}}

ln -s "$TARGET_DIR/.zprofile" "$HOME/.zprofile"

