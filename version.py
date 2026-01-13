#!/usr/bin/env python3
import re, sys, urllib.request

URL = "https://mikrotik.com/download/winbox"
UA = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120 Safari/537.36"

req = urllib.request.Request(
    URL, headers={"User-Agent": UA, "Accept-Language": "en-US,en;q=0.9"}
)
html = urllib.request.urlopen(req).read().decode("utf-8", "replace")

betas = [(int(n), f"4.0beta{n}") for n in re.findall(r"\bv4\.0beta(\d+)\b", html)]
if not betas:
    print("Failed to detect WinBox v4 beta version from page", file=sys.stderr)
    sys.exit(1)
_, ver = max(betas, key=lambda x: x[0])

msha = re.search(
    r"WinBox_Linux\.zip.{0,1000}?([0-9a-f]{64})", html, re.IGNORECASE | re.DOTALL
)
if not msha:
    print(
        "Failed to detect Linux SHA256 for WinBox_Linux.zip from page", file=sys.stderr
    )
    # Helpful debug: show the area around the filename
    idx = html.lower().find("winbox_linux.zip")
    if idx != -1:
        snippet = html[max(0, idx - 200) : idx + 1200]
        print(
            "\n--- debug snippet around WinBox_Linux.zip ---\n",
            snippet,
            "\n--- end ---\n",
            file=sys.stderr,
        )
    sys.exit(1)

sha = msha.group(1).lower()

print(f"WINBOX_VERSION={ver}")
print(f"WINBOX_SHA256={sha}")
