import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os

# Define a function to get the base directory of this script
def get_base_dir():
    return os.path.dirname(os.path.abspath(__file__))  # Use os.path.abspath to ensure compatibility

def load_ltspice_data(filepath):
    # Load LTSpice simulation data
    with open(filepath, 'r', encoding='ISO-8859-1') as file:
        lines = file.readlines()
    
    frequency = []
    magnitude = []
    phase = []
    
    for line in lines[1:]:
        parts = line.split('\t')
        freq = float(parts[0])
        mag = float(parts[1].split('dB')[0].strip('()'))
        ph = float(parts[1].split('dB,')[1].strip('()°\n'))
        
        frequency.append(freq)
        magnitude.append(mag)
        phase.append(ph)
    
    ltspice_data = pd.DataFrame({
        'Frequency (Hz)': frequency,
        'Magnitude (dB)': magnitude,
        'Phase (deg)': phase
    })

    # Adjust phase to account for phase margin (180 degrees)
    ltspice_data['Phase (deg)'] = np.unwrap(np.deg2rad(ltspice_data['Phase (deg)'] - 180)) * (180 / np.pi)
    
    print("LTSpice Data:")
    print(ltspice_data.head())
    
    return ltspice_data

def load_matlab_data(filepath):
    # Load MATLAB simulation data
    matlab_data = pd.read_csv(filepath)
    matlab_data.columns = matlab_data.columns.str.strip()
    matlab_data = matlab_data.rename(columns={
        'Frequency': 'Frequency (Hz)',
        'Magnitude_dB': 'Magnitude (dB)',
        'Phase_deg': 'Phase (deg)'
    })
    
    print("MATLAB Data:")
    print(matlab_data.head())
    
    return matlab_data

def plot_data_comparison(ltspice_filepath, matlab_filepath):
    ltspice_data = load_ltspice_data(ltspice_filepath)
    matlab_data = load_matlab_data(matlab_filepath)

    plt.figure(figsize=(14, 6))

    # Magnitude Comparison
    plt.subplot(1, 2, 1)
    plt.semilogx(ltspice_data['Frequency (Hz)'], ltspice_data['Magnitude (dB)'], label='LTSpice Magnitude')
    plt.semilogx(matlab_data['Frequency (Hz)'], matlab_data['Magnitude (dB)'], label='MATLAB Magnitude', linestyle=':')
    plt.axvline(x=50000, color='red', linestyle='--', linewidth=1)  # Add a vertical line at 50kHz
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Magnitude (dB)')
    plt.title('Magnitude Comparison')
    plt.legend()

    # Phase Comparison
    plt.subplot(1, 2, 2)
    plt.semilogx(ltspice_data['Frequency (Hz)'], ltspice_data['Phase (deg)'], label='LTSpice Phase')
    plt.semilogx(matlab_data['Frequency (Hz)'], matlab_data['Phase (deg)'], label='MATLAB Phase', linestyle=':')
    plt.axvline(x=50000, color='red', linestyle='--', linewidth=1)  # Add a vertical line at 50kHz
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Phase (deg)')
    plt.title('Phase Comparison')
    plt.legend()

    plt.tight_layout()
    plt.savefig('comparison_plot.png')
    plt.show()

# Generate file paths dynamically
base_dir = get_base_dir()
ltspice_filepath = os.path.join(base_dir, 'LTSpice-Simulation.txt')
matlab_filepath = os.path.join(base_dir, 'Matlab-Simualtion.csv')

# Example usage
plot_data_comparison(ltspice_filepath, matlab_filepath)
