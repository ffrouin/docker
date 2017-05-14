-- -----------------------------------------------------------------------------
-- OpenSi : Outils libres de gestion d'entreprise                             --
-- Copyright (C) 2003 Speedinfo.fr S.A.R.L.                                   --
-- Contact: contact@opensi.org                                                --
--                                                                            --
-- This program is free software; you can redistribute it and/or              --
-- modify it under the terms of the GNU General Public License                --
-- as published by the Free Software Foundation; either version 2             --
-- of the License, or (at your option) any later version.                     --
--                                                                            --
-- This program is distributed in the hope that it will be useful,            --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of             --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the               --
-- GNU General Public License for more details.                               --
--                                                                            --
-- You should have received a copy of the GNU General Public License          --
-- along with this program; if not, write to the Free Software                --
-- Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. --
-- -----------------------------------------------------------------------------

-- Insertions par d�faut lors de l'installation d'OpenSi

insert into ENTREPRISE (Entreprise_Id,Identifiant,Denomination,Actif,Email,No_Mail,Telephone,Responsable) Values (1,'root','root',1,'',1,'','root');
insert into UTILISATEUR (Login, Password, Nom, Prenom, Administrateur,Entreprise_id) values ('root', '63a9f0ea7bb98050796b649e85481845', 'root', 'root', 1, 1);

-- Exports disponibles
insert into EXPORT (Export_Id, Nom_Export) values (1, 'OpenSi');
insert into EXPORT (Export_Id, Nom_Export) values (2, 'Quadra');
insert into EXPORT (Export_Id, Nom_Export) values (4, 'Ciel');
insert into EXPORT (Export_Id, Nom_Export) values (5, 'Tableur');
insert into EXPORT (Export_Id, Nom_Export) values (6, 'Sage');

insert into FORMAT_EXPORT (Code_Export, Export_Id, Nom_Format) values ('CE_OPENSI_XML', 1,'Comptes + Ecritures (xml)');
insert into FORMAT_EXPORT (Code_Export, Export_Id, Nom_Format) values ('E_QUADRA_ASC', 2,'Ecritures (ascii)');
insert into FORMAT_EXPORT (Code_Export, Export_Id, Nom_Format) values ('C_QUADRA_ASC', 2,'Comptes (ascii)');
insert into FORMAT_EXPORT (Code_Export, Export_Id, Nom_Format) values ('CE_QUADRA_ASC', 2,'Comptes + Ecritures (ascii)');
insert into FORMAT_EXPORT (Code_Export, Export_Id, Nom_Format) values ('E_CIEL_ASC', 4,'Ecritures (ascii)');
insert into FORMAT_EXPORT (Code_Export, Export_Id, Nom_Format) values ('E_TABLEUR_ASC',5 ,'Ecritures (ascii)');
insert into FORMAT_EXPORT (Code_Export, Export_Id, Nom_Format) values ('E_SAGE_ASC',6 ,'Ecritures (ascii)');


insert into FORMAT_EXPORT_COMPTA (Intitule, Code_Export, Dispo_GC, Dispo_MC) values ('Cador Dorac', 'CADOR', 1, 0);


-- Imports disponibles
insert into IMPORT (Import_Id, Nom_Import) values (1, 'OpenSi');
insert into IMPORT (Import_Id, Nom_Import) values (2, 'Quadra');
insert into IMPORT (Import_Id, Nom_Import) values (3, 'Csv');
insert into IMPORT (Import_Id, Nom_Import) values (4, 'Agave');

insert into FORMAT_IMPORT (Code_Import, Import_Id, Nom_Format) values ('CE_OPENSI_XML', 1,'Comptes + Ecritures (xml)');
insert into FORMAT_IMPORT (Code_Import, Import_Id, Nom_Format) values ('CE_QUADRA_ASC', 2,'Comptes + Ecritures (ascii)');
insert into FORMAT_IMPORT (Code_Import, Import_Id, Nom_Format) values ('CE_CSV_ASC', 3,'Factures (ascii)');
insert into FORMAT_IMPORT (Code_Import, Import_Id, Nom_Format) values ('CE_AGAVE_ASC', 4,'Ecritures �dition journaux (ascii)');

insert into CIVILITE (Civ_Id, Civ_Courte, Civ_Longue) values (0, '', '');
insert into CIVILITE (Civ_Id, Civ_Courte, Civ_Longue) values (1, 'M.', 'Monsieur');
insert into CIVILITE (Civ_Id, Civ_Courte, Civ_Longue) values (2, 'Mme', 'Madame');
insert into CIVILITE (Civ_Id, Civ_Courte, Civ_Longue) values (3, 'Mlle', 'Mademoiselle');

insert into ORDRE_JOURNAUX (Type_Journal, Ordre_Affichage) values ('AN',1);
insert into ORDRE_JOURNAUX (Type_Journal, Ordre_Affichage) values ('AC',2);
insert into ORDRE_JOURNAUX (Type_Journal, Ordre_Affichage) values ('VE',3);
insert into ORDRE_JOURNAUX (Type_Journal, Ordre_Affichage) values ('TR',4);
insert into ORDRE_JOURNAUX (Type_Journal, Ordre_Affichage) values ('OD',5);
insert into ORDRE_JOURNAUX (Type_Journal, Ordre_Affichage) values ('',6);


insert into SEUIL_CA_TVA (Code_Pays, Seuil) values
('BE', 35000),
('BG', 35791),
('CZ', 37622),
('DK', 37551),
('DE', 100000),
('EE', 35151),
('GR', 35000),
('ES', 35000),
('IE', 35000),
('IT', 27889),
('CY', 35000),
('LV', 34433),
('LT', 36203),
('LU', 100000),
('HU', 34671),
('MT', 35000),
('NL', 100000),
('AT', 100000),
('PL', 44426),
('RO', 32702),
('PT', 35000),
('SI', 35000),
('SK', 44642),
('FI', 35000),
('SE', 33869),
('GB', 95264);



insert into DEB_TRANSACTION (Code_Transaction_A, Code_Transaction_B, Libelle) values
(1, 1, 'Achat/vente ferme'),
(1, 2, 'Livraison pour vente � vue ou � l''essai, pour consignation ou avec l''interm�diaire d''un agent commissionn�'),
(1, 3, 'Troc (compensation en nature)'),
(1, 4, 'Achats personnels des voyageurs'),
(1, 5, 'Leasing financier (location-vente)'),
(2, 1, 'Envois en retour de marchandises'),
(2, 2, 'Remplacement de marchandises retourn�es'),
(2, 3, 'Remplacement (par ex. sous garantie) de marchandises non retourn�es'),
(3, 1, 'Marchandises fournies dans le cadre de programmes d''aide command�s ou financ�s en partie ou totalement par la Communaut� europ�enne'),
(3, 2, 'Autre aide gouvernementale'),
(3, 3, 'Autre aide (priv�e, organisation non gouvernementale)'),
(3, 4, 'Autres'),
(4, 1, 'Pour travail � fa�on'),
(4, 2, 'Pour r�paration et entretien � titre on�reux'),
(4, 3, 'Pour r�paration et entretien � titre gratuit'),
(5, 1, 'Suite � travail � fa�on'),
(5, 2, 'Suite � r�paration et entretien � titre on�reux'),
(5, 3, 'Suite � r�paration et entretien � titre gratuit'),
(6, 1, 'Location, pr�t, leasing op�rationnel'),
(6, 2, 'Autres usages temporaires'),
(7, 0, 'Op�rations au titre d''un programme commun de d�fense ou d''un autre programme intergouvernemental de fabrication coordonn�e (par ex. Airbus)'),
(8, 0, 'Fourniture de mat�riaux et d''�quipements dans le cadre d''un contrat g�n�ral de construction ou de g�nie civil'),
(9, 0, 'Autres transactions');


insert into DEB_CONDITION_LIVRAISON (Code_Livraison, Libelle) values
('EXW', 'A l''usine'),
('FCA', 'Franco transporteur'),
('FAS', 'Franco le long du navire'),
('FAB', 'Franco � bord'),
('CIP', 'Port pay�, assurance comprise jusqu''�...'),
('DAF', 'Rendu fronti�re'),
('DES', 'Rendu "ex-ship"'),
('DEQ', 'Rendu � quai'),
('CFR', 'Co�t et fret (C & F)'),
('CIF', 'Co�t, assurance et fret (CAF)'),
('CPT', 'Port pay� jusqu''�'),
('DDU', 'Rendu droits non acquitt�s'),
('DDP', 'Rendu droits acquitt�s');


insert into DEB_MODE_TRANSPORT (Code_Transport, Libelle) values
(1, 'Transport maritime'),
(2, 'Transport par chemin de fer'),
(3, 'Transport par route'),
(4, 'Transport par air'),
(5, 'Envois postaux'),
(7, 'Installations de transport fixes'),
(8, 'Transport par navigation int�rieure'),
(9, 'Propulsion propre');


insert into DEB_REGIME (Code_Regime, Libelle, Type_Regime) values
(11, 'Acquisition intracommunautaire taxable en France', 0),
(19, 'Autres introductions : en vue d''un travail � fa�on ou d''une r�paration, en suite de r�paration ou de travail � fa�on, achats en franchise de TVA', 0),
(21, 'Livraison exon�r�e et transfert', 1),
(25, 'R�gularisation commerciale entra�nant une minoration de valeur (rabais, remise, avoir...)', 1),
(26, 'R�gularisation commerciale entra�nant une majoration de valeur (majoration de prix...)', 1),
(29, 'Autres exp�ditions : pour r�paration et en suite de r�paration, pour travail � fa�on et en suite de travail � fa�on, ventes � distance taxables dans l''�tat membre d''arriv�e, ventes avec installation ou montage...', 1),
(31, 'Refacturation dans le cadre d''une op�ration triangulaire. Facturation de biens � un donneur d''ordre, �tabli dans un autre �tat membre, les biens faisant l''objet d''une prestation de services en France.', 1);


insert into MONNAIE_DEVISE (Valeur, Type, Qte_Remise, Devise_Id) values
(500, 'B', 20, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(200, 'B', 20, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(100, 'B', 20, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(50, 'B', 20, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(20, 'B', 20, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(10, 'B', 20, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(5, 'B', 20, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(2, 'P', 25, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(1, 'P', 25, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(0.5, 'P', 40, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(0.2, 'P', 40, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(0.1, 'P', 40, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(0.05, 'P', 50, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(0.02, 'P', 50, (select Devise_Id from DEVISE where Code_Alpha='EUR')),
(0.01, 'P', 50, (select Devise_Id from DEVISE where Code_Alpha='EUR'));


