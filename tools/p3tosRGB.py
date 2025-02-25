import numpy as np
import plistlib
import sys

def convert_p3_to_srgb(r, g, b):
    # Transformation matrix from Display P3 to sRGB
    p3_to_srgb = np.array([
        [1.2249, -0.2247,  0.0000],
        [-0.0421, 1.0419,  0.0000],
        [-0.0197, -0.0786, 1.0979]
    ])
    
    # Convert color
    rgb_p3 = np.array([r, g, b])
    rgb_srgb = np.dot(p3_to_srgb, rgb_p3)
    
    # Clamp values to [0,1] range
    rgb_srgb = np.clip(rgb_srgb, 0, 1)
    return rgb_srgb.tolist()

def process_plist(file_path):
    # Load plist
    with open(file_path, 'rb') as f:
        plist = plistlib.load(f)
    
    # Convert colors
    for key, value in plist.items():
        if isinstance(value, dict) and "Color Space" in value and value["Color Space"] == "P3":
            r, g, b = value["Red Component"], value["Green Component"], value["Blue Component"]
            new_r, new_g, new_b = convert_p3_to_srgb(r, g, b)
            
            # Update values
            value["Red Component"] = new_r
            value["Green Component"] = new_g
            value["Blue Component"] = new_b
            value["Color Space"] = "sRGB"  # Change color space identifier
    
    # Save updated plist
    output_path = file_path.replace(".plist", "_converted.plist")
    with open(output_path, 'wb') as f:
        plistlib.dump(plist, f)
    
    print("Conversion completed. Saved as", output_path)

def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py <path_to_plist>")
        sys.exit(1)
    
    file_path = sys.argv[1]
    process_plist(file_path)

if __name__ == "__main__":
    main()
