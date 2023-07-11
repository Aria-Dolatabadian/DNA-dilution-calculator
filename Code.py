# Ask for initial concentration, desired concentration, and volume
initial_concentration = float(input("Enter the initial DNA concentration (ng/µl): "))
desired_concentration = float(input("Enter the desired final DNA concentration (ng/µl): "))
final_volume = float(input("Enter the final volume (µl): "))

# Calculate the dilution factor
dilution_factor = initial_concentration / desired_concentration

# Calculate the volume of DNA and water needed for dilution
volume_dna = final_volume / dilution_factor
volume_water = final_volume - volume_dna


# Print the volume of DNA and water
print("Volume of DNA needed: ", volume_dna, " µl")
print("Volume of water needed: ", volume_water, " µl")
