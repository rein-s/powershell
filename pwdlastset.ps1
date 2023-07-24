# Vervang "C:\Pad\Naar\Bestand.txt" met het pad naar je eigen tekstbestand met gebruikersnamen.
$gebruikersBestand = "C:\Pad\Naar\Bestand.txt"

# Functie om de gebruikersgegevens op te halen en weer te geven.
function Get-ADUserPasswordLastSet {
    param([string]$gebruikersnaam)

    try {
        # Verbinding maken met Active Directory.
        Import-Module ActiveDirectory
    } catch {
        Write-Host "Kan de Active Directory-module niet laden. Zorg ervoor dat RSAT (Remote Server Administration Tools) is geïnstalleerd."
        return
    }

    # De gebruikersinformatie ophalen.
    $gebruiker = Get-ADUser $gebruikersnaam -Properties PasswordLastSet

    # Als de gebruiker is gevonden, de "PasswordLastSet" eigenschap weergeven.
    if ($gebruiker) {
        $gebruikersnaam + ": " + $gebruiker.PasswordLastSet
    } else {
        $gebruikersnaam + ": Gebruiker niet gevonden in Active Directory."
    }
}

# Controleren of het opgegeven bestand bestaat.
if (Test-Path $gebruikersBestand) {
    # De inhoud van het bestand lezen en elke regel behandelen als een gebruikersnaam.
    $gebruikersnamen = Get-Content $gebruikersBestand

    # Loop door de lijst met gebruikers en roep de functie aan om de "PasswordLastSet" op te halen en weer te geven.
    foreach ($gebruikersnaam in $gebruikersnamen) {
        Get-ADUserPasswordLastSet $gebruikersnaam
    }
} else {
    Write-Host "Het opgegeven bestand bestaat niet: $gebruikersBestand"
}
