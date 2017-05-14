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

-- SCHEMA BASE DE DONNÉES OPENSI << GENERAL >>

GRANT ALL PRIVILEGES on *.* to 'opensi'@'localhost' identified by 'opensi';

create database opensi;

use opensi;

create table DOSSIER (
  Dossier_Id       varchar(8) not null,         -- Identifiant dossier
  Nom              varchar(50) default '',      -- Nom du dossier
  Base             varchar(13) default '',      -- Nom de la base de données du dossier
  Actif            tinyint unsigned default 1,  -- Dossier actif (oui/non)
  primary key(Dossier_Id)
) engine=InnoDB;


create table ENTREPRISE (
  Entreprise_Id       int unsigned not null auto_increment,  -- Identifiant de l'entreprise
  Identifiant         varchar(15) not null,                  -- Identifiant de l'entreprise
  Denomination        varchar(50) default '',                -- Dénomination de l'entreprise
  Actif               tinyint unsigned default 1,            -- Entreprise activée (oui/non)
  Email               varchar(60) default '',                -- Email de l'entreprise
  No_Mail             tinyint unsigned default 0,            -- Pas d'email
  Telephone           varchar(20) default '',                -- Téléphone
  Responsable         varchar(60) default '',                -- Responsable
	Acc_Gest_Com        tinyint unsigned not null default 0,   -- Accès gestion commerciale (oui/non)
  Acc_Compta          tinyint unsigned not null default 0,   -- Accès comptabilité (oui/non)
  Acc_CRM             tinyint unsigned not null default 0,   -- Accès CRM (oui/non)
  primary key (Entreprise_Id),
  unique (Identifiant)
) engine=InnoDB;


create table ENTREPRISE_DOSSIER (
  Entreprise_Id    int unsigned not null,  -- Identifiant de l'entreprise
  Dossier_Id       varchar(8) not null,    -- Numéro de dossier géré par l'utilisateur
  primary key (Entreprise_Id, Dossier_Id),
  constraint cfk_entreprise_dossier_entreprise_id foreign key (Entreprise_Id) references ENTREPRISE (Entreprise_Id),
  constraint cfk_entreprise_dossier_dossier_id foreign key (Dossier_Id) references DOSSIER (Dossier_Id)
) engine=InnoDB;


create table UTILISATEUR (
  Utilisateur_Id   int not null auto_increment,           -- Identifiant de l'utilisateur
  Login            varchar(15) not null,                  -- Identifiant utilisateur
  Password         varchar(55) not null,                  -- Mot de passe
  Entreprise_Id    int unsigned not null,                 -- Entreprise de l'utilisateur
  Civilite         tinyint unsigned default 0,            -- Civilité de l'utilisateur (M=1,Mme=2,Mlle=3)
  Nom              varchar(30) default '',                -- Nom de l'utilisateur
  Prenom           varchar(30) default '',                -- Prénom de l'utilisateur
  Administrateur   tinyint unsigned default 0,            -- Droit administrateur (oui/non)
	Direction        tinyint unsigned not null default 0,   -- Membre de la direction (oui/non)
  Fonction         varchar(30) default '',                -- Fonction de l'utilisateur
  Email            varchar(60) default '',                -- Adresse e-mail de l'utilisateur
  Actif            tinyint unsigned default 1,            -- Utilisateur actif (oui/non)
  Telephone        varchar(20) default '',                -- Téléphone de l'utilisateur
  Date_Connexion   bigint unsigned default 0,             -- Date de dernière connexion (0 si jamais connecté)
  primary key (Utilisateur_Id),
  unique (Login, Entreprise_Id),
  index idx_entreprise_id (Entreprise_Id),
  constraint cfk_utilisateur_entreprise_id foreign key (Entreprise_Id) references ENTREPRISE (Entreprise_Id)
) engine=InnoDB;


-- Droits des utilisateurs sur les dossiers
create table UTILISATEUR_DOSSIER (
  Utilisateur_Id   int not null,                          -- Identifiant de l'utilisateur
  Dossier_Id       varchar(8) not null,                   -- Numéro de dossier géré par l'utilisateur
  Acc_Gest_Web     tinyint unsigned default 0,            -- Accès gestion e-commerce (oui/non)
  Acc_Config       tinyint unsigned default 0,            -- Accès configuration des dossiers (oui/non)
  Acc_Gest_Com     tinyint unsigned default 0,            -- Accès gestion commerciale (oui/non)
  Acc_Compta       tinyint unsigned default 0,            -- Accès comptabilité (oui/non)
  Acc_CRM          tinyint unsigned not null default 0,   -- Accès CRM (oui/non)
	Validation_CF    tinyint unsigned not null default 0,   -- Droit de validation d'une commande fournisseur (oui/non)
  primary key(Utilisateur_Id, Dossier_Id),
  constraint cfk_utilisateur_dossier_utilisateur_id foreign key (Utilisateur_Id) references UTILISATEUR (Utilisateur_Id),
  constraint cfk_utilisateur_dossier_dossier_id foreign key (Dossier_Id) references DOSSIER (Dossier_Id)
) engine=InnoDB;


-- gestion de profils de droits ----------------


create table PROFIL (
  Profil_Id        int unsigned not null auto_increment,  -- Identifiant du profil
  Entreprise_Id    int unsigned not null,                 -- Identifiant de l'entreprise
  Nom              varchar(30) default '',                -- Nom du profil
  Commentaires     text,                                  -- Commentaires sur le profil
  Standard         tinyint unsigned default 0,            -- Standard (1=oui/0=non)
  primary key (Profil_Id),
  index idx_entreprise_id (Entreprise_Id),
  constraint cfk_profil_entreprise_id foreign key (Entreprise_Id) references ENTREPRISE (Entreprise_Id)
) engine=InnoDB;


create table PROFIL_DOSSIER_UTILISATEUR (
  Utilisateur_Id      int not null,               -- Identifiant de l'utilisateur
  Profil_Id           int unsigned not null,      -- Identifiant du profil
  Dossier_Id          varchar(8) not null,        -- Identifiant du dossier
  primary key (Utilisateur_Id, Profil_Id, Dossier_Id),
  constraint cfk_profil_dossier_utilisateur_dossier_id foreign key (Dossier_Id) references DOSSIER (Dossier_Id),
  constraint cfk_profil_dossier_utilisateur_profil_id foreign key (Profil_Id) references PROFIL (Profil_Id),
  constraint cfk_profil_dossier_utilisateur_utilisateur_id foreign key (Utilisateur_Id) references UTILISATEUR (Utilisateur_Id)
) engine=InnoDB;


create table PROFIL_DOSSIER_COMPTE (
  Profil_Id             int unsigned not null,         -- Identifiant du profil
  Numero_Compte         char(8) not null,              -- Numéro de compte
  Dossier_Id            varchar(8) not null,           -- Identifiant du dossier
  primary key (Dossier_Id, Numero_Compte, Profil_Id),
  constraint cfk_profil_dossier_compte_dossier_id foreign key (Dossier_Id) references DOSSIER (Dossier_Id),
  constraint cfk_profil_dossier_compte_profil_id foreign key (Profil_Id) references PROFIL (Profil_Id)
) engine=InnoDB;


create table PROFIL_DOSSIER_JOURNAL (
  Profil_Id             int unsigned not null,         -- Identifiant du profil
  Code_Journal          char(3) not null,              -- Identifiant du journal
  Dossier_Id            varchar(8) not null,           -- Identifiant du dossier
  primary key (Dossier_Id, Code_Journal, Profil_Id),
  constraint cfk_profil_dossier_journal_dossier_id foreign key (Dossier_Id) references DOSSIER (Dossier_Id),
  constraint cfk_profil_dossier_journal_profil_id foreign key (Profil_Id) references PROFIL (Profil_Id)
) engine=InnoDB;




create table LISTE_TRESORERIE (
  Nom_Tresorerie   varchar(60) not null,
  primary key(Nom_Tresorerie)
) engine=InnoDB;


create table LISTE_C_IMPOT (
  Nom_Centre       varchar(60) not null,
  primary key(Nom_Centre)
) engine=InnoDB;


-- Liste des exports
create table EXPORT (
  Export_Id       int unsigned not null,
  Nom_Export      varchar(20),
  primary key(Export_Id)
) engine=InnoDB;


-- Liste des formats d'export
create table FORMAT_EXPORT (
  Code_Export     varchar(15) not null,
  Export_Id       int unsigned,
  Nom_Format      varchar(30),
  primary key(Code_Export)
) engine=InnoDB;


-- Liste des formats d'export comptables
create table FORMAT_EXPORT_COMPTA (
	Export_Id       int not null auto_increment,          -- Identifiant de l'export
	Intitule        varchar(20) not null,                 -- Intitulé de l'export
	Code_Export     varchar(5) not null,                  -- Code de l'export
  Dispo_GC        tinyint unsigned not null default 0,  -- Disponible depuis la gestion commerciale
	Dispo_MC        tinyint unsigned not null default 0,  -- Disponible depuis la comptabilité
  primary key (Export_Id),
	unique (Code_Export)
) engine=InnoDB;




-- Liste des imports
create table IMPORT (
  Import_Id       int unsigned not null,
  Nom_Import      varchar(20),
  primary key(Import_Id)
) engine=InnoDB;


-- Liste des formats d'import
create table FORMAT_IMPORT (
  Code_Import     varchar(15) not null,
  Import_Id       int unsigned,
  Nom_Format      varchar(50),
  primary key(Code_Import)
) engine=InnoDB;


create table CIVILITE (
  Civ_Id       tinyint unsigned not null, -- Identifiant de la civilité
  Civ_Courte   varchar(4),                -- Civilité abrégée
  Civ_Longue   varchar(12),               -- Civilité entière
  primary key(Civ_Id)
) engine=InnoDB;


-- Défini l'ordre d'affichage des journaux par type
create table ORDRE_JOURNAUX (
  Type_Journal     char(2) not null,    -- Type de journal
  Ordre_Affichage  tinyint unsigned,    -- Numero d'ordre d'affichage
  primary key(Type_Journal)
) engine=InnoDB;


create table PLAN_COMPTABLE (
  Code_Plan         int unsigned not null auto_increment, -- Code du plan comptable
  Libelle           varchar(254) default '',              -- Libellé du plan comptable
  primary key(Code_plan)
) engine=InnoDB;


create table CLASSE_PLAN_COMPTABLE (
  Code_Plan         int unsigned not null,     -- Code du plan comptable
  Numero_Classe     int unsigned not null,     -- numero de la classe
  Libelle_Classe    varchar(254) default '',   -- Libellé de la classe
  Niveau            tinyint unsigned not null, -- niveau de la classe
  Code              int unsigned not null,     -- code utilisé pour afficher l arbre
  primary key(Code_plan, Numero_classe)
) engine=InnoDB;


create table TITRE_CLASSE_PLAN_COMPTABLE (
  Code_Plan         int unsigned not null,     -- Code du plan comptable
  Numero_Titre      int unsigned not null,     -- numero de la classe
  Libelle_Titre     varchar(254) default '',   -- Libellé de la classe
  primary key(Code_plan, Numero_Titre)
) engine=InnoDB;


-- liste des nomenclatures NC8
create table NOMENCLATURE_NC8 (
  Code_NC8       varchar(8) not null,        -- Code NC8
  Libelle        text,                       -- Libellé
  Info_Unite     varchar(30) default '',     -- Info sur unité de mesure
  primary key(Code_NC8)
) engine=InnoDB;


-- liste des langues
create table LANGUE (
  Langue_Id      int unsigned not null auto_increment,  -- Identifiant de la langue
  Code_ISO       char(2) not null,                      -- Code iso de la langue (norme ISO 639-1 (alpha-2))
  Nom_FR         varchar(20) default '',                -- Nom de la langue en français
  Nom_EN         varchar(20) default '',                -- Nom de la langue en anglais
  Actif          tinyint unsigned default 1,            -- Valeur active (oui/non)
  primary key (Langue_Id),
  unique (Code_ISO)
) engine=InnoDB;


-- liste des pays
create table PAYS (
  Code_Pays         char(2) not null,            -- Code iso-3166 du pays
  Nom_FR            varchar(50) default '',      -- Nom officiel du pays en francais
  Nom_EN            varchar(50) default '',      -- Nom officiel du pays en anglais
  Zone_UE           tinyint unsigned default 0,  -- Zone union européenne (oui/non)
  Type_Pays         char(1) default '',          -- D : DOM, T :TOM
  Langue            int unsigned default null,   -- Langue commerciale du pays
  primary key(Code_Pays),
  index idx_langue (Langue),
  constraint cfk_pays_langue foreign key (Langue) references LANGUE (Langue_Id)
) engine=InnoDB;


-- liste des devises
create table DEVISE (
  Devise_Id         int unsigned not null auto_increment,  -- Identifiant devise
  Code_Alpha        char(3) not null,                      -- Code iso alphabétique
  Code_Num          char(3) not null,                      -- Code numérique
  Intitule          varchar(50) default '',                -- Intitulé de la devise
  Symbole           char(1) default '',                    -- Symbole de la devise
  primary key(Devise_Id),
  unique(Code_Alpha),
  unique(Code_Num)
) engine=InnoDB;


create table MONNAIE_DEVISE (
  Monnaie_Id        int unsigned not null auto_increment, -- Identifiant de la monnaie
  Devise_Id         int unsigned not null,                -- Identifiant de la devise
  Valeur            decimal(8,2) default 0,               -- Valeur faciale de la monnaie
  Type              char(1) default 'P',                  -- Type de monnaie (P=Pièce,B=Billet)
  Qte_Remise        int unsigned default 1,               -- Quantité dans un rouleau ou liasse pour les remises d'espèces en banque
  primary key (Monnaie_Id),
  index idx_devise_id (Devise_Id),
  constraint cfk_monnaie_devise_devise_id foreign key (Devise_Id) references DEVISE (Devise_Id)
) engine=InnoDB;


-- association des devises aux pays
create table DEVISE_PAYS (
  Devise_Id         int unsigned not null,
  Code_Pays         char(2) not null,
  primary key(Devise_Id, Code_Pays),
  constraint cfk_devise_pays_devise_id foreign key (Devise_Id) references DEVISE (Devise_Id),
  constraint cfk_devise_pays_code_pays foreign key (Code_Pays) references PAYS (Code_Pays)
) engine=InnoDB;


-- seuils de ca pour la taxation des marchandises à l'export en union européenne
create table SEUIL_CA_TVA (
  Code_Pays         char(2) not null,            -- Code pays
  Seuil             int unsigned default 0,      -- Seuil de chiffre d'affaires HT en Euros
  primary key(Code_Pays),
  constraint cfk_seuil_ca_tva_code_pays foreign key (Code_Pays) references PAYS (Code_Pays)
) engine=InnoDB;


-- liste des communes de france avec leur code postal
create table COMMUNES (
  CP          char(5),      -- code postal
  Ville       varchar(45),  -- nom de la ville en majuscule
  Ville_Min   varchar(45),  -- nom de la ville en minuscule
  Ville_Rech  char(43)      -- nom de la ville sans L' LES LA LE SAINT
) engine=InnoDB;


-- liste des codes transactions pour la DEB
create table DEB_TRANSACTION (
  Code_Transaction_A      tinyint unsigned not null,         -- Code de transaction A
  Code_Transaction_B      tinyint unsigned not null,         -- Code de transaction B
  Libelle                 varchar(150),                      -- Libellé de la transaction
  primary key(Code_Transaction_A, Code_Transaction_B)
) engine=InnoDB;


-- liste des conditions de livraison pour la DEB
create table DEB_CONDITION_LIVRAISON (
  Code_Livraison          char(3) not null,             -- Code de conditions de livraison
  Libelle                 varchar(50),                  -- Libellé
  primary key(Code_Livraison)
) engine=InnoDB;


-- liste des modes de transport pour la DEB
create table DEB_MODE_TRANSPORT (
  Code_Transport          tinyint unsigned not null,  -- Code du mode de transport
  Libelle                 varchar(50),                -- Libellé
  primary key(Code_Transport)
) engine=InnoDB;


-- liste des codes régimes statistiques pour la DEB
create table DEB_REGIME (
  Code_Regime          tinyint unsigned not null,     -- Code du régime statistique
  Libelle              varchar(300),                  -- Libellé
  Type_Regime          tinyint unsigned,              -- Type du régime (0: introduction, 1: expédition)
  primary key(Code_Regime)
) engine=InnoDB;



\. Langues.sql
\. Pays.sql
\. LanguesPays.sql
\. Devises.sql
\. DevisesPays.sql
\. InitGeneral.sql
\. NomenclatureNC8.sql
\. PlanComptableGeneral.sql
\. Communes.sql
