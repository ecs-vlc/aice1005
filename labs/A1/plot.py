import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import sys

def plot_with_error_bars_and_fit(csv_file):
    # Read the CSV file
    try:
        data = pd.read_csv(csv_file)
    except Exception as e:
        print(f"Error reading the CSV file: {e}")
        sys.exit(1)

    print(data.columns)
    # Check if required columns exist
    if not {'n', 't', 'dt'}.issubset(data.columns):
        print("Error: The CSV file must contain 'n', 't', and 'dt' columns.")
        sys.exit(1)

    # Extract columns
    n = data['n']
    t = data['t']
    dt = data['dt']

    # Perform quadratic fit
    coefficients = np.polyfit(n, t, 2)
    quadratic_fit = np.poly1d(coefficients)

    # Generate fitted values
    n_fit = np.linspace(min(n), max(n), 500)
    t_fit = quadratic_fit(n_fit)

    # Plot t against n with error bars
    plt.errorbar(n, t, yerr=dt, fmt='o', ecolor='red', capsize=5, label='t vs n')

    # Plot the quadratic fit
    plt.plot(n_fit, t_fit, label=f'Quadratic Fit: {coefficients[0]:.2g}n² + {coefficients[1]:.2g}n + {coefficients[2]:.2g}', color='blue')

    # Add a text box with the quadratic fit equation
    fit_text = f"Fit: {coefficients[0]:.2g}n² + {coefficients[1]:.2g}n + {coefficients[2]:.2g}"
    plt.text(0.05, 0.95, fit_text, transform=plt.gca().transAxes, fontsize=10, verticalalignment='top', bbox=dict(boxstyle='round', facecolor='white', alpha=0.8))

    # Add labels and legend
    plt.xlabel('n')
    plt.ylabel('t')
    plt.title('Plot of t against n with Error Bars and Quadratic Fit')
    plt.legend()
    plt.grid(True)
    plt.show()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python plot_with_error_bars.py <csv_file>")
        sys.exit(1)

    csv_file = sys.argv[1]
    plot_with_error_bars_and_fit(csv_file)
