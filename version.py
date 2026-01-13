import re, sys, urllib.request

html = (
    urllib.request.urlopen("https://mikrotik.com/download/winbox")
    .read()
    .decode("utf-8", "replace")
)
ver = re.search(r"####\s*v(4\.[0-9A-Za-z]+)", html).group(1)
sha = (
    re.search(
        r"Linux\s*\(64-bit\).*?SHA256\s*([0-9a-f]{64})", html, re.IGNORECASE | re.DOTALL
    )
    .group(1)
    .lower()
)
print(f'echo "WINBOX_VERSION={ver}"')
print(f'echo "WINBOX_SHA256={sha}"')
