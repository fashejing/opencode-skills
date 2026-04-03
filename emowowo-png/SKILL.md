---
name: emowowo-png
description: 批量将非PNG格式图片转换为PNG格式
license: Unlicense
Compatibility: opencode
metadata:
  author: emowowo
  version: 1.0.0
  category: image-conversion
---

# emowowo-png - 图片格式转换工具

批量将非PNG格式的图片转换为PNG格式。

## 功能

- 批量转换图片格式为PNG
- 支持常见图片格式：JPG、JPEG、BMP、GIF、WebP、TIFF等
- 输出到指定文件夹
- 保留原文件名

## 使用流程

### Step 1: 收集用户输入

向用户收集以下参数：

| 参数 | 说明 | 示例 |
|------|------|------|
| 输入文件夹 | 包含非PNG图片的文件夹路径 | C:/Users/ASUS/Images |
| 输出文件夹 | 保存PNG文件的文件夹路径 | C:/Users/ASUS/Output |

### Step 2: 转换图片

1. 遍历输入文件夹中的所有图片文件
2. 使用Python Pillow库读取图片
3. 转换为PNG格式
4. 保存到输出文件夹

### Step 3: 输出结果

显示转换成功的文件数量和输出路径。

## Python实现

```python
import os
from PIL import Image
from pathlib import Path

def convert_to_png(input_folder, output_folder):
    Path(output_folder).mkdir(parents=True, exist_ok=True)
    
    supported_formats = {'.jpg', '.jpeg', '.bmp', '.gif', '.webp', '.tiff', '.tif'}
    converted_count = 0
    
    for file in os.listdir(input_folder):
        file_path = os.path.join(input_folder, file)
        if os.path.isfile(file_path):
            ext = Path(file).suffix.lower()
            if ext in supported_formats:
                try:
                    img = Image.open(file_path)
                    output_path = os.path.join(output_folder, Path(file).stem + '.png')
                    img.save(output_path, 'PNG')
                    converted_count += 1
                    print(f'已转换: {file} -> {Path(file).stem}.png')
                except Exception as e:
                    print(f'转换失败 {file}: {e}')
    
    print(f'\n转换完成！共转换 {converted_count} 个文件')
    print(f'输出文件夹: {output_folder}')

if __name__ == '__main__':
    input_folder = input('请输入输入文件夹路径: ')
    output_folder = input('请输入输出文件夹路径: ')
    convert_to_png(input_folder, output_folder)
```

## 注意事项

1. 需要安装Pillow库：`pip install Pillow`
2. 只会转换非PNG格式的图片文件
3. PNG文件会被跳过
4. 如果输出文件夹不存在，会自动创建