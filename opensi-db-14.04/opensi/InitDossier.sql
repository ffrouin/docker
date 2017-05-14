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

-- Insertions par défaut lors de la création d'un dossier en base dossier


-- Journaux par défaut
insert into JOURNAL (Code_Journal, Intitule, Type_Journal, Contrepartie) values
('AN','A NOUVEAU','AN',NULL),
('AC','ACHATS','AC',NULL),
('VE','VENTES','VE',NULL);


-- Comptes par défaut
insert into COMPTE (Numero_Compte, Intitule, Type_Compte, Centralisateur) values
('40100000','COLLECTIF FOURNISSEURS','G',1),
('41100000','COLLECTIF CLIENTS','G',1),
('12000000','COMPTE DE RESULTAT','G',0),
('44566100','TVA SUR ACHAT 2.1%','G',0),
('44571100','TVA SUR VENTE 2.1%','G',0),
('44566200','TVA SUR ACHAT 5.5%','G',0),
('44571200','TVA SUR VENTE 5.5%','G',0),
('44566300','TVA SUR ACHAT 19.6%','G',0),
('44571300','TVA SUR VENTE 19.6%','G',0),
('44537000','TVA SUR VENTE UNION EUROPEENNE','G',0),
('51200000','BANQUE','G',0),
('53000000','CAISSE','G',0),
('60700000','ACHATS DE MARCHANDISES','G',0),
('62410000','FRAIS DE PORT SUR ACHAT','G',0),
('70700000','VENTES DE MARCHANDISES','G',0),
('70850000','FRAIS DE PORT SUR VENTE','G',0),
('76500000','ESCOMPTES OBTENUS','G',0),
('66500000','ESCOMPTES ACCORDES','G',0),
('75800000','PRODUITS DIVERS DE GESTION COURANTE','G',0),
('65800000','CHARGES DIVERSES DE GESTION COURANTE','G',0),
('44520000','TVA DUE INTRACOMMUNAUTAIRE','G',0),
('44566400','TVA DEDUCTIBLE SUR BIENS ET SERVICES UNION EUROPEENNE','G',0),
('41910000','AVANCES ET ACOMPTES RECUS SUR COMMANDE','G',0),
('40910000','AVANCES ET ACOMPTES VERSES SUR COMMANDE','G',0),
('47200000','ECRITURES DE BANQUE EN ATTENTE','G',0),
('58000000','VIREMENTS INTERNES','G',0);

insert into COMPTE (Numero_Compte, Intitule, Type_Compte, Centralisateur,Collectif) values
('01000000','CLIENTS DIVERS','C',0,'41100000'),
('08000000','FOURNISSEURS DIVERS','F',0,'40100000');

insert into TRANCHE_COLLECTIF (Min_Compte, Max_Compte) values ('40100000', '40100000');
insert into TRANCHE_COLLECTIF (Min_Compte, Max_Compte) values ('41100000', '41100000');

-- Taux de TVA france
insert into TAUX_TVA (Code_TVA, Taux_TVA, Taux_NPR, Compte_TVA_Achat, Compte_TVA_Vente, Compte_Achat, Compte_Vente, Normal) values
(1, 0, 0, NULL, NULL, '60700000', '70700000', 0),
(2, 2.1, 0, '44566100', '44571100', '60700000', '70700000', 0),
(3, 5.5, 0, '44566200', '44571200', '60700000', '70700000', 0),
(4, 19.6, 0, '44566300', '44571300', '60700000', '70700000', 1);

alter table COMPTE add constraint cfk_compte_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA);


-- Taux de TVA européens (taux normaux)
insert into TAUX_TVA (Code_Pays, Taux_TVA, Compte_TVA_Vente, Compte_Vente, Compte_Achat, Normal) values
('AT', 20, '44537000', '70700000', '60700000', 1),
('BE', 21, '44537000', '70700000', '60700000', 1),
('BG', 20, '44537000', '70700000', '60700000', 1),
('CY', 15, '44537000', '70700000', '60700000', 1),
('CZ', 19, '44537000', '70700000', '60700000', 1),
('DE', 16, '44537000', '70700000', '60700000', 1),
('DK', 25, '44537000', '70700000', '60700000', 1),
('EE', 18, '44537000', '70700000', '60700000', 1),
('ES', 16, '44537000', '70700000', '60700000', 1),
('FI', 22, '44537000', '70700000', '60700000', 1),
('GB', 17.5, '44537000', '70700000', '60700000', 1),
('GR', 19, '44537000', '70700000', '60700000', 1),
('HU', 20, '44537000', '70700000', '60700000', 1),
('IE', 21, '44537000', '70700000', '60700000', 1),
('IT', 20, '44537000', '70700000', '60700000', 1),
('LT', 18, '44537000', '70700000', '60700000', 1),
('LU', 15, '44537000', '70700000', '60700000', 1),
('LV', 18, '44537000', '70700000', '60700000', 1),
('MT', 18, '44537000', '70700000', '60700000', 1),
('NL', 19, '44537000', '70700000', '60700000', 1),
('PL', 22, '44537000', '70700000', '60700000', 1),
('PT', 21, '44537000', '70700000', '60700000', 1),
('RO', 19, '44537000', '70700000', '60700000', 1),
('SE', 25, '44537000', '70700000', '60700000', 1),
('SI', 20, '44537000', '70700000', '60700000', 1),
('SK', 19, '44537000', '70700000', '60700000', 1);

-- Taux 0 européens
insert into TAUX_TVA (Code_Pays, Taux_TVA, Compte_Vente, Compte_Achat, Normal) values
('AT', 0, '70700000', '60700000', 0),
('BE', 0, '70700000', '60700000', 0),
('BG', 0, '70700000', '60700000', 0),
('CY', 0, '70700000', '60700000', 0),
('CZ', 0, '70700000', '60700000', 0),
('DE', 0, '70700000', '60700000', 0),
('DK', 0, '70700000', '60700000', 0),
('EE', 0, '70700000', '60700000', 0),
('ES', 0, '70700000', '60700000', 0),
('FI', 0, '70700000', '60700000', 0),
('GB', 0, '70700000', '60700000', 0),
('GR', 0, '70700000', '60700000', 0),
('HU', 0, '70700000', '60700000', 0),
('IE', 0, '70700000', '60700000', 0),
('IT', 0, '70700000', '60700000', 0),
('LT', 0, '70700000', '60700000', 0),
('LU', 0, '70700000', '60700000', 0),
('LV', 0, '70700000', '60700000', 0),
('MT', 0, '70700000', '60700000', 0),
('NL', 0, '70700000', '60700000', 0),
('PL', 0, '70700000', '60700000', 0),
('PT', 0, '70700000', '60700000', 0),
('RO', 0, '70700000', '60700000', 0),
('SE', 0, '70700000', '60700000', 0),
('SI', 0, '70700000', '60700000', 0),
('SK', 0, '70700000', '60700000', 0);

-- Ventilation des taux France en Europe
insert into VENTIL_TVA_NATIONAL_UE (Code_TVA, Code_Pays, Compte_Vente) values
(4, 'AT', '70700000'),
(4, 'BE', '70700000'),
(4, 'BG', '70700000'),
(4, 'CY', '70700000'),
(4, 'CZ', '70700000'),
(4, 'DE', '70700000'),
(4, 'DK', '70700000'),
(4, 'EE', '70700000'),
(4, 'ES', '70700000'),
(4, 'FI', '70700000'),
(4, 'GB', '70700000'),
(4, 'GR', '70700000'),
(4, 'HU', '70700000'),
(4, 'IE', '70700000'),
(4, 'IT', '70700000'),
(4, 'LT', '70700000'),
(4, 'LU', '70700000'),
(4, 'LV', '70700000'),
(4, 'MT', '70700000'),
(4, 'NL', '70700000'),
(4, 'PL', '70700000'),
(4, 'PT', '70700000'),
(4, 'RO', '70700000'),
(4, 'SE', '70700000'),
(4, 'SI', '70700000'),
(4, 'SK', '70700000');

insert into VENTIL_TVA_NATIONAL_UE (Code_TVA, Code_Pays, Compte_Vente) values
(3, 'AT', '70700000'),
(3, 'BE', '70700000'),
(3, 'BG', '70700000'),
(3, 'CY', '70700000'),
(3, 'CZ', '70700000'),
(3, 'DE', '70700000'),
(3, 'DK', '70700000'),
(3, 'EE', '70700000'),
(3, 'ES', '70700000'),
(3, 'FI', '70700000'),
(3, 'GB', '70700000'),
(3, 'GR', '70700000'),
(3, 'HU', '70700000'),
(3, 'IE', '70700000'),
(3, 'IT', '70700000'),
(3, 'LT', '70700000'),
(3, 'LU', '70700000'),
(3, 'LV', '70700000'),
(3, 'MT', '70700000'),
(3, 'NL', '70700000'),
(3, 'PL', '70700000'),
(3, 'PT', '70700000'),
(3, 'RO', '70700000'),
(3, 'SE', '70700000'),
(3, 'SI', '70700000'),
(3, 'SK', '70700000');

insert into VENTIL_TVA_NATIONAL_UE (Code_TVA, Code_Pays, Compte_Vente) values
(2, 'AT', '70700000'),
(2, 'BE', '70700000'),
(2, 'BG', '70700000'),
(2, 'CY', '70700000'),
(2, 'CZ', '70700000'),
(2, 'DE', '70700000'),
(2, 'DK', '70700000'),
(2, 'EE', '70700000'),
(2, 'ES', '70700000'),
(2, 'FI', '70700000'),
(2, 'GB', '70700000'),
(2, 'GR', '70700000'),
(2, 'HU', '70700000'),
(2, 'IE', '70700000'),
(2, 'IT', '70700000'),
(2, 'LT', '70700000'),
(2, 'LU', '70700000'),
(2, 'LV', '70700000'),
(2, 'MT', '70700000'),
(2, 'NL', '70700000'),
(2, 'PL', '70700000'),
(2, 'PT', '70700000'),
(2, 'RO', '70700000'),
(2, 'SE', '70700000'),
(2, 'SI', '70700000'),
(2, 'SK', '70700000');

-- Taux 0 internationaux
insert into TAUX_TVA (Code_Pays, Taux_TVA, Compte_Vente, Compte_Achat) values
('AD', 0, '70700000', '60700000'),
('AE', 0, '70700000', '60700000'),
('AF', 0, '70700000', '60700000'),
('AG', 0, '70700000', '60700000'),
('AI', 0, '70700000', '60700000'),
('AL', 0, '70700000', '60700000'),
('AM', 0, '70700000', '60700000'),
('AN', 0, '70700000', '60700000'),
('AO', 0, '70700000', '60700000'),
('AQ', 0, '70700000', '60700000'),
('AR', 0, '70700000', '60700000'),
('AS', 0, '70700000', '60700000'),
('AU', 0, '70700000', '60700000'),
('AW', 0, '70700000', '60700000'),
('AX', 0, '70700000', '60700000'),
('AZ', 0, '70700000', '60700000'),
('BA', 0, '70700000', '60700000'),
('BB', 0, '70700000', '60700000'),
('BD', 0, '70700000', '60700000'),
('BF', 0, '70700000', '60700000'),
('BH', 0, '70700000', '60700000'),
('BI', 0, '70700000', '60700000'),
('BJ', 0, '70700000', '60700000'),
('BL', 0, '70700000', '60700000'),
('BM', 0, '70700000', '60700000'),
('BN', 0, '70700000', '60700000'),
('BO', 0, '70700000', '60700000'),
('BR', 0, '70700000', '60700000'),
('BS', 0, '70700000', '60700000'),
('BT', 0, '70700000', '60700000'),
('BV', 0, '70700000', '60700000'),
('BW', 0, '70700000', '60700000'),
('BY', 0, '70700000', '60700000'),
('BZ', 0, '70700000', '60700000'),
('CA', 0, '70700000', '60700000'),
('CC', 0, '70700000', '60700000'),
('CD', 0, '70700000', '60700000'),
('CF', 0, '70700000', '60700000'),
('CG', 0, '70700000', '60700000'),
('CH', 0, '70700000', '60700000'),
('CI', 0, '70700000', '60700000'),
('CK', 0, '70700000', '60700000'),
('CL', 0, '70700000', '60700000'),
('CM', 0, '70700000', '60700000'),
('CN', 0, '70700000', '60700000'),
('CO', 0, '70700000', '60700000'),
('CR', 0, '70700000', '60700000'),
('CU', 0, '70700000', '60700000'),
('CV', 0, '70700000', '60700000'),
('CX', 0, '70700000', '60700000'),
('DJ', 0, '70700000', '60700000'),
('DM', 0, '70700000', '60700000'),
('DO', 0, '70700000', '60700000'),
('DZ', 0, '70700000', '60700000'),
('EC', 0, '70700000', '60700000'),
('EG', 0, '70700000', '60700000'),
('EH', 0, '70700000', '60700000'),
('ER', 0, '70700000', '60700000'),
('ET', 0, '70700000', '60700000'),
('FJ', 0, '70700000', '60700000'),
('FK', 0, '70700000', '60700000'),
('FM', 0, '70700000', '60700000'),
('FO', 0, '70700000', '60700000'),
('GA', 0, '70700000', '60700000'),
('GD', 0, '70700000', '60700000'),
('GE', 0, '70700000', '60700000'),
('GF', 0, '70700000', '60700000'),
('GG', 0, '70700000', '60700000'),
('GH', 0, '70700000', '60700000'),
('GI', 0, '70700000', '60700000'),
('GL', 0, '70700000', '60700000'),
('GM', 0, '70700000', '60700000'),
('GN', 0, '70700000', '60700000'),
('GP', 0, '70700000', '60700000'),
('GQ', 0, '70700000', '60700000'),
('GS', 0, '70700000', '60700000'),
('GT', 0, '70700000', '60700000'),
('GU', 0, '70700000', '60700000'),
('GW', 0, '70700000', '60700000'),
('GY', 0, '70700000', '60700000'),
('HK', 0, '70700000', '60700000'),
('HM', 0, '70700000', '60700000'),
('HN', 0, '70700000', '60700000'),
('HR', 0, '70700000', '60700000'),
('HT', 0, '70700000', '60700000'),
('ID', 0, '70700000', '60700000'),
('IL', 0, '70700000', '60700000'),
('IM', 0, '70700000', '60700000'),
('IN', 0, '70700000', '60700000'),
('IO', 0, '70700000', '60700000'),
('IQ', 0, '70700000', '60700000'),
('IR', 0, '70700000', '60700000'),
('IS', 0, '70700000', '60700000'),
('JE', 0, '70700000', '60700000'),
('JM', 0, '70700000', '60700000'),
('JO', 0, '70700000', '60700000'),
('JP', 0, '70700000', '60700000'),
('KE', 0, '70700000', '60700000'),
('KG', 0, '70700000', '60700000'),
('KH', 0, '70700000', '60700000'),
('KI', 0, '70700000', '60700000'),
('KM', 0, '70700000', '60700000'),
('KN', 0, '70700000', '60700000'),
('KP', 0, '70700000', '60700000'),
('KR', 0, '70700000', '60700000'),
('KW', 0, '70700000', '60700000'),
('KY', 0, '70700000', '60700000'),
('KZ', 0, '70700000', '60700000'),
('LA', 0, '70700000', '60700000'),
('LB', 0, '70700000', '60700000'),
('LC', 0, '70700000', '60700000'),
('LI', 0, '70700000', '60700000'),
('LK', 0, '70700000', '60700000'),
('LR', 0, '70700000', '60700000'),
('LS', 0, '70700000', '60700000'),
('LY', 0, '70700000', '60700000'),
('MA', 0, '70700000', '60700000'),
('MC', 0, '70700000', '60700000'),
('MD', 0, '70700000', '60700000'),
('ME', 0, '70700000', '60700000'),
('MF', 0, '70700000', '60700000'),
('MG', 0, '70700000', '60700000'),
('MH', 0, '70700000', '60700000'),
('MK', 0, '70700000', '60700000'),
('ML', 0, '70700000', '60700000'),
('MM', 0, '70700000', '60700000'),
('MN', 0, '70700000', '60700000'),
('MO', 0, '70700000', '60700000'),
('MP', 0, '70700000', '60700000'),
('MQ', 0, '70700000', '60700000'),
('MR', 0, '70700000', '60700000'),
('MS', 0, '70700000', '60700000'),
('MU', 0, '70700000', '60700000'),
('MV', 0, '70700000', '60700000'),
('MW', 0, '70700000', '60700000'),
('MX', 0, '70700000', '60700000'),
('MY', 0, '70700000', '60700000'),
('MZ', 0, '70700000', '60700000'),
('NA', 0, '70700000', '60700000'),
('NC', 0, '70700000', '60700000'),
('NE', 0, '70700000', '60700000'),
('NF', 0, '70700000', '60700000'),
('NG', 0, '70700000', '60700000'),
('NI', 0, '70700000', '60700000'),
('NO', 0, '70700000', '60700000'),
('NP', 0, '70700000', '60700000'),
('NR', 0, '70700000', '60700000'),
('NU', 0, '70700000', '60700000'),
('NZ', 0, '70700000', '60700000'),
('OM', 0, '70700000', '60700000'),
('PA', 0, '70700000', '60700000'),
('PE', 0, '70700000', '60700000'),
('PF', 0, '70700000', '60700000'),
('PG', 0, '70700000', '60700000'),
('PH', 0, '70700000', '60700000'),
('PK', 0, '70700000', '60700000'),
('PM', 0, '70700000', '60700000'),
('PN', 0, '70700000', '60700000'),
('PR', 0, '70700000', '60700000'),
('PS', 0, '70700000', '60700000'),
('PW', 0, '70700000', '60700000'),
('PY', 0, '70700000', '60700000'),
('QA', 0, '70700000', '60700000'),
('RE', 0, '70700000', '60700000'),
('RS', 0, '70700000', '60700000'),
('RU', 0, '70700000', '60700000'),
('RW', 0, '70700000', '60700000'),
('SA', 0, '70700000', '60700000'),
('SB', 0, '70700000', '60700000'),
('SC', 0, '70700000', '60700000'),
('SD', 0, '70700000', '60700000'),
('SG', 0, '70700000', '60700000'),
('SH', 0, '70700000', '60700000'),
('SJ', 0, '70700000', '60700000'),
('SL', 0, '70700000', '60700000'),
('SM', 0, '70700000', '60700000'),
('SN', 0, '70700000', '60700000'),
('SO', 0, '70700000', '60700000'),
('SR', 0, '70700000', '60700000'),
('ST', 0, '70700000', '60700000'),
('SV', 0, '70700000', '60700000'),
('SY', 0, '70700000', '60700000'),
('SZ', 0, '70700000', '60700000'),
('TC', 0, '70700000', '60700000'),
('TD', 0, '70700000', '60700000'),
('TF', 0, '70700000', '60700000'),
('TG', 0, '70700000', '60700000'),
('TH', 0, '70700000', '60700000'),
('TJ', 0, '70700000', '60700000'),
('TK', 0, '70700000', '60700000'),
('TL', 0, '70700000', '60700000'),
('TM', 0, '70700000', '60700000'),
('TN', 0, '70700000', '60700000'),
('TO', 0, '70700000', '60700000'),
('TR', 0, '70700000', '60700000'),
('TT', 0, '70700000', '60700000'),
('TV', 0, '70700000', '60700000'),
('TW', 0, '70700000', '60700000'),
('TZ', 0, '70700000', '60700000'),
('UA', 0, '70700000', '60700000'),
('UG', 0, '70700000', '60700000'),
('UM', 0, '70700000', '60700000'),
('US', 0, '70700000', '60700000'),
('UY', 0, '70700000', '60700000'),
('UZ', 0, '70700000', '60700000'),
('VA', 0, '70700000', '60700000'),
('VC', 0, '70700000', '60700000'),
('VE', 0, '70700000', '60700000'),
('VG', 0, '70700000', '60700000'),
('VI', 0, '70700000', '60700000'),
('VN', 0, '70700000', '60700000'),
('VU', 0, '70700000', '60700000'),
('WF', 0, '70700000', '60700000'),
('WS', 0, '70700000', '60700000'),
('YE', 0, '70700000', '60700000'),
('YT', 0, '70700000', '60700000'),
('ZA', 0, '70700000', '60700000'),
('ZM', 0, '70700000', '60700000'),
('ZW', 0, '70700000', '60700000');



insert into OPTION_TAXATION (Code_Pays, Taxe_Arrivee) values
('BE', 0),
('BG', 0),
('CZ', 0),
('DK', 0),
('DE', 0),
('EE', 0),
('GR', 0),
('ES', 0),
('IE', 0),
('IT', 0),
('CY', 0),
('LV', 0),
('LT', 0),
('LU', 0),
('HU', 0),
('MT', 0),
('NL', 0),
('AT', 0),
('PL', 0),
('RO', 0),
('PT', 0),
('SI', 0),
('SK', 0),
('FI', 0),
('SE', 0),
('GB', 0);


insert into TYPE_REGLEMENT (Libelle) values
('CARTE BANCAIRE'),
('CHEQUE'),
('ESPECES'),
('LCR'),
('PRELEVEMENT'),
('VIREMENT');


insert into MODE_REGLEMENT (Libelle, Type_R) values
('Carte bancaire', (select Type_Reg_Id from TYPE_REGLEMENT where Libelle='CARTE BANCAIRE')),
('Cheque', (select Type_Reg_Id from TYPE_REGLEMENT where Libelle='CHEQUE')),
('Especes', (select Type_Reg_Id from TYPE_REGLEMENT where Libelle='ESPECES')),
('LCR', (select Type_Reg_Id from TYPE_REGLEMENT where Libelle='LCR')),
('Prelevement', (select Type_Reg_Id from TYPE_REGLEMENT where Libelle='PRELEVEMENT')),
('Virement', (select Type_Reg_Id from TYPE_REGLEMENT where Libelle='VIREMENT'));


insert into MODELE_ETIQUETTE (Modele_Id, Description) values
('STD01','Standard 120 x 80'),
('STD02','Standard 225 x 80');


insert into MODELE_FACTURE_CLIENT (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_AVOIR_CLIENT (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_COMMANDE_CLIENT (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_FACTURE_FOURNISSEUR (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_AVOIR_FOURNISSEUR (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_COMMANDE_FOURNISSEUR (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_BON_LIVRAISON (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_BON_PREPARATION (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_BON_RECEPTION (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_DEVIS (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_ACOMPTE_CLIENT (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_ACOMPTE_FOURNISSEUR (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_BON_RETOUR_CLIENT (Modele_Id, Description) values ('STD01', 'Standard');
insert into MODELE_BON_RETOUR_FOURNISSEUR (Modele_Id, Description) values ('STD01', 'Standard');


insert into EXPORT_COLIS (Export_Id, Description) values
('COLISSIMO','Colissimo'),
('CHRONOPOST', 'Chronopost');

insert into IMPORT_COLIS (Import_Id, Description) values
('LAPOSTE','La Poste');

insert into UNITE_VENTE (Unite, Type_Unite, Libelle, Rank) values
('U', 'U', 'Unité', 1),
('m', 'L', 'Mètre (m)', 1),
('cm', 'L', 'Centimètre (cm)', 2),
('mm', 'L', 'Millimètre (mm)', 3),
('t', 'P', 'Tonne (t)', 1),
('kg', 'P', 'KiloGramme (kg)', 2),
('g', 'P', 'Gramme (g)', 3),
('m²', 'S', 'Mètre Carré (m²)', 1),
('mm²', 'S', 'Millimètre Carré (mm²)', 2),
('l', 'C', 'Litre (l)', 1),
('m³', 'V', 'Mètre Cube (m³)', 1),
('dm³', 'V', 'Décimètre Cube (dm³)', 2),
('cm³', 'V', 'Centimètre Cube (cm³)', 3),
('J', 'T', 'Jour (J)', 1),
('H', 'T', 'Heure (H)', 2);


insert into TYPE_SOCIETE (Libelle) values
('Association'),
('EARL'),
('ENT'),
('ETS'),
('EURL'),
('GAEC'),
('GAF'),
('GFA'),
('GFR'),
('GPT'),
('IND'),
('SA'),
('SARL'),
('SAS'),
('SC'),
('SCA'),
('SCEA'),
('SCEV'),
('SCI'),
('SCM'),
('SCP'),
('SCPI'),
('SCS'),
('SIG'),
('SII'),
('SLCA'),
('SLFA'),
('SNC'),
('SRLR'),
('STEF'),
('STEP');


insert into FORMAT_IMPORT_BANQUE (Intitule, Col_Date, Format_Date, Col_Libelle, Col_Montant_C, Col_Montant_D, Col_Mode_Reg, Col_Num_Piece, Premiere_Ligne, Separateur, Delimiteur) values
('CIC Web',1,'MM/dd/yyyy',5,4,3,0,0,2,',',''),
('CE Rhone-Alpes Web',1,'dd/MM/yy',3,5,4,6,0,5,';',''),
('CE Ile-de-France Web',1,'dd/MM/yyyy',3,5,4,6,6,5,';',''),
('Credit Mutuel Web',1,'dd/MM/yyyy',5,4,3,0,0,2,';','"'),
('Banque Populaire Web',2,'dd/MM/yyyy',4,7,7,0,0,2,';',''),
('Banque Postale Web',1,'dd/MM/yyyy',2,3,3,0,0,9,';','"'),
('Credit Agricole Web',1,'dd/MM/yyyy',2,4,3,0,0,12,'\t','');


insert into LISTE_ATTRIBUT (Liste_Id, Nom) values
(1, 'Attribut 1'),
(2, 'Attribut 2'),
(3, 'Attribut 3'),
(4, 'Attribut 4'),
(5, 'Attribut 5'),
(6, 'Attribut 6');


insert into MOTIF_REMBOURSEMENT (Libelle) values
('Retour de marchandises'),
('Commande non honorée'),
('Trop perçu'),
('Lettre de réclamation'),
('Autre');
