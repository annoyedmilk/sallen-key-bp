import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

def get_base_dir():
    return Path(__file__).parent

def load_ltspice_data(filepath):
    try:
        with open(filepath, 'r', encoding='ISO-8859-1') as file:
            lines = file.readlines()
        
        frequency = []
        magnitude = []
        phase = []
        
        for line in lines[1:]:
            parts = line.split('\t')
            if len(parts) >= 2:
                freq = float(parts[0])
                mag_phase = parts[1].split('dB,')
                mag = float(mag_phase[0].strip('()'))
                ph = float(mag_phase[1].strip('()°\n'))
                
                frequency.append(freq)
                magnitude.append(mag)
                phase.append(ph)
        
        ltspice_data = pd.DataFrame({
            'Frequency (Hz)': frequency,
            'Magnitude (dB)': magnitude,
            'Phase (deg)': phase
        })

        ltspice_data['Phase (deg)'] = np.unwrap(np.deg2rad(ltspice_data['Phase (deg)'] - 180)) * (180 / np.pi)
        
        print("LTSpice Data:")
        print(ltspice_data.head())
        
        return ltspice_data
    except Exception as e:
        print(f"Error loading LTSpice data: {e}")
        return pd.DataFrame()

def load_matlab_data(filepath):
    try:
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
    except Exception as e:
        print(f"Error loading MATLAB data: {e}")
        return pd.DataFrame()

def load_picoscope_data(filepath):
    try:
        picoscope_data = pd.read_csv(filepath)
        picoscope_data.columns = picoscope_data.columns.str.strip()
        picoscope_data = picoscope_data.rename(columns={
            'Frequency Log(Hz)': 'Frequency Log(Hz)',
            'Gain (dB)': 'Magnitude (dB)',
            'Phase (deg)': 'Phase (deg)'
        })
        
        # Convert logarithmic frequency to linear frequency
        picoscope_data['Frequency (Hz)'] = 10 ** picoscope_data['Frequency Log(Hz)']
        
        print("Picoscope Data:")
        print(picoscope_data.head())
        
        return picoscope_data
    except Exception as e:
        print(f"Error loading Picoscope data: {e}")
        return pd.DataFrame()

def plot_data_comparison(ltspice_filepath, matlab_filepath, picoscope_filepath):
    ltspice_data = load_ltspice_data(ltspice_filepath)
    matlab_data = load_matlab_data(matlab_filepath)
    picoscope_data = load_picoscope_data(picoscope_filepath)

    plt.figure(figsize=(18, 6))

    # Magnitude Comparison
    plt.subplot(1, 1, 1)
    plt.semilogx(ltspice_data['Frequency (Hz)'], ltspice_data['Magnitude (dB)'], label='LTSpice Magnitude')
    plt.semilogx(matlab_data['Frequency (Hz)'], matlab_data['Magnitude (dB)'], label='MATLAB Magnitude', linestyle=':')
    plt.semilogx(picoscope_data['Frequency (Hz)'], picoscope_data['Magnitude (dB)'], label='Picoscope Magnitude', linestyle='--')
    plt.axvline(x=50000, color='red', linestyle='--', linewidth=1)  # Add a vertical line at 50kHz
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Magnitude (dB)')
    plt.title('Magnitude Comparison')
    plt.legend()

    plt.tight_layout()
    plt.savefig('comparison_plot.png')
    plt.show()

# Generate file paths dynamically
base_dir = get_base_dir()
ltspice_filepath = base_dir / 'LTSpice-Simulation.txt'
matlab_filepath = base_dir / 'Matlab-Simualtion.csv'
picoscope_filepath = base_dir / 'outputsallen-key-overall.csv'

# Example usage
plot_data_comparison(ltspice_filepath, matlab_filepath, picoscope_filepath)