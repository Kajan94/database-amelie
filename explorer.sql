-- Périmètre des prescriptions présentes dans le fichier.
SELECT MIN(Annee) AS premiere_annee, MAX(Annee) AS derniere_annee,
       COUNT(*) AS lignes
FROM Prescriptions;

-- Contrôle de cohérence entre les départements référencés et leurs régions.
SELECT COUNT(*) AS departements_sans_region
FROM Departements AS d
LEFT JOIN Regions AS r ON r.Id_Region = d.Id_Region
WHERE d.Id_Region IS NOT NULL AND r.Id_Region IS NULL;

-- Prescriptions 2023, un total régional comparable par ligne.
SELECT r.libelle_region AS region,
       p.montant_total_prescription_integer AS montant_euros
FROM Prescriptions AS p
JOIN Regions AS r ON r.Id_Region = p.Id_Region
WHERE p.Annee = 2023
  AND p.Num_Departement = 999
  AND p.Profession_sante = 'Ensemble des médecins'
  AND p.poste_prescription = 'total'
  AND r.Id_Region <> 99
  AND typeof(p.montant_total_prescription_integer) = 'integer'
ORDER BY montant_euros DESC;
