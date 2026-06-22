import os

def fix_mojibake(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Encode as cp932 (Shift-JIS) to get original utf-8 bytes
        original_bytes = content.encode('cp932')
        # Decode as utf-8
        fixed_content = original_bytes.decode('utf-8')
        
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(fixed_content)
        print(f"Fixed {file_path}")
    except Exception as e:
        print(f"Skipped {file_path}: {e}")

directory = r"C:\Users\cocon\.gemini\antigravity\scratch\real_estate_portfolio\src\blog"
for filename in os.listdir(directory):
    if filename.endswith(".md"):
        fix_mojibake(os.path.join(directory, filename))
