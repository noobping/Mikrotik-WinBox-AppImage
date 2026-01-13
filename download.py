import re, sys, urllib.request

url = "https://mikrotik.com/download/winbox"
html = urllib.request.urlopen(url).read().decode("utf-8", "replace")

# Version is shown like: #### v4.0beta44
mver = re.search(r"####\s*v(4\.[0-9A-Za-z]+)", html)
if not mver:
    print("Failed to detect WinBox v4 version from page", file=sys.stderr)
sys.exit(1)
ver = mver.group(1)

# Linux SHA256 is shown in the Linux block. We anchor around "Linux (64-bit)" then find a 64-hex hash.
linux_block = re.search(
    r"Linux\s*\(64-bit\).*?SHA256\s*([0-9a-f]{64})", html, re.IGNORECASE | re.DOTALL
)
if not linux_block:
    print("Failed to detect Linux SHA256 from page", file=sys.stderr)
sys.exit(1)
sha = linux_block.group(1).lower()

print(f"WINBOX_VERSION={ver}")
print(f"WINBOX_SHA256={sha}")
