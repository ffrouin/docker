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

-- SCHEMA BASE DE DONNÉES OPENSI << DOSSIER >>




create table SECTEUR_ACTIVITE (
  Secteur_Id        int unsigned not null auto_increment,  -- Identifiant du secteur d'activité
  Libelle           varchar(20) default '',                -- Libellé du secteur d'activité
  Code_Secteur      varchar(6) default '',                 -- Code du secteur d'activité
  primary key (Secteur_Id),
  unique(Code_Secteur)
) engine=InnoDB;


create table ORG_LIVRAISON (
  Organisme_Id     int unsigned not null auto_increment,  -- Identifiant de l'organisme de livraison
  Nom_Org          varchar(30) default '',                -- Nom de l'organisme de livraison
  Adresse          varchar(80) default '',                -- Adresse
  Code_Postal      varchar(10) default '',                -- Code postal
  Ville            varchar(50) default '',                -- Ville
  Tel              varchar(20) default '',                -- Téléphone
  Fax              varchar(20) default '',                -- Fax
  Num_Client       varchar(15) default '',                -- Numéro de client chez cet organisme
  primary key (Organisme_Id)
) engine=InnoDB;


create table EXPORT_COLIS (
  Export_Id      varchar(10) not null,      -- identifiant export
  Description    varchar(100) default '',   -- description de l'export
  Class          varchar(100) default '',   -- class java
  Num_Org        int unsigned default 0,    -- numéro de l'organisme de livraison correspondant
  primary key (Export_Id)
) engine=InnoDB;


create table IMPORT_COLIS (
  Import_Id      varchar(10) not null,      -- identifiant import
  Description    varchar(100) default '',   -- description de l'import
  Class          varchar(100) default '',   -- class java
  primary key (Import_Id)
) engine=InnoDB;


create table MODE_LIVRAISON (
  Mode_Liv_Id      int unsigned not null auto_increment,  -- Identifiant du mode de livraison
  Organisme_Id     int unsigned default null,             -- Identifiant de l'organisme de livraison
  Nom              varchar(30) not null,                  -- Nom du mode de livraison
  Type_Liv         char(1) default 'E',                   -- Type de livraison (E=Expédition classique, M=Retrait en magasin, R=Relais colis)
  Format_Defaut    varchar(10) default null,              -- Format par défaut du fichier d'expédition
  primary key (Mode_Liv_Id),
  unique(Nom),
  index idx_organisme_id (Organisme_Id),
  index idx_format_defaut (Format_Defaut),
  constraint cfk_mode_livraison_organisme_id foreign key (Organisme_Id) references ORG_LIVRAISON (Organisme_Id),
  constraint cfk_mode_livraison_format_defaut foreign key (Format_Defaut) references EXPORT_COLIS (Export_Id)
) engine=InnoDB;


create table EMAIL (
  Email_Id         int unsigned not null auto_increment,  -- Identifiant de l'email
  Libelle          varchar(30) default '',                -- Libellé de l'email
  Expediteur       varchar(64) default '',                -- Email de l'expéditeur
  Dest_CC          varchar(64) default '',                -- Email en copie
  Dest_BCC         varchar(64) default '',                -- Email en copie cachée
  Sujet            varchar(50) default '',                -- Sujet du mail
  primary key (Email_Id)
) engine=InnoDB;


create table TYPE_SOCIETE (
  Type_Societe_Id     int unsigned not null auto_increment,  -- Identifiant du type de société
  Libelle             varchar(11) default '',                -- Libellé du type de société
  primary key (Type_Societe_Id)
) engine=InnoDB;


create table TYPE_REGLEMENT (
  Type_Reg_Id         int unsigned not null auto_increment,  -- Identifiant du type de règlement
  Libelle             varchar(14) default '',                -- Libellé du type de règlement
  primary key (Type_Reg_Id)
) engine=InnoDB;


create table UNITE_VENTE (
  Unite_Id         int not null auto_increment,              -- Code de l'unité
  Unite            char(3) default '',                       -- Symbole de l'unité
  Libelle          varchar(25) default '',                   -- Libellé complet de l'unité
  Type_Unite       char(1) not null,                         -- Type d'unité (U=Unité, L=Longueur, P=Poids, S=Surface, V=Volume, C=Capacité, T=Temps)
  Actif            tinyint unsigned not null default 1,      -- Unité active (oui/non)
  Rank             tinyint unsigned not null,                -- Numéro d'ordre
  primary key (Unite_Id)
) engine=InnoDB;



-- ------------------- COMPTABILITE -------------------------------------------------------------------


create table COMPTE (
  Numero_Compte     char(8) not null,            -- Numéro de compte
  Intitule          varchar(100) default '',     -- Intitulé du compte
  Type_Compte       char(1) default 'G',         -- Type de compte (C=Client, F=Fournisseur, G=Généraux, A=Auxiliaire)
  Code_TVA          int unsigned default 1,      -- Code de TVA applicable
  Cumul_Journal     tinyint unsigned default 0,  -- Cumul en pied de journal (oui/non)
  Detail_Cloture    tinyint unsigned default 1,  -- Détail en cloture (oui/non)
  Date_C            bigint unsigned default 0,   -- Date de création du compte
  Collectif         char(8) default null,        -- Numéro de compte collectif
  Contrepartie      char(8) default null,        -- Numéro de compte de contrepartie
  Tva_Encaissement  tinyint unsigned default 0,  -- Tva sur encaissement (oui/non)
  Centralisateur    tinyint unsigned default 0,  -- Centralisateur (oui/non)
  primary key (Numero_Compte),
  index idx_collectif (Collectif),
  index idx_contrepartie (Contrepartie),
  constraint cfk_compte_collectif foreign key (Collectif) references COMPTE (Numero_Compte),
  constraint cfk_compte_contrepartie foreign key (Contrepartie) references COMPTE (Numero_Compte)
) engine=InnoDB;


create table JOURNAL (
  Code_Journal     char(3) not null,           -- Code d'identification du journal
  Intitule         varchar(50) default '',     -- Libellé du journal
  Type_Journal     char(2) default 'OD',       -- Type du journal (AC=achat, VE=vente, OD=operations diverses, TR=tresorerie, AN=a nouveau)
  Contrepartie     char(8) default null,       -- Numéro de compte de contrepartie par défaut
  primary key (Code_Journal),
  index idx_contrepartie (Contrepartie),
  constraint cfk_journal_contrepartie foreign key (Contrepartie) references COMPTE (Numero_Compte)
) engine=InnoDB;


create table TRANCHE_COLLECTIF (
  Tranche_Id       int unsigned not null auto_increment,  -- Identifiant de la tranche
  Min_Compte       char(8) not null,                      -- Valeur minimum du compte
  Max_Compte       char(8) not null,                      -- Valeur maximum du compte
  primary key (Tranche_Id),
  unique (Min_Compte, Max_Compte)
) engine=InnoDB;


create table MODE_REGLEMENT (
  Mode_Reg_Id           int unsigned not null auto_increment,  -- Identifiant du mode de règlement
  Libelle               varchar(25) not null,                  -- Mode de règlement
  Actif                 tinyint unsigned default 1,            -- Actif (oui/non)
  Type_R                int unsigned not null,                 -- Type de règlement
  Code_Journal          char(3) default null,                  -- Journal d'encaissement
  primary key (Mode_Reg_Id),
  unique (Libelle),
  index idx_type_r (Type_R),
  constraint cfk_mode_reglement_type_r foreign key (Type_R) references TYPE_REGLEMENT (Type_Reg_Id),
  constraint cfk_mode_reglement_code_journal foreign key (Code_Journal) references JOURNAL (Code_Journal)
) engine=InnoDB;



-- --------------------- BANQUES ---------------------------------------------------------------


create table BANQUE (
  Banque_Id       int unsigned not null auto_increment,  -- Identifiant de la banque
  Nom             varchar(30) default '',                -- Nom de la banque
  Adresse         varchar(80) default '',                -- Domiciliation
  Code_Agence     varchar(5) default '',                 -- Code établissement
  Code_Guichet    varchar(5) default '',                 -- Code guichet
  Num_Compte      varchar(11) default '',                -- Numéro de compte
  Cle_RIB         varchar(2) default '',                 -- Clé de RIB
  IBAN            varchar(27) default '',                -- 27 caractères du numéro IBAN
  BIC             varchar(11) default '',                -- Numéro BIC
  Code_Journal    char(3) default null,                  -- Code journal pour transfert
  primary key (Banque_Id),
  index idx_code_journal (Code_Journal),
  constraint cfk_banque_code_journal foreign key (Code_Journal) references JOURNAL (Code_Journal)
) engine=InnoDB;



-- ------------------------- TVA ---------------------------------------------------------------------------


create table TAUX_TVA (
  Code_TVA            int unsigned not null auto_increment,      -- Code de TVA
  Taux_TVA            decimal(4,2) unsigned default 0,           -- Taux de TVA
  Taux_NPR            decimal(4,2) unsigned default 0,           -- Taux de TVA NPR
  Normal              tinyint unsigned default 0,                -- Taux normal (oui/non)
  Code_Pays           char(2) default 'FR',                      -- Code pays
  Compte_TVA_Achat    char(8) default null,                      -- Numéro de compte de TVA sur achat
  Compte_TVA_Vente    char(8) default null,                      -- Numéro de compte de TVA sur vente
  Compte_Vente        char(8) not null,                          -- Numéro de compte de vente
  Compte_Achat        char(8) not null,                          -- Numéro de compte d'achat
  primary key (Code_TVA),
  index idx_code_tva (Code_TVA),
  index idx_compte_tva_achat (Compte_TVA_Achat),
  index idx_compte_tva_vente (Compte_TVA_Vente),
  index idx_compte_vente (Compte_Vente),
  index idx_compte_achat (Compte_Achat),
  constraint cfk_taux_tva_compte_tva_achat foreign key (Compte_TVA_Achat) references COMPTE (Numero_Compte),
  constraint cfk_taux_tva_compte_tva_vente foreign key (Compte_TVA_Vente) references COMPTE (Numero_Compte),
  constraint cfk_taux_tva_compte_achat foreign key (Compte_Achat) references COMPTE (Numero_Compte),
  constraint cfk_taux_tva_compte_vente foreign key (Compte_Vente) references COMPTE (Numero_Compte)
) engine=InnoDB;


create table VENTIL_TVA_NATIONAL_UE (
  Code_TVA         int unsigned not null,      -- Code TVA d'un taux francais > 0
  Code_Pays        char(2) not null,           -- Code pays de l'UE (hors France)
  Compte_Vente     char(8) not null,           -- Numéro de compte de vente
  primary key (Code_TVA, Code_Pays),
  index idx_compte_vente (Compte_Vente),
  constraint cfk_ventil_tva_national_ue_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_ventil_tva_national_ue_compte_vente foreign key (Compte_Vente) references COMPTE (Numero_Compte)
) engine=InnoDB;


create table OPTION_TAXATION (
  Code_Pays           char(2) not null,                          -- Code pays de l'UE
  Taxe_Arrivee        tinyint unsigned default 0,                -- Taxation dans le pays d'arrivée
  primary key (Code_Pays)
) engine=InnoDB;





-- ------------------------- TABLES CLIENTS ----------------------------------------------------------------


create table FAMILLE_CLIENT (
  Famille_Id       int unsigned not null auto_increment,     -- Identifiant de la famille
  Libelle          varchar(40) default '',                   -- Libellé de la famille
  Actif            tinyint unsigned default 1,               -- Valeur active (oui/non)
  primary key (Famille_Id),
  unique (Libelle)
) engine=InnoDB;


create table FICHE_CLIENT (
  Client_Id            char(10) not null,                         -- Identifiant unique du client
  Code_Couleur         tinyint unsigned default 2,                -- Code de couleur définissant l'importance d'un client
  Civilite             tinyint unsigned default 0,                -- Civilité (M=1,Mme=2,Mlle=3)
  Nom                  varchar(30) default '',                    -- Nom du client
  Prenom               varchar(20) default '',                    -- Prénom du client
  Denomination         varchar(50) default '',                    -- Raison sociale de l'entreprise
  Adresse_1            varchar(80) default '',                    -- Ligne d'adresse 1
  Adresse_2            varchar(50) default '',                    -- Ligne d'adresse 2
  Adresse_3            varchar(50) default '',                    -- Ligne d'adresse 3
  Code_Postal          varchar(10) default '',                    -- Code postal
  Ville                varchar(50) default '',                    -- Ville
  Code_Pays            char(2) default 'FR',                      -- Code pays
  Tel_1                varchar(20) default '',                    -- Téléphone 1
  Tel_2                varchar(20) default '',                    -- Téléphone 2
  Tel_3                varchar(20) default '',                    -- Téléphone 3
  Fax_1                varchar(20) default '',                    -- Fax 1
  Fax_2                varchar(20) default '',                    -- Fax 2
  Email_1              varchar(60) default '',                    -- Adresse e-mail 1
  Email_2              varchar(60) default '',                    -- Adresse e-mail 2
  Site_Web             varchar(40) default '',                    -- Site web de la société
  Num_SIRET            char(14) default '',                       -- Numéro de SIRET
  Code_NAF             char(5) default '',                        -- Code NAF
  Num_TVA_Intra        varchar(14) default '',                    -- Numéro de TVA intracommunautaire
  Type_Societe         int unsigned default null,                 -- Type de société (SARL, SA...)
  Famille_Id           int unsigned default null,                 -- Famille
  Date_C               bigint unsigned default 0,                 -- Date de création de la fiche client
  Date_M               bigint unsigned default 0,                 -- Date de mise à jour de la fiche client
  Util_C               int not null,                              -- Utilisateur créateur de la fiche client
  Util_M               int not null,                              -- Utilisateur ayant fait la dernière mise à jour de la fiche client
  Util_R               int default null,                          -- Responsable du client
  Recurrent            tinyint unsigned default 0,                -- Client récurrent (1=oui/0=non)
  Exigences            tinyint unsigned default 0,                -- Exigences particulières (1=oui/0=non)
  Actif                tinyint unsigned default 1,                -- Client actif (1=actif/0=inactif)
  Com_Recurrent        text,                                      -- Commentaires sur client récurrent
  Com_Exigences        text,                                      -- Commentaires sur exigences du client
  Com_Sante            text,                                      -- Commentaires sur la santé financière de l'entreprise
  Com_Libre            text,                                      -- Commentaires libres
  Revendeur            tinyint unsigned default 0,                -- Revendeur (1=oui/0=non)
  Bloque               tinyint unsigned default 0,                -- Client bloqué (1=oui/0=non)
  Supprime             tinyint unsigned default 0,                -- Client supprimé virtuellement (1=oui/0=non)
  Code_Fournisseur     varchar(10) default '',                    -- Code fournisseur chez le client
  Numero_Compte        char(8) default null,                      -- Numéro de compte pour liaison compta
  Mode_Reg_Id          int unsigned default null,                 -- Mode de réglement
  Delai_Reg            tinyint unsigned default 0,                -- Délai de réglement en jours
  Banque_Remise        int unsigned default null,                 -- Banque de remise
  Taux_Penalite        float(4,2) default 0,                      -- Taux de pénalité
  Taux_Remise          float(4,2) default 0,                      -- Taux de remise
  Code_Tarif           tinyint unsigned default 1,                -- Code tarifaire
  Nb_Ex                tinyint unsigned default 1,                -- Nombre d'exemplaires clients à éditer (facture/avoir)
  Num_Org              int unsigned default 0,                    -- Identifiant organisme de livraison
  Franco_Port          tinyint unsigned not null default 0,       -- Franco de port (1=oui/0=non)
  Montant_Franco       decimal(10,2) unsigned not null default 0, -- Montant du franco de port
  Frais_Port           decimal(14,2) unsigned not null default 0, -- Montant ou pourcentage de frais de port
  Type_Port            char(1) not null default 'M',              -- Type de frais de port (P=Pourcentage,M=Montant)
  Type_Reg             char(1) default 'N',                       -- Type de réglement (F=fin de mois,N=net,L=Fin de mois le)
  Jour_Fact            tinyint unsigned default 0,                -- Jour de facturation pour le type de règlement L
  Nb_Bon               tinyint unsigned default 1,                -- Nombre d'exemplaires du bon de livraison
  Bon_Chiffre          tinyint unsigned default 0,                -- Bon de livraison chiffré (1=oui,0=non)
  Encours_Auto         decimal(14,2) default 0,                   -- Montant de l'encours autorisé
  Type_Fact            char(2) default 'CC',                      -- Type de facturation (GA=Groupement d'Affaires, GC=Groupement de Commandes, CC=Commande, BL=Bon de Livraison)
  Com_Fact             text,                                      -- Commentaire sur facture
  Indications          text,                                      -- Indications de commande
  Type_Client          char(1) default 'E',                       -- Type de client (P=particulier,E=entreprise,O=organisme publique,A=Association)
  Assujetti_TVA        tinyint unsigned default 0,                -- Assujetti à la TVA (1=oui/0=non)
  Mode_Envoi_Facture   char(1) default 'C',                       -- Mode d'envoi de la facture (C=Courrier,F=Fax,M=Mail)
  Periode_Facturation  char(1) default 'I',                       -- Période de facturation (I=Immédiate,M=Fin de mois)
  Mode_Facturation     char(1) default 'E',                       -- Mode de facturation (E=A l'Expédition, C=A la Commande)
  Taux_Commission      decimal(4,2) default 0,                    -- Taux de commission
  Secteur_Activite     int unsigned default null,                 -- Secteur d'activité
  Activation_CP        tinyint unsigned default 1,                -- Activation automatique des codes produits à la livraison
  Fact_Sep_FP          tinyint unsigned default 0,                -- Facturation séparée des frais de port (1=oui/0=non)
  primary key (Client_Id),
  index idx_secteur_activite (Secteur_Activite),
  index idx_type_societe (Type_Societe),
  index idx_numero_compte (Numero_Compte),
  index idx_famille_id (Famille_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  constraint cfk_fiche_client_type_societe foreign key (Type_Societe) references TYPE_SOCIETE (Type_Societe_Id),
  constraint cfk_fiche_client_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_fiche_client_numero_compte foreign key (Numero_Compte) references COMPTE (Numero_Compte),
  constraint cfk_fiche_client_famille_id foreign key (Famille_Id) references FAMILLE_CLIENT (Famille_Id),
  constraint cfk_fiche_client_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;



create table BANQUE_CLIENT (
  Banque_Id       int unsigned not null auto_increment,  -- Identifiant banque
  Client_Id       char(10) not null,                     -- Identifiant client
  Nom             varchar(30) default '',                -- Nom de la banque
  Adresse         varchar(80) default '',                -- Domiciliation
  Code_Agence     varchar(5) default '',                 -- Code agence
  Code_Guichet    varchar(5) default '',                 -- Code guichet
  Num_Compte      varchar(11) default '',                -- Numéro de compte
  Cle_RIB         varchar(2) default '',                 -- Clé de RIB
  IBAN            varchar(27) default '',                -- 27 caractères du numéro IBAN
  BIC             varchar(11) default '',                -- Numéro BIC
  primary key (Banque_Id),
  index idx_client_id (Client_Id),
  constraint cfk_banque_client_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade
) engine=InnoDB;



create table CONTACT_CLIENT (
  Num_Inter       int unsigned not null auto_increment,  -- Identifiant du contact
  Client_Id       char(10) not null,                     -- Identifiant client
  Prospect_Id     int default null,                      -- Identifiant compte prospect
  Civilite        tinyint unsigned default 0,            -- Civilite (M=1,Mme=2,Mlle=3)
  Nom             varchar(30) default '',                -- Nom de l'intervenant
  Prenom          varchar(20) default '',                -- Prenom de l'intervenant
  Date_Naissance  bigint default 0,                      -- Date de naissance
  Fonction        varchar(25) default '',                -- Fonction dans l'entreprise
  Infos           text,                                  -- Informations libres
  Adresse         varchar(100) default '',               -- Adresse
  Code_Postal     varchar(10) default '',                -- Code postal
  Ville           varchar(50) default '',                -- Ville
  Tel             varchar(20) default '',                -- Téléphone
  Portable        varchar(20) default '',                -- Téléphone portable
  Fax             varchar(20) default '',                -- Fax
  Email           varchar(60) default '',                -- Adresse e-mail
  Site_Web        varchar(40) default '',                -- Site web
  Principal_Fact  tinyint unsigned default 0,            -- Interlocuteur principal de facturation (1=oui/0=non)
  Principal_Liv   tinyint unsigned default 0,            -- Interlocuteur principal de livraison (1=oui/0=non)
  Principal_Envoi tinyint unsigned default 0,            -- Interlocuteur principal d'envoi des documents (1=oui/0=non)
  Relation        char(1) default 'O',                   -- Type de relation (O=occasionnelle,H=habituelle)
  Code_Pays       char(2) default 'FR',                  -- Code pays
  primary key (Num_Inter),
  index idx_client_id (Client_Id),
  index idx_prospect_id (Prospect_Id),
  constraint cfk_contact_client_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade
) engine=InnoDB;



create table ADRESSE_CLIENT (
  Adresse_Id      int unsigned not null auto_increment,  -- Identifiant de l'adresse
  Client_Id       char(10) not null,                     -- Identifiant client
  Denomination    varchar(50) default '',                -- Raison sociale
  Adresse_1       varchar(80) default '',                -- Ligne d'adresse 1
  Adresse_2       varchar(50) default '',                -- Ligne d'adresse 2
  Adresse_3       varchar(50) default '',                -- Ligne d'adresse 3
  Code_Postal     varchar(10) default '',                -- Code postal
  Ville           varchar(50) default '',                -- Ville
  Code_Pays       char(2) default 'FR',                  -- Code pays
  Defaut_Liv      tinyint unsigned default 0,            -- Adresse de livraison par défaut (1=oui/0=non)
  Defaut_Fact     tinyint unsigned default 0,            -- Adresse de facturation par défaut (1=oui/0=non)
  Defaut_Envoi    tinyint unsigned default 0,            -- Adresse d'envoi par défaut (1=oui/0=non)
  Contact_Liv     int unsigned default null,             -- Identifiant du contact pour la livraison
  Contact_Fact    int unsigned default null,             -- Identifiant du contact pour la facturation
  Contact_Envoi   int unsigned default null,             -- Identifiant du contact pour l'envoi
  primary key (Adresse_Id),
  index idx_client_id (Client_Id),
  index idx_contact_liv (Contact_Liv),
  index idx_contact_fact (Contact_Fact),
  index idx_contact_envoi (Contact_Envoi),
  constraint cfk_adresse_client_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_adresse_client_contact_liv foreign key (Contact_Liv) references CONTACT_CLIENT (Num_Inter),
  constraint cfk_adresse_client_contact_fact foreign key (Contact_Fact) references CONTACT_CLIENT (Num_Inter),
  constraint cfk_adresse_client_contact_envoi foreign key (Contact_Envoi) references CONTACT_CLIENT (Num_Inter)
) engine=InnoDB;


-- ----- TABLES FOURNISSEURS --------------------------------------------------------------------------------------------------------------------


create table FAMILLE_FOURNISSEUR (
  Famille_Id       int unsigned not null auto_increment,     -- Identifiant de la famille
  Libelle          varchar(40) default '',                   -- Libellé de la famille
  Actif            tinyint unsigned default 1,               -- Valeur active (oui/non)
  primary key (Famille_Id),
  unique (Libelle)
) engine=InnoDB;


create table FICHE_FOURNISSEUR (
  Fournisseur_Id      char(10) not null,                         -- Identifiant unique du fournisseur
  Civilite            tinyint unsigned default 0,                -- Civilité (M=1,Mme=2,Mlle=3)
  Nom                 varchar(30) default '',                    -- Nom
  Prenom              varchar(20) default '',                    -- Prénom
  Denomination        varchar(50) default '',                    -- Raison sociale
  Adresse_1           varchar(80) default '',                    -- Ligne d'adresse 1
  Adresse_2           varchar(50) default '',                    -- Ligne d'adresse 2
  Adresse_3           varchar(50) default '',                    -- Ligne d'adresse 3
  Code_Postal         varchar(10) default '',                    -- Code postal
  Ville               varchar(50) default '',                    -- Ville
  Code_Pays           char(2) default 'FR',                      -- Code pays
  Tel_1               varchar(20) default '',                    -- Téléphone 1
  Tel_2               varchar(20) default '',                    -- Téléphone 2
  Tel_3               varchar(20) default '',                    -- Téléphone 3
  Fax_1               varchar(20) default '',                    -- Fax 1
  Fax_2               varchar(20) default '',                    -- Fax 2
  Email_1             varchar(60) default '',                    -- Adresse e-mail 1
  Email_2             varchar(60) default '',                    -- Adresse e-mail 2
  Site_Web            varchar(40) default '',                    -- Site web de la société
  Date_C              bigint unsigned default 0,                 -- Date de création de la fiche fournisseur
  Date_M              bigint unsigned default 0,                 -- Date de mise à jour de la fiche fournisseur
  Util_R              int default null,                          -- Utilisateur responsable de la commande
  Util_C              int not null,                              -- Utilisateur créateur de la fiche fournisseur
  Util_M              int not null,                              -- Utilisateur ayant fait la dernière modification de la fiche fournisseur
  Com_Libre           text,                                      -- Commentaires libres
  Code_Couleur        tinyint unsigned default 2,                -- Code de couleur définissant l'importance du fournisseur
  Type_Societe        int unsigned default null,                 -- Type de société (SARL, SA...)
  Famille_Id          int unsigned default null,                 -- Famille
  Num_TVA_Intra       varchar(14) default '',                    -- Numéro de TVA intracommunautaire
  Num_SIRET           char(14) default '',                       -- Numéro de SIRET
  Code_NAF            char(5) default '',                        -- Code NAF
  Qualite_Relation    char(1) default 'B',                       -- Qualité de la relation avec le fournisseur (B=bonne,E=Excellente,M=moyenne,N=nulle)
  Respect_Delai       tinyint unsigned default 1,                -- Respect des délais de livraison (1=oui/0=non)
  Competitivite       tinyint unsigned default 1,                -- Compétitivité des prix obtenus / prix marché (note de 1 à 5)
  Supprime            tinyint unsigned default 0,                -- Fournisseur supprimé virtuellement (1=oui/0=non)
  Taux_Remise         decimal(4,2) default 0,                    -- Taux de remise permanent
  Remise_1            decimal(4,2) default 0,                    -- Taux de remise tranche 1
  Remise_2            decimal(4,2) default 0,                    -- Taux de remise tranche 2
  Remise_3            decimal(4,2) default 0,                    -- Taux de remise tranche 3
  Remise_4            decimal(4,2) default 0,                    -- Taux de remise tranche 4
  Remise_5            decimal(4,2) default 0,                    -- Taux de remise tranche 5
  Tranche_CA0         decimal(14,2) default 0,                   -- Tranche de CA 0
  Tranche_CA1         decimal(14,2) default 0,                   -- Tranche de CA 1
  Tranche_CA2         decimal(14,2) default 0,                   -- Tranche de CA 2
  Tranche_CA3         decimal(14,2) default 0,                   -- Tranche de CA 3
  Tranche_CA4         decimal(14,2) default 0,                   -- Tranche de CA 4
  Taux_RFA            decimal(4,2) default 0,                    -- Taux de remise RFA
  Remise_Fixe         decimal(14,2) default 0,                   -- Montant de remise fixe
  Remise_Var          decimal(4,2) default 0,                    -- Part variable de remise
  Franco_Port         tinyint unsigned not null default 0,       -- Franco de port (1=oui/0=non)
  Montant_Franco      decimal(10,2) unsigned not null default 0, -- Montant du franco de port
  Frais_Port          decimal(14,2) unsigned not null default 0, -- Montant ou pourcentage de frais de port
  Type_Port           char(1) not null default 'M',              -- Type de frais de port (P=Pourcentage,M=Montant)
  Delai_Livraison     tinyint unsigned default 0,                -- Délai de reappro par defaut en jours
  Mode_Reg_Id         int unsigned default null,                 -- Mode de réglement
  Delai_Reg           tinyint unsigned default 0,                -- Délai de réglement en jours
  Type_Reg            char(1) default 'N',                       -- Type de réglement (F=fin de mois,N=net,L=Fin de mois le)
  Jour_Fact           tinyint unsigned default 0,                -- Jour de facturation pour le type de règlement L
  Code_Client         varchar(30) default '',                    -- Code client chez le fournisseur
  Site_Web_Com        varchar(40) default '',                    -- Adresse site web de commande
  Login_Web           varchar(20) default '',                    -- Login pour commande par internet
  Pass_Web            varchar(20) default '',                    -- Mot de passe pour commande par internet
  Numero_Compte       char(8) default null,                      -- Numéro de compte pour liaison compta
  Encours_Auto        decimal(14,2) default 0,                   -- Montant de l'en-cours autorisé
  Actif               tinyint unsigned default 1,                -- Compte en activité (1=actif,0=inactif)
  Date_Ouverture      bigint unsigned default 0,                 -- Date d'ouverture du compte
  Indications         text,                                      -- Indications de commande
  Logisticien         tinyint unsigned default 0,                -- Fournisseur logisticien (1=oui/0=non)
  Secteur_Activite    int unsigned default null,                 -- Secteur d'activité
  Banque_Retrait      int unsigned default null,                 -- Banque de retrait pour le paiement
  primary key (Fournisseur_Id),
  index idx_type_societe (Type_Societe),
  index idx_numero_compte (Numero_Compte),
  index idx_famille_id (Famille_Id),
  index idx_secteur_activite (Secteur_Activite),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_banque_retrait (Banque_Retrait),
  constraint cfk_fiche_fournisseur_type_societe foreign key (Type_Societe) references TYPE_SOCIETE (Type_Societe_Id),
  constraint cfk_fiche_fournisseur_numero_compte foreign key (Numero_Compte) references COMPTE (Numero_Compte),
  constraint cfk_fiche_fournisseur_famille_id foreign key (Famille_Id) references FAMILLE_FOURNISSEUR (Famille_Id),
  constraint cfk_fiche_fournisseur_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_fiche_fournisseur_banque_retrait foreign key (Banque_Retrait) references BANQUE (Banque_Id),
  constraint cfk_fiche_fournisseur_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;


create table CONTACT_FOURNISSEUR (
  Num_Inter           int unsigned not null auto_increment,  -- Numéro d'interlocuteur
  Fournisseur_Id      char(10) default '',                   -- Identifiant fournisseur
  Civilite            tinyint unsigned default 0,            -- Civilité (M=1,Mme=2,Mlle=3)
  Nom                 varchar(30) default '',                -- Nom de l'interlocuteur
  Prenom              varchar(20) default '',                -- Prénom de l'interlocuteur
  Fonction            varchar(25) default '',                -- Fonction dans l'entreprise
  Relation            char(1) default 'O',                   -- Type de relation (O=occasionnelle,H=habituelle)
  Infos               text,                                  -- Informations libres
  Adresse             varchar(100) default '',               -- Adresse
  Code_Postal         varchar(10) default '',                -- Code postal
  Ville               varchar(50) default '',                -- Ville
  Tel                 varchar(20) default '',                -- Téléphone fixe
  Portable            varchar(20) default '',                -- Téléphone portable
  Fax                 varchar(20) default '',                -- Fax
  Email               varchar(60) default '',                -- Adresse e-mail
  Site_Web            varchar(40) default '',                -- Site web
  Principal           tinyint unsigned default 0,            -- Interlocuteur principal (1=oui/0=non)
  Date_Naissance      bigint default 0,                      -- Date de naissance
  Code_Pays           char(2) default 'FR',                  -- Code pays
  primary key (Num_Inter),
  index idx_fournisseur_id (Fournisseur_Id),
  constraint cfk_contact_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade
) engine=InnoDB;


create table ADRESSE_FOURNISSEUR (
  Num_Adresse         int unsigned not null auto_increment,  -- Numéro de l'adresse
  Fournisseur_Id      char(10) default '',                   -- Identifiant fournisseur
  Denomination        varchar(50) default '',                -- Raison sociale
  Adresse_1           varchar(80) default '',                -- Ligne d'adresse 1
  Adresse_2           varchar(50) default '',                -- Ligne d'adresse 2
  Adresse_3           varchar(50) default '',                -- Ligne d'adresse 3
  Code_Postal         varchar(10) default '',                -- Code postal
  Ville               varchar(50) default '',                -- Ville
  Code_Pays           char(2) default 'FR',                  -- Code pays
  Defaut              tinyint unsigned default 0,            -- Adresse par défaut (1=oui/0=non)
  Contact             int unsigned default null,             -- Identifiant du contact
  primary key (Num_Adresse),
  index idx_fournisseur_id (Fournisseur_Id),
  index idx_contact (Contact),
  constraint cfk_adresse_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade,
  constraint cfk_adresse_fournisseur_contact foreign key (Contact) references CONTACT_FOURNISSEUR (Num_Inter)
) engine=InnoDB;


create table BANQUE_FOURNISSEUR (
  Banque_Id           int unsigned not null auto_increment,  -- Identifiant banque
  Fournisseur_Id      char(10) default '',                   -- Identifiant client
  Nom                 varchar(30) default '',                -- Nom de la banque
  Adresse             varchar(80) default '',                -- Domiciliation
  Code_Agence         varchar(5) default '',                 -- Code agence
  Code_Guichet        varchar(5) default '',                 -- Code guichet
  Num_Compte          varchar(11) default '',                -- Numéro de compte
  Cle_RIB             varchar(2) default '',                 -- Clé de RIB
  IBAN                varchar(27) default '',                -- 27 caractères du numéro IBAN
  BIC                 varchar(11) default '',                -- Numéro BIC
  primary key (Banque_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  constraint cfk_banque_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade
) engine=InnoDB;


-- ----- TABLES STOCKS --------


create table MARQUE_ARTICLE (
  Marque_Id        int unsigned not null auto_increment, -- Identifiant de la marque
  Libelle          varchar(40) default '',               -- Libellé de la marque
  Actif           tinyint unsigned default 1,            -- Valeur active (oui/non)
  primary key (Marque_Id),
  unique (Libelle)
) engine=InnoDB;


create table FAMILLE_ARTICLE (
  Famille_Id       int unsigned not null auto_increment, -- Identifiant de la famille
  Parent_Id        int unsigned default null,            -- Identifiant de la famille parente
  Niveau           tinyint unsigned default 1,           -- Niveau dans la hiérarchie des familles
  Libelle          varchar(40) default '',               -- Libellé de la famille
  Actif            tinyint unsigned default 1,           -- Valeur active (oui/non)
  primary key (Famille_Id),
  unique (Parent_Id, Libelle),
  index idx_parent_id (Parent_Id),
  constraint cfk_famille_article_parent_id foreign key (Parent_Id) references FAMILLE_ARTICLE (Famille_Id)
) engine=InnoDB;


create table LISTE_ATTRIBUT (
  Liste_Id         int not null,                         -- Identifiant de la liste
  Nom              varchar(15) not null,                 -- Nom de la liste
  Circonst         tinyint unsigned not null default 0,  -- Liste d'attribut circonstanciée par famille
  primary key (Liste_Id)
) engine=InnoDB;


create table ATTRIBUT_ARTICLE (
  Attribut_Id      int not null auto_increment,          -- Identifiant de l'attribut
  Liste_Id         int not null,                         -- Identifiant de la liste
  Libelle          varchar(40) not null,                 -- Libellé de l'attribut
  Actif            tinyint unsigned not null default 1,  -- Attribut actif (oui/non)
  Rank             smallint unsigned not null,           -- Numéro d'ordre par liste
  primary key (Attribut_Id),
  unique (Liste_Id, Libelle),
  constraint cfk_attribut_article_liste_id foreign key (Liste_Id) references LISTE_ATTRIBUT (Liste_Id)
) engine=InnoDB;


create table ATTRIBUT_FAMILLE_ARTICLE (
  Attribut_Id      int not null,                         -- Identifiant de l'attribut d'article
  Famille_Id       int unsigned not null,                -- Identifiant de la famille d'article
  primary key (Attribut_Id, Famille_Id),
  constraint cfk_attribut_famille_article_attribut_id foreign key (Attribut_Id) references ATTRIBUT_ARTICLE (Attribut_Id),
  constraint cfk_attribut_famille_article_famille_id foreign key (Famille_Id) references FAMILLE_ARTICLE (Famille_Id)
) engine=InnoDB;


create table FICHE_ARTICLE (
  Fiche_Article_Id          int not null auto_increment,               -- Identifiant article
  Article_Id                char(40) not null,                         -- Code Article
  Ref_Modele                varchar(15) not null default '',           -- Référence du modèle de l'article
  Designation               varchar(100) default '',                   -- Désignation article
  Marque_Id                 int unsigned default null,                 -- Marque
  Famille_1                 int unsigned not null,                     -- Famille niveau 1
  Famille_2                 int unsigned default null,                 -- Famille niveau 2
  Famille_3                 int unsigned default null,                 -- Famille niveau 3
  Unite                     char(3) default 'U',                       -- Unité de vente (U,g,kg,t,m³,l,m²,mm²,m)
  Colisage                  decimal(10,3) unsigned default 0,          -- Quantité par colis
  Prix_Achat_Der            decimal(14,4) unsigned default 0,          -- Dernier prix d'achat de l'article
  Code_TVA                  int unsigned default 1,                    -- Code TVA
  Frais_Appro_Der           decimal(14,4) unsigned default 0,          -- Derniers frais d'appro de l'article
  Tarif_1                   decimal(14,4) unsigned default 0,          -- Tarif 1 HT
  Tarif_2                   decimal(14,4) unsigned default 0,          -- Tarif 2 HT
  Tarif_3                   decimal(14,4) unsigned default 0,          -- Tarif 3 HT
  Tarif_4                   decimal(14,4) unsigned default 0,          -- Tarif 4 HT
  Tarif_5                   decimal(14,4) unsigned default 0,          -- Tarif 5 HT
  Coeff_1                   decimal(10,6) unsigned default 1.1,        -- Coefficient multiplicateur 1
  Coeff_2                   decimal(10,6) unsigned default 1.2,        -- Coefficient multiplicateur 2
  Coeff_3                   decimal(10,6) unsigned default 1.3,        -- Coefficient multiplicateur 3
  Coeff_4                   decimal(10,6) unsigned default 1.4,        -- Coefficient multiplicateur 4
  Coeff_5                   decimal(10,6) unsigned default 1.5,        -- Coefficient multiplicateur 5
  Tarif_1_TTC               decimal(14,4) unsigned default 0,          -- Tarif 1 TTC
  Tarif_2_TTC               decimal(14,4) unsigned default 0,          -- Tarif 2 TTC
  Tarif_3_TTC               decimal(14,4) unsigned default 0,          -- Tarif 3 TTC
  Tarif_4_TTC               decimal(14,4) unsigned default 0,          -- Tarif 4 TTC
  Tarif_5_TTC               decimal(14,4) unsigned default 0,          -- Tarif 5 TTC
  Marge_1                   decimal(5,2) unsigned default 0,           -- Marge 1
  Marge_2                   decimal(5,2) unsigned default 0,           -- Marge 2
  Marge_3                   decimal(5,2) unsigned default 0,           -- Marge 3
  Marge_4                   decimal(5,2) unsigned default 0,           -- Marge 4
  Marge_5                   decimal(5,2) unsigned default 0,           -- Marge 5
  Prix_Achat                decimal(14,4) default 0,                   -- Prix d'achat retenu servant au calcul des prix de vente
  Frais_Appro               decimal(12,3) default 0,                   -- Frais d'appro servant au calcul des prix de vente
  Nature                    tinyint unsigned default 1,                -- Nature (produit fini=1/matiere premiere=0)
  Art_Achat                 tinyint unsigned default 1,                -- Article à l'achat (1=oui/0=non)
  Art_Vente                 tinyint unsigned default 1,                -- Article à la vente (1=oui/0=non)
  Prestation                tinyint unsigned default 0,                -- L'article est une prestation de service (1=oui/0=non)
  Poids_Brut                decimal(10,3) unsigned not null default 0, -- Poids brut
  Poids_Net                 decimal(10,3) unsigned not null default 0, -- Poids net
  Unite_Poids               int not null,                              -- Unité de poids pour les poids brut et net
  Attribut_1                int default null,                          -- Attribut numéro 1
  Attribut_2                int default null,                          -- Attribut numéro 2
  Attribut_3                int default null,                          -- Attribut numéro 3
  Attribut_4                int default null,                          -- Attribut numéro 4
  Attribut_5                int default null,                          -- Attribut numéro 5
  Attribut_6                int default null,                          -- Attribut numéro 6
  Localisation              varchar(30) default '',                    -- Localisation physique (entrepôt, étagère...)
  Code_Barre                varchar(15) default '',                    -- Code barre associé a l'article (norme EAN et UPC)
  Conditionnement           varchar(30) default '',                    -- Conditionnement (palette, pack...)
  Article_Substitution      varchar(40) default '',                    -- Article de substitution
  Date_C                    bigint unsigned default 0,                 -- Date de création de la fiche
  Date_M                    bigint unsigned default 0,                 -- Date de modification de la fiche
  Util_C                    int not null,                              -- Utilisateur créateur de la fiche
  Util_M                    int not null,                              -- Utilisateur ayant fait la dernière modification de la fiche
  Descrip_1                 text,                                      -- Description niveau 1
  Descrip_2                 text,                                      -- Description niveau 2
  Hauteur                   decimal(6,2) unsigned not null default 0,  -- Hauteur
  Longueur                  decimal(6,2) unsigned not null default 0,  -- Longueur
  Largeur                   decimal(6,2) unsigned not null default 0,  -- Largeur
  Unite_Dimensions          int not null,                              -- Unité pour les dimensions
  Volume                    decimal(6,2) unsigned not null default 0,  -- Volume
  Unite_Volume              int not null,                              -- Unité pour le volume
  Supprime                  tinyint unsigned default 0,                -- Article supprimé virtuellement (1=oui/0=non)
  Base_Calcul               tinyint unsigned default 1,                -- Tarification sur qté à partir d'une base de calcul (1=oui/0=non)
  Eco_Taxe                  decimal(10,2) unsigned default 0,          -- Montant de l'eco-participation
  Ref_Fabricant             varchar(40) default '',                    -- Référence fabricant
  Prix_Public               decimal(12,2) unsigned default 0,          -- Prix public
  Composition               char(1) default 'U',                       -- Article composé (N=Nomenclature, F=Forfait, U=Article unique)
  Code_Stats                varchar(10) default '',                    -- Code de statistiques
  Code_NC8                  varchar(8) default '',                     -- Code NC8
  Tracabilite_CP            tinyint unsigned default 0,                -- Traçabilité des codes produits (1=oui/0=non)
  Imp_Nom_Devis             tinyint unsigned default 0,                -- Impression nomenclature sur devis
  Imp_Nom_OF                tinyint unsigned default 0,                -- Impression nomenclature sur of
  Imp_Nom_Facture           tinyint unsigned default 0,                -- Impression nomenclature sur facture
  Imp_Nom_Bon               tinyint unsigned default 0,                -- Impression nomenclature sur bl
  Imp_Nom_Fiche             tinyint unsigned default 0,                -- Impression nomenclature sur fiche
  Imp_Nom_BP                tinyint unsigned default 0,                -- Impression nomenclature sur BP
  Imp_Nom_BCF               tinyint unsigned default 0,                -- Impression nomenclature sur BC fournisseur
  Imp_Desc1_Devis           tinyint unsigned default 0,                -- Impression description 1 sur devis
  Imp_Desc1_OF              tinyint unsigned default 0,                -- Impression description 1 sur of
  Imp_Desc1_Facture         tinyint unsigned default 0,                -- Impression description 1 sur facture
  Imp_Desc1_Bon             tinyint unsigned default 0,                -- Impression description 1 sur bl
  Imp_Desc1_Fiche           tinyint unsigned default 0,                -- Impression description 1 sur fiche
  Imp_Desc1_BP              tinyint unsigned default 0,                -- Impression description 1 sur BP
  Imp_Desc1_BCF             tinyint unsigned default 0,                -- Impression description 1 sur BC fournisseur
  Imp_Desc2_Devis           tinyint unsigned default 0,                -- Impression description 2 sur devis
  Imp_Desc2_OF              tinyint unsigned default 0,                -- Impression description 2 sur of
  Imp_Desc2_Facture         tinyint unsigned default 0,                -- Impression description 2 sur facture
  Imp_Desc2_Bon             tinyint unsigned default 0,                -- Impression description 2 sur bl
  Imp_Desc2_Fiche           tinyint unsigned default 0,                -- Impression description 2 sur fiche
  Imp_Desc2_BP              tinyint unsigned default 0,                -- Impression description 2 sur BP
  Imp_Desc2_BCF             tinyint unsigned default 0,                -- Impression description 2 sur BC fournisseur
  primary key (Fiche_Article_Id),
  unique(Article_Id),
  index idx_famille_1 (Famille_1),
  index idx_famille_2 (Famille_2),
  index idx_famille_3 (Famille_3),
  index idx_marque_id (Marque_Id),
  index idx_attribut_1 (Attribut_1),
  index idx_attribut_2 (Attribut_2),
  index idx_attribut_3 (Attribut_3),
  index idx_attribut_4 (Attribut_4),
  index idx_attribut_5 (Attribut_5),
  index idx_attribut_6 (Attribut_6),
  index idx_unite_volume (Unite_Volume),
  index idx_unite_dimensions (Unite_Dimensions),
  index idx_unite_poids (Unite_Poids),
  index idx_code_tva (Code_TVA),
  constraint cfk_fiche_article_famille_1 foreign key (Famille_1) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_fiche_article_famille_2 foreign key (Famille_2) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_fiche_article_famille_3 foreign key (Famille_3) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_fiche_article_marque_id foreign key (Marque_Id) references MARQUE_ARTICLE (Marque_Id),
  constraint cfk_fiche_article_attribut_1 foreign key (Attribut_1) references ATTRIBUT_ARTICLE (Attribut_Id),
  constraint cfk_fiche_article_attribut_2 foreign key (Attribut_2) references ATTRIBUT_ARTICLE (Attribut_Id),
  constraint cfk_fiche_article_attribut_3 foreign key (Attribut_3) references ATTRIBUT_ARTICLE (Attribut_Id),
  constraint cfk_fiche_article_attribut_4 foreign key (Attribut_4) references ATTRIBUT_ARTICLE (Attribut_Id),
  constraint cfk_fiche_article_attribut_5 foreign key (Attribut_5) references ATTRIBUT_ARTICLE (Attribut_Id),
  constraint cfk_fiche_article_attribut_6 foreign key (Attribut_6) references ATTRIBUT_ARTICLE (Attribut_Id),
  constraint cfk_fiche_article_unite_volume foreign key (Unite_Volume) references UNITE_VENTE (Unite_Id),
  constraint cfk_fiche_article_unite_dimensions foreign key (Unite_Dimensions) references UNITE_VENTE (Unite_Id),
  constraint cfk_fiche_article_unite_poids foreign key (Unite_Poids) references UNITE_VENTE (Unite_Id),
  constraint cfk_fiche_article_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA)
) engine=InnoDB;


create table STOCKS_ARTICLE (
  Article_Id          char(40) not null,                  -- Code article
  Prix_Init           decimal(14,4) unsigned default 0,   -- Prix moyen d'un article du stock initial
  Frais_Init          decimal(14,4) unsigned default 0,   -- Frais d'appro moyens d'un article du stock initial
  Stock_Init          decimal(10,3) unsigned default 0,   -- stock initial dernier inventaire
  Entrees             decimal(10,3) default 0,            -- entrees article
  Sorties             decimal(10,3) default 0,            -- sorties article
  Com_Clients         decimal(10,3) default 0,            -- commandes des clients
  Com_Fournisseurs    decimal(10,3) default 0,            -- commandes des fournisseurs
-- Stock_Minimum       decimal(10,3) unsigned default 0,  -- stock minimum
  Stock_Alerte        decimal(10,3) unsigned default 0,   -- stock d'alerte
  Stock_Securite      decimal(10,3) unsigned default 0,   -- stock de sécurité
  Stock_Maximum       decimal(10,3) unsigned default 0,   -- stock maximum
  Date_Inventaire     bigint unsigned default 0,          -- date du dernier inventaire
  primary key (Article_Id),
  constraint cfk_stocks_article_article_id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id)
) engine=InnoDB;


create table COMPTE_ARTICLE (
  Article_Id          char(40) not null,                 -- Identifiant de l'article
  Code_TVA            int unsigned not null,             -- Code TVA
  Compte_Vente        char(8) default null,              -- Compte de vente
  Compte_Achat        char(8) default null,              -- Compte d'achat
  primary key (Article_Id, Code_TVA),
  index idx_code_tva (Code_TVA),
  index idx_compte_vente (Compte_Vente),
  index idx_compte_achat (Compte_Achat),
  constraint cfk_compte_article_article_Id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id),
  constraint cfk_compte_article_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_compte_article_compte_vente foreign key (Compte_Vente) references COMPTE (Numero_Compte),
  constraint cfk_compte_article_compte_achat foreign key (Compte_Achat) references COMPTE (Numero_Compte)
) engine=InnoDB;


create table COMPTE_ARTICLE_TVA_NATIONAL_UE (
  Article_Id       char(40) not null,          -- Identifiant de l'article
  Code_TVA         int unsigned not null,      -- Code TVA d'un taux francais > 0
  Code_Pays        char(2) not null,           -- Code pays de l'UE (hors France)
  Compte_Vente     char(8) not null,           -- Numéro de compte de vente
  primary key (Article_Id, Code_TVA, Code_Pays),
  index idx_compte_vente (Compte_Vente),
  constraint cfk_compte_article_tva_national_ue_article_Id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id),
  constraint cfk_compte_article_tva_national_ue_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_compte_article_tva_national_ue_compte_vente foreign key (Compte_Vente) references COMPTE (Numero_Compte)
) engine=InnoDB;


create table MVT_STOCK (
  Mvt_Id              int unsigned not null auto_increment,       -- Identifiant du mouvement
  Article_Id          char(40) not null,                          -- Référence article
  Date_Mvt            bigint unsigned default 0,                  -- Date du mouvement
  Type_Mvt            char(1) default '',                         -- Type de mouvement (E=entrée,S=sortie)
  Quantite            decimal(10,3) unsigned not null default 0,  -- Quantité
  Frais_Appro         decimal(10,2) unsigned default 0,           -- Frais d'approvisionnement HT (proratisation des frais de port)
  Prix_HT             decimal(14,4) unsigned default 0,           -- Cout d'achat HT (Prix d'achat + Frais d'approvisionnement)
  Num_Piece           varchar(12) not null default '',            -- Numéro de pièce (facture, commande, avoir...)
  Libelle             varchar(50) default '',                     -- Libellé du mouvement
  primary key (Mvt_Id),
  index idx_article_id (Article_Id),
  constraint cfk_mvt_stock_article_id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id)
) engine=InnoDB;


create table MVT_COM_CLIENT (
  Mvt_Id              int unsigned not null auto_increment,  -- Identifiant de la réservation
  Article_Id          int not null,                          -- Identifiant de l'article
  Date_Mvt            bigint unsigned default 0,             -- Date du mouvement
  Quantite            decimal(10,3) default 0,               -- Quantité
  Num_Piece           varchar(12) not null default '',       -- Numéro de pièce
  Libelle             varchar(50) default '',                -- Libellé du mouvement
  primary key (Mvt_Id),
  index idx_article_id (Article_Id),
  constraint cfk_mvt_com_client_article_id foreign key (Article_Id) references FICHE_ARTICLE (Fiche_Article_Id)
) engine=InnoDB;


create table MVT_COM_FOURNISSEUR (
  Mvt_Id              int unsigned not null auto_increment,  -- Identifiant de la réservation
  Article_Id          int not null,                          -- Identifiant de l'article
  Date_Mvt            bigint unsigned default 0,             -- Date du mouvement
  Quantite            decimal(10,3) default 0,               -- Quantité
  Num_Piece           varchar(12) not null default '',       -- Numéro de pièce
  Libelle             varchar(50) default '',                -- Libellé du mouvement
  primary key (Mvt_Id),
  index idx_article_id (Article_Id),
  constraint cfk_mvt_com_fournisseur_article_id foreign key (Article_Id) references FICHE_ARTICLE (Fiche_Article_Id)
) engine=InnoDB;


create table STOCK_ANOUVEAU (
  San_Id             int unsigned not null auto_increment,   -- Identifiant du stock à nouveau
  Article_Id         int not null,                           -- Identifiant de l'article
  Periode            bigint unsigned not null,               -- Période (1er jour du mois)
  Valorisation       decimal(14,2) default 0,                -- Valorisation unitaire au 1er jour de la période (y compris frais appro)
  Frais_Appro        decimal(10,2) default 0,                -- Valorisation des frais d'approvisionnement
  Quantite           decimal(10,3) default 0,                -- Quantité en stock au 1er jour de la période
  primary key (San_Id),
  unique(Article_Id, Periode),
  index idx_article_id (Article_Id),
  constraint cfk_stock_anouveau_article_id foreign key (Article_Id) references FICHE_ARTICLE (Fiche_Article_Id)
) engine=InnoDB;


create table TARIF_QTE (
  Tarif_Id            int unsigned not null auto_increment,  -- identifiant tarif
  Article_Id          char(40) default '',                   -- code Article
  Prix                decimal(14,4) unsigned default 0,      --
  Prix_TTC            decimal(14,4) unsigned default 0,      -- prix ttc
  Coeff               decimal(8,6) unsigned default 1,       --
  Marge               decimal(5,2) unsigned default 0,       -- pourcentage de marge
  Quantite            decimal(10,3) unsigned default 0,      --
  Lib_Int             varchar(20) default '',                -- libellé interne
  Lib_Ext             varchar(20) default '',                -- libellé externe
  primary key (Tarif_Id),
  index idx_article_id (Article_Id),
  constraint cfk_tarif_qte_article_id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id)
) engine=InnoDB;


create table FOURNISSEUR_ARTICLE (
  Article_Id          char(40) not null,                 -- Code Article
  Fournisseur_Id      char(10) not null,                 -- Code Fournisseur
  Prix_Achat          decimal(14,4) unsigned default 0,  -- Prix achat de l'article
  Ref_Fournisseur     varchar(40) default '',            -- Référence article chez le fournisseur
  Principal           tinyint unsigned default 0,        -- Fournisseur principal de l'article
  Delai_Reappro       tinyint unsigned default 0,        -- Delai de reappro en jours
  Qte_Minimum         decimal(10,3) unsigned default 0,  -- Quantité minimum de commande
  Frais_Logistiques   decimal(12,2) unsigned default 0,  -- Surcout en cas de commande inférieure à la qté minimum
  Pack                int unsigned default 1,            -- Quantité d'unités du lot
  Multiple            decimal(10,3) unsigned default 0,  -- Multiple de commande
  Qte_Stock           decimal(10,3) unsigned default 0,  -- Quantité en stock chez le fournisseur
  Date_Reappro        bigint unsigned default 0,         -- Date de réappro chez le fournisseur
  primary key (Article_Id, Fournisseur_Id),
  constraint cfk_fournisseur_article_article_id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id),
  constraint cfk_fournisseur_article_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade
) engine=InnoDB;


create table COMPOSANT_ARTICLE (
  Article_Id          char(40) not null,                 -- code Article
  ArticleComp_Id      char(40) not null,                 -- code Article Composant
  Quantite            decimal(10,3) unsigned default 1,  -- quantite de l'article comp dans l'autre
  primary key (Article_Id, ArticleComp_Id),
  constraint cfk_composant_article_article_id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id),
  constraint cfk_composant_article_articlecomp_id foreign key (ArticleComp_Id) references FICHE_ARTICLE (Article_Id)
) engine=InnoDB;


create table HISTORIQUE_FABRICATION (
  Fabrication_Id      int unsigned not null auto_increment,  -- Identifiant de l'historique
  Ref_Article         char(40) not null,                     -- Référence Article
  Quantite            decimal(10,3) unsigned default 1,      -- Quantite de l'article
  Type                char(1) default 'A',                   -- A->Assemblé, D->Désassemblé
  Date                bigint unsigned default 0,             -- Date de fabrication
  Commentaires        text,                                  -- Commentaires
  primary key (Fabrication_Id)
) engine=InnoDB;


create table CLIENT_ARTICLE (
  Article_Id          char(40) not null,        -- code article
  Client_Id           char(10) not null,        -- code client
  Prix                decimal(14,4) default 0,  -- prix HT de l'article pour le client
  Prix_TTC            decimal(14,4) default 0,  -- prix TTC de l'article pour le client
  Coeff               decimal(8,6) default 1,   -- coefficient sur prix de vente original (prix = tarif_# * coeff)
  Marge               decimal(5,2) default 0,   -- marge
  primary key (Article_Id, Client_Id),
  constraint cfk_client_article_article_id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id),
  constraint cfk_client_article_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade
) engine=InnoDB;


create table FICHE_ARTICLE_CLIENT (
  Article_Id          int not null,             -- Identifiant de l'article
  Client_Id           char(10) not null,        -- Identifiant du client
  Code_Barre          varchar(15) default '',   -- Code barre spécifique du client
  Reference           varchar(40) default '',   -- Référence article spécifique du client
  primary key (Article_Id, Client_Id),
  constraint cfk_fiche_article_client_article_id foreign key (Article_Id) references FICHE_ARTICLE (Fiche_Article_Id),
  constraint cfk_fiche_article_client_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade
) engine=InnoDB;


create table LISTE_MENTIONS (
  Mention_Id        int unsigned not null auto_increment,  -- Identifiant de la mention
  Libelle           varchar(255) default '',               -- Libellé de la mention
  Actif             tinyint unsigned default 1,            -- Valeur active (oui/non)
  primary key (Mention_Id)
) engine=InnoDB;


create table CODE_PRODUIT (
  Produit_Id        int unsigned not null auto_increment,  -- Identifiant du code produit
  Numero            varchar(20) not null,                  -- Numéro unique de produit pour un article donné
  Article_Id        int not null,                          -- Identifiant de l'article
  Facture           tinyint unsigned default 0,            -- Code produit facturé (1=oui/0=non)
  Active            tinyint unsigned default 0,            -- Code produit activé (1=oui/0=non)
  primary key (Produit_Id),
  unique(Numero, Article_Id),
  index idx_article_id (Article_Id),
  constraint cfk_code_produit_article_id foreign key (Article_Id) references FICHE_ARTICLE (Fiche_Article_Id)
) engine=InnoDB;


-- ----- TABLES COMMANDES FOURNISSEURS --------


create table COMMANDE_FOURNISSEUR (
  Commande_Id         int unsigned not null auto_increment, -- Identifiant de la commande
  Numero              int unsigned default 0,               -- Numéro de la commande dans le mois
  Num_Entier          char(10) default '',                  -- Numéro unique de la commande
  Ref_Commande        varchar(20) default '',               -- Référence de la commande donnée par le fournisseur
  Util_C              int not null,                         -- Utilisateur créateur de la commande
  Util_M              int not null,                         -- Utilisateur ayant fait la dernière modification de la commande
  Util_R              int default null,                     -- Utilisateur responsable de la commande
  Date_Commande       bigint unsigned default 0,            -- Date de la commande
  Date_C              bigint unsigned default 0,            -- Date de création
  Date_M              bigint unsigned default 0,            -- Date de mise à jour
  Fournisseur_Id      char(10) default null,                -- Identifiant fournisseur
  Total_HT            decimal(14,2) default 0,              -- Total HT de la commande
  Total_TTC           decimal(14,2) default 0,              -- Total TTC de la commande
  Mode_Reg_Id         int unsigned default null,            -- Mode de règlement
  Echeance            bigint unsigned default 0,            -- Date d'échéance
  Remise              decimal(5,2) unsigned default 0,      -- Taux de remise
  MRemise             decimal(9,2) unsigned default 0,      -- Montant de remise uniquement si remise en montant sinon 0
  PRemise_FP          decimal(9,6) unsigned default 0,      -- Pourcentage de remise sur frais de port
  MRemise_FP          decimal(9,2) unsigned default 0,      -- Montant de remise sur frais de port uniquement si remise en montant sinon 0
  Escompte            decimal(5,2) unsigned default 0,      -- Taux d'escompte
  Frais_Port          decimal(10,2) unsigned default 0,     -- Montant des frais de port
  Taux_TVA_Port       decimal(4,2) unsigned default 0,      -- Taux de TVA des frais de port
  Code_TVA_Port       int unsigned not null,                -- Code de TVA des frais de port
  Commentaires_Fin    text,                                 -- Commentaires de fin de commande
  Commentaires_Int    text,                                 -- Commentaires internes non imprimables
  Commentaires_Hid    text,                                 -- Commentaires internes cachés
  Etat                char(1) default 'N',                  -- Etat de la commande (N=Non validée, P=En préparation, T=En cours, A=Annulée, C=Clôturée)
  Bloque              tinyint unsigned default 0,           -- Commande bloquée (oui/non)
  Soldee              tinyint unsigned default 0,           -- Commande soldée (1=oui,0=non)
  Facturee            char(1) default 'N',                  -- Statut de facturation (N=Non facturée, P=Partiellement facturée, T=Totalement facturée)
  Statut_Paiement     char(1) default 'N',                  -- Statut de paiement de la commande (N=Non payé, P=Partiellement payé, T=Totalement payé)
  Date_Validation     bigint unsigned default 0,            -- Date de validation de la commande
  Date_Annulation     bigint unsigned default 0,            -- Date d'annulation de la commande
  Intitule            varchar(20) default '',               -- Intitulé de commande
  Denomination_Liv    varchar(50) default '',               -- Nom pour la livraison
  Adresse_1_Liv       varchar(80) default '',               -- Ligne d'adresse 1 de livraison
  Adresse_2_Liv       varchar(50) default '',               -- Ligne d'adresse 2 de livraison
  Adresse_3_Liv       varchar(50) default '',               -- Ligne d'adresse 3 de livraison
  Code_Postal_Liv     varchar(10) default '',               -- Code postal de l'adresse de livraison
  Ville_Liv           varchar(50) default '',               -- Ville de l'adresse de livraison
  Code_Pays_Liv       char(2) default 'FR',                 -- Code pays de livraison
  Denomination        varchar(50) default '',               -- Raison sociale de commande
  Adresse_1           varchar(80) default '',               -- Ligne d'adresse 1 de commande
  Adresse_2           varchar(50) default '',               -- Ligne d'adresse 2 de commande
  Adresse_3           varchar(50) default '',               -- Ligne d'adresse 3 de commande
  Code_Postal         varchar(10) default '',               -- Code postal de commande
  Ville               varchar(50) default '',               -- Ville de commande
  Code_Pays           char(2) default 'FR',                 -- Code pays de commande
  Mentions            text,                                 -- Mentions
  Civ_Inter           tinyint unsigned default 0,
  Nom_Inter           varchar(30) default '',               -- Nom et prénom du client
  Prenom_Inter        varchar(30) default '',
  Tel_Inter           varchar(20) default '',
  Fax_Inter           varchar(20) default '',
  Email_Inter         varchar(64) default '',
  Vers_Calc           tinyint unsigned default 2,           -- Version de calcul de document
  Secteur_Activite    int unsigned default null,            -- Secteur d'activité
  primary key (Commande_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  index idx_code_tva_port (Code_TVA_Port),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_secteur_activite (Secteur_Activite),
  constraint cfk_commande_fournisseur_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_commande_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade,
  constraint cfk_commande_fournisseur_code_tva_port foreign key (Code_TVA_Port) references TAUX_TVA (Code_TVA),
  constraint cfk_commande_fournisseur_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;


create table LIGNE_COMMANDE_FOURNISSEUR (
  Ligne_Id            int unsigned auto_increment,           -- Identifiant unique de la ligne
  Commande_Id         int unsigned not null,                 -- Numéro de commande
  Rank                int unsigned not null,                 -- Numéro d'ordre dans le commande
  Reference           varchar(40) default '',                -- Code article
  Ref_Fournisseur     varchar(40) default '',                -- Référence article chez le fournisseur
  Type_Ligne          char(1) default 'I',                   -- Type de la ligne (S=Stock,I=Indépendante)
  Designation         varchar(100) default '',               -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,      -- Quantité
  Prix                decimal(14,4) unsigned default 0,      -- Prix de l'article
  Ristourne           decimal(5,2) unsigned default 0,       -- Pourcentage de ristourne
  Code_TVA            int unsigned default 1,                -- Code TVA
  Taux_TVA            decimal(4,2) unsigned default 0,       -- Taux de TVA
  Commentaire         text,                                  -- Commentaire bas associé à la ligne
  Commentaire_Avant   text,                                  -- Commentaire haut associé à la ligne
  Unite               char(3) default 'U',                   -- unité de vente
  Nb_Pieces           int unsigned default 0,                -- nombre de pièces par quantité
  Pack                int unsigned default 1,                -- pack chez le fournisseur
  Montant_Ligne       decimal(14,2) unsigned default 0,      -- Montant de la ligne
  Statut              char(1) default 'V',                   -- Statut de la ligne (V=Validée, A=Annulée)
  Soldee              tinyint unsigned default 0,            -- Ligne soldée (oui/non)
  primary key (Ligne_Id),
  index idx_code_tva (Code_TVA),
  index idx_commande_id (Commande_Id),
  constraint cfk_ligne_commande_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_ligne_commande_commande_id foreign key (Commande_Id) references COMMANDE_FOURNISSEUR (Commande_Id)
) engine=InnoDB;


create table HISTORIQUE_COMMANDE_FOURNISSEUR (
  Hist_Id             int not null auto_increment,           -- Identifiant de l'historique
  Commande_Id         int unsigned not null,                 -- Identifiant commande fournisseur
  Date                bigint unsigned default 0,             -- Date de changement
  Util_M              int not null,                          -- Utilisateur ayant effectué le changement
  Ref_Ligne           int unsigned default null,             -- Identifiant de la ligne de commande modifiée
  Libelle             text,                                  -- Libellé du changement
  primary key (Hist_Id),
  index idx_commande_id (Commande_Id),
  index idx_ref_ligne (Ref_Ligne),
  constraint cfk_historique_commande_fournisseur_commande_id foreign key (Commande_Id) references COMMANDE_FOURNISSEUR (Commande_Id),
  constraint cfk_historique_commande_fournisseur_ref_ligne foreign key (Ref_Ligne) references LIGNE_COMMANDE_FOURNISSEUR (Ligne_Id)
) engine=InnoDB;


create table PREP_BON_RECEPTION (
  Prep_Id           int unsigned not null auto_increment,   -- identifiant de la préparation du BR
  Fournisseur_Id    char(10) not null,                      -- identifiant du fournisseur
  Num_BL            varchar(15) default '',                 -- numéro du bl a généré
  Date_C            bigint unsigned default 0,              -- date de création de la préparation de BR
  Date_Validation   bigint unsigned default 0,              -- date de validation de la préparation de BR
  Util_V            int not null,                           -- utilisateur qui a validé la préparation de BR
  Etat              char(1) default 'N',                    -- état de validation
  primary key (Prep_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  constraint cfk_prep_bon_reception_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade
) engine=InnoDB;


create table ARTICLE_PREP_BON_RECEPTION (
  Article_Id       varchar(40) not null,                  -- identifiant article à commander
  Commande_Id      int unsigned not null,                 -- identifiant commande
  Prep_Id          int unsigned not null,                 -- identifiant de la préparation de commande
  Qte              decimal(10,3) default 0,               -- quantité recu
  Etat             tinyint(1) default 0,                  -- modifié? 0:non 1:oui
  primary key (Article_Id, Commande_Id, Prep_Id),
  constraint cfk_article_prep_bon_reception_article_id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id),
  constraint cfk_article_prep_bon_reception_commande_id foreign key (Commande_Id) references COMMANDE_FOURNISSEUR (Commande_Id),
  constraint cfk_article_prep_bon_reception_prep_id foreign key (Prep_Id) references PREP_BON_RECEPTION (Prep_Id)
) engine=InnoDB;


create table BON_RECEPTION (
  BR_Id               int unsigned not null auto_increment,  -- Identifiant du bon de réception
  Commande_Id         int unsigned not null,                 -- Identifiant commande fournisseur
  Date_BR             bigint unsigned default 0,             -- Date du bon de réception
  Commentaires_Fin    text,                                  -- Commentaires de fin de commande
  Commentaires_Int    text,                                  -- Commentaires internes non imprimables
  Commentaires_Hid    text,                                  -- Commentaires internes cachés
  Date_C              bigint unsigned default 0,             -- Date de création du BR
  Date_M              bigint unsigned default 0,             -- Date de mise à jour du BR
  Util_C              int not null,                          -- Utilisateur créateur du BR
  Util_M              int not null,                          -- Utilisateur ayant fait la dernière modification du BR
  Numero              int unsigned default 0,                -- Numéro du BR dans le mois
  Num_Entier          char(10) default '',                   -- Numéro unique du BR
  Num_BL              varchar(20) default '',                -- Numéro du BL fournisseur
  Etat                char(1) default 'N',                   -- Etat du bon de réception (V=validé,N=non validé)
  Facture             char(1) default 'N',                   -- Statut de facturation (N=Non facturé, P=Partiellement facturé, T=Totalement facturé)
  Prep_Id             int unsigned default null,             -- Identifiant de la réception
  Mentions            text,                                  -- Mentions
  Date_DEB            bigint unsigned default 0,             -- Date de l'export DEB
  Total_HT            decimal(14,2) default 0,               -- Total HT
  Total_TTC           decimal(14,2) default 0,               -- Total TTC
  primary key (BR_Id),
  index idx_prep_id (Prep_Id),
  index idx_commande_id (Commande_Id),
  constraint cfk_bon_reception_commande_id foreign key (Commande_Id) references COMMANDE_FOURNISSEUR (Commande_Id),
  constraint cfk_bon_reception_prep_id foreign key (Prep_Id) references PREP_BON_RECEPTION (Prep_Id)
) engine=InnoDB;


create table LIGNE_BON_RECEPTION (
  Ligne_Id            int unsigned not null auto_increment,  -- Identifiant de la ligne du bon de réception
  BR_Id               int unsigned not null,                 -- Identifiant du bon de réception
  Ref_Ligne           int unsigned not null,                 -- Ligne correspondante de la commande
  Rank                int unsigned,                          -- Rang de la ligne sur le BR
  Quantite            decimal(10,3) unsigned default 1,      -- Quantité réceptionnée
  Num_Lot             varchar(15) default '',                -- numéro de lot
  Nb_Pieces           int unsigned default 0,                -- nombre de pièces par quantité
  Date_Peremption     bigint unsigned default 0,             -- date de péremption
  Montant_Ligne       decimal(14,2) unsigned default 0,      -- Montant de la ligne
  Statut              char(1) default 'V',                   -- Statut de la ligne (V=Validé, A=Annulé)
  primary key (Ligne_Id),
  index idx_ref_ligne (Ref_Ligne),
  index idx_br_id (BR_Id),
  constraint cfk_ligne_bon_reception_br_id foreign key (BR_Id) references BON_RECEPTION (BR_Id),
  constraint cfk_ligne_bon_reception_ref_ligne foreign key (Ref_Ligne) references LIGNE_COMMANDE_FOURNISSEUR (Ligne_Id)
) engine=InnoDB;


create table BON_RETOUR_FOURNISSEUR (
  Bon_Id              int not null auto_increment,                 -- Identifiant du bon de retour
  Fournisseur_Id      char(10) default null,                       -- Identifiant du fournisseur
  Numero              char(10) not null default '',                -- Numéro du bon de retour (RFyymm0000)
  Date_Bon            bigint unsigned default 0,                   -- Date du bon de retour
  Date_Retour         bigint unsigned default 0,                   -- Date de retour de la marchandise
  Date_C              bigint unsigned not null,                    -- Date de création
  Date_M              bigint unsigned not null,                    -- Date de dernière mise à jour
  Util_C              int not null,                                -- Utilisateur de création
  Util_M              int not null,                                -- Utilisateur ayant fait la dernière modification du bon de retour
  Commentaires_Fin    text,                                        -- Commentaires de fin de bon de retour
  Commentaires_Int    text,                                        -- Commentaires internes
  Commentaires_Hid    text,                                        -- Commentaires cachés
  Mentions            text,                                        -- Mentions
  Etat                char(1) not null default 'N',                -- Etat du bon de retour (V=Validé,N=Non validé,A=Annulé,E=En attente)
  Type_Retour         char(1) not null default 'E',                -- Type de retour (E=Echange de marchandises, R=Reprise de marchandises)
  Denomination        varchar(50) not null,                        -- Dénomination
  Adresse_1           varchar(80) not null default '',             -- Ligne d'adresse 1
  Adresse_2           varchar(50) not null default '',             -- Ligne d'adresse 2
  Adresse_3           varchar(50) not null default '',             -- Ligne d'adresse 3
  Code_Postal         varchar(10) not null default '',             -- Code postal
  Ville               varchar(50) not null default '',             -- Ville
  Code_Pays           char(2) not null default 'FR',               -- Code pays
  Civ_Inter           tinyint unsigned not null default 0,         -- Civilité du contact
  Nom_Inter           varchar(30) not null default '',             -- Nom du contact
  Prenom_Inter        varchar(30) not null default '',             -- Prénom du contact
  Tel_Inter           varchar(20) not null default '',             -- Téléphone du contact
  Fax_Inter           varchar(20) not null default '',             -- Fax du contact
  Email_Inter         varchar(64) not null default '',             -- Email du contact
  Total_HT            decimal(14,2) unsigned not null default 0,   -- Total HT
  Total_TTC           decimal(14,2) unsigned not null default 0,   -- Total TTC
  primary key (Bon_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  constraint cfk_bon_retour_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade
) engine=InnoDB;


create table LIGNE_BON_RETOUR_FOURNISSEUR (
  Ligne_Id            int not null auto_increment,                 -- Identifiant de la ligne de bon de retour
  Bon_Id              int not null,                                -- Identifiant du bon de retour
  Ligne_BR            int unsigned not null,                       -- Ligne correspondante du bon de réception
  Rank                int unsigned not null,                       -- Rang de l'article sur le bon de retour
  Quantite            decimal(10,3) unsigned not null,             -- Quantité
  Reliquat            decimal(10,3) unsigned not null default 0,   -- Reliquat à réceptionner
  Nb_Pieces           int unsigned default 0,                      -- Nombre de pièces par quantité
  Montant_Ligne       decimal(14,2) unsigned not null default 0,   -- Montant de la ligne
  primary key (Ligne_Id),
  index idx_ligne_br (Ligne_BR),
  index idx_bon_id (Bon_Id),
  constraint cfk_ligne_bon_retour_fournisseur_bon_id foreign key (Bon_Id) references BON_RETOUR_FOURNISSEUR (Bon_Id),
  constraint cfk_ligne_bon_retour_fournisseur_ligne_br foreign key (Ligne_BR) references LIGNE_BON_RECEPTION (Ligne_Id)
) engine=InnoDB;


create table PREP_COMMANDE (
  Prep_Id           int unsigned not null auto_increment,   -- identifiant de la préparation de commande
  Date_C            bigint unsigned default 0,              -- date de création de la préparation de commande
  Date_Validation   bigint unsigned default 0,              -- date de validation de la préparation de commande
  Util_V            int not null,                           -- utilisateur qui a validé la préparation de commande
  Etat              char(1) default 'N',                    -- état de validation
  primary key (Prep_Id)
) engine=InnoDB;


create table ARTICLE_PREP_COMMANDE (
  Ligne_Prep_Id    int unsigned not null auto_increment,  -- identifiant de la ligne de préparation
  Article_Id       varchar(40) not null,                  -- identifiant article à commander
  Prep_Id          int unsigned not null,                 -- identifiant de la préparation de commande
  Qte_Theorique    decimal(10,3) default 0,               -- quantité théorique à commander
  primary key (Ligne_Prep_Id),
  unique(Article_Id, Prep_Id),
  constraint cfk_article_prep_commande_article_id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id),
  constraint cfk_article_prep_commande_prep_id foreign key (Prep_Id) references PREP_COMMANDE (Prep_Id)
) engine=InnoDB;


create table LIGNE_ARTICLE_PREP (
  Ligne_Prep_Id     int unsigned not null,                 -- identifiant de l'article en préparation
  Fournisseur_Id    char(10) not null,                     -- identifiant du fournisseur
  Quantite          decimal(10,3) default 0,               -- quantité à commander chez ce fournisseur
  primary key (Ligne_Prep_Id, Fournisseur_Id),
  constraint cfk_ligne_article_prep_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade,
  constraint cfk_ligne_article_prep_ligne_prep_id foreign key (Ligne_Prep_Id) references ARTICLE_PREP_COMMANDE (Ligne_Prep_Id)
) engine=InnoDB;


-- ------------------------- E-COMMERCE -------------------------------------------------------


create table SITE_WEB (
  Site_Id              int not null auto_increment,           -- Identifiant du site
  Code                 varchar(5) not null,                   -- Code du site
  Nom_Site             varchar(40) not null,                  -- Nom du site
  URL_Service          varchar(100) not null default '',      -- adresse du serveur de web service
  URL_Site             varchar(100) not null,                 -- url du site
  URL_Logo             varchar(100) default '',               -- url du logo du site
  Actif                tinyint unsigned default 1,            -- Site actif (oui/non)
  Banque_Remise_CB     int unsigned default null,             -- Banque de remise des paiements CB du site
  Logo_Adr             tinyint unsigned not null default 0,   -- Le logo contient les informations société (oui/non)
  Email_VCC            int unsigned default null,             -- Email à envoyer à la validation de commande
  Email_ACC            int unsigned default null,             -- Email à envoyer à l'annulation de commande
  Email_ECC            int unsigned default null,             -- Email à envoyer à l'expédition de commande
  Email_PCC            int unsigned default null,             -- Email à envoyer à la préparation de commande
  Email_VFC            int unsigned default null,             -- Email à envoyer à la validation de facture
  Email_VAC            int unsigned default null,             -- Email à envoyer à la validation d'avoir
  primary key (Site_Id),
  unique (Code),
  index idx_banque_remise_cb (Banque_Remise_CB),
  index idx_email_vcc (Email_VCC),
  index idx_email_acc (Email_ACC),
  index idx_email_ecc (Email_ECC),
  index idx_email_pcc (Email_PCC),
  index idx_email_vfc (Email_VFC),
  index idx_email_vac (Email_VAC),
  constraint cfk_site_web_banque_remise_cb foreign key (Banque_Remise_CB) references BANQUE (Banque_Id),
  constraint cfk_site_web_email_vcc foreign key (Email_VCC) references EMAIL (Email_Id),
  constraint cfk_site_web_email_acc foreign key (Email_ACC) references EMAIL (Email_Id),
  constraint cfk_site_web_email_ecc foreign key (Email_ECC) references EMAIL (Email_Id),
  constraint cfk_site_web_email_pcc foreign key (Email_PCC) references EMAIL (Email_Id),
  constraint cfk_site_web_email_vfc foreign key (Email_VFC) references EMAIL (Email_Id),
  constraint cfk_site_web_email_vac foreign key (Email_VAC) references EMAIL (Email_Id)
) engine=InnoDB;


create table ARTICLE_SITE_WEB (
  Article_Id       int not null,                -- Identifiant de l'article
  Site_Web_Id      int not null,                -- Identifiant du site web
  Publication      tinyint unsigned default 1,  -- Publication de l'article (oui/non)
  primary key (Article_Id, Site_Web_Id),
  constraint cfk_article_site_web_article_id foreign key (Article_Id) references FICHE_ARTICLE (Fiche_Article_Id),
  constraint cfk_article_site_web_site_id foreign key (Site_Web_Id) references SITE_WEB (Site_Id)
) engine=InnoDB;


create table FICHE_ARTICLE_WEB (
  Article_Web_Id   int unsigned auto_increment,    -- Réf de l'article web dans OpenSi
  Article_Id       char(40) not null,              -- Ref de l'article dans FICHE_ARTICLE
  Article_Id_Site  varchar(40),                    -- Ref de l'article sur le site
  Site_Id          int not null,                   -- Id du site su lequel est l'article
  Stock_Web        int default 0,                  -- stock en ligne(mis a jour lors de la maj des stocks)
  Calcul_Stock     char(1),                        -- Mode de calcul du stock (T pour tampon, P pour %)
  Valeur_Stock     decimal(12,2),                  -- Valeur a utiliser pour le calcul du stock
  Stock_Modifie    tinyint default 0,              -- 1 si le mode de calcul n'a pas été modifié, 1 si le mode de calc a été modif
  Prix_Web         decimal(12,3) default 0,        -- prix actuel en ligne (mis a jour lors de la maj des prix)
  Calcul_Prix      char(2),                        -- Mode de calcul du prix (M pour marge, MP pour marge en %, PA pour coef/PA, PV pour coef/PV, F pour prix fixe)
  Valeur_Prix      decimal(12,4),                  -- Valeur a utiliser pour le calcul du prix
  Prix_Modifie     tinyint default 0,              -- 0 si le mode de calcul n'a pas été modifié, 1 si le mode de calc a été modif
  Statut_Web       char(1) default 'n',            -- statut: online ou offline 'n' pour on, 'f' pour off
  Etat_Existance   tinyint default 0,              -- -1 pour "a supprimer", +1 pour "a ajouter" 0 pour "non changé"
  Date_Prix_Ref    bigint default 0,               -- date de la FICHE_ARTICLE de la fiche utilisée pour le calcul des prix
  Date_Stock_Ref   bigint default 0,               -- date de la MVT_STOCK utilisée pour le calcul des stocks
  Date_Info_Ref    bigint default 0,               -- date de la FICHE_ARTICLE de la fiche utilisée pour la maj des infos
  Ancien_Stock     int default 0,                  -- valeur du stock de la derniere mise a jour
  primary key (Article_Web_Id),
  unique(Site_Id, Article_Id, Article_Id_Site),
  index idx_article_id (Article_Id),
  index idx_site_id (Site_Id),
  constraint cfk_fiche_article_web_article_id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id),
  constraint cfk_fiche_article_web_site_id foreign key (Site_Id) references SITE_WEB (Site_Id)
) engine=InnoDB;


create table FICHE_ARTICLE_TEMP (
  Site_Id         int not null,                      -- Id du site su lequel est l'article
  Article_Id      char(40) not null,                 -- Code Article
  Designation     varchar(100) default '',           -- Désignation article
  Description     text,                              -- Description de l'article
  Marque_Id       int unsigned default null,         -- Marque
  Famille_1       int unsigned default null,         -- Famille article
  Famille_2       int unsigned default null,         -- Sous-famille
  Prix_Vente      decimal(14,4) unsigned default 0,  -- Tarif 1
  Prix_Achat      decimal(12,4) default 0,           -- Prix d'achat
  Stock           int default 0,                     -- Quantité en stock
  Poids           decimal(10,3) default 0,           -- Poids
  En_ligne        char(1) default 'n',               -- etat de l'article sur le site
  Nom_Image       varchar(40),                       -- nom de l'image uploadé
  Attribut_1      int default null,                  -- Attribut 1
  Attribut_2      int default null,                  -- Attribut 2
  Attribut_3      int default null,                  -- Attribut 3
  primary key(Site_Id, Article_Id)
) engine=InnoDB;


create table MAJ_AUTO (
  Maj_Id          int unsigned not null auto_increment,  -- identifiant de la maj
  Site_Id         int not null,                          -- id du site
  Type_Maj        varchar(6) not null,                   -- {COM, STOCK, PRIX, INFO, STAT}
  Type_Periode    varchar(7),                            -- {MINUTE,HEURE,JOUR,SEMAINE}
  Valeur_Periode  varchar(26),                           -- 1-59 pour minute,1-23 pour heure, lun,mar,sam
  Heure_Depart    int default 0,                         -- entre 0h et 23h
  Nom_Service     varchar(20),                           -- utilisé par quartz (Job name)
  Groupe_Service  varchar(20),                           -- utilisé par quartz
  Derniere_Maj    bigint default 0,                      -- date de dernière maj auto
  primary key (Maj_Id)
) engine=InnoDB;


-- ----- TABLES AFFAIRES CLIENTS -------------------------------------------------------------------------------------------------------


create table CLIENT_WEB (
  Client_Web_Id     int unsigned not null auto_increment,  -- Identifiant du client web
  Client_Site_Id    varchar(60) not null,                  -- Id du client sur le site (login)
  Client_Id         char(10) default null,                 -- Id du client dans OpenSi
  Civ               tinyint unsigned default 0,            -- Civ du client
  Nom               varchar(30),                           -- Nom du client
  Prenom            varchar(30),                           -- Prénom du client
  Adresse_1         varchar(80) default '',                -- Ligne d'adresse 1
  Adresse_2         varchar(50) default '',                -- Ligne d'adresse 2
  Adresse_3         varchar(50) default '',                -- Ligne d'adresse 3
  Code_Postal       varchar(10) default '',                -- Code postal
  Ville             varchar(50),                           -- Ville
  Code_Pays         char(2) default 'FR',                  -- Code pays
  Password          varchar(20),                           -- mot de passe sur le site
  Tel               varchar(32),                           -- telephone du client
  Fax               varchar(32),                           -- fax
  Email             varchar(64),                           -- e-mail
  Site_Id           int not null,                          -- id du site
  Entreprise        varchar(50),                           -- entreprise du client
  Date_M            bigint unsigned default 0,             -- Date de dernière mise a jour
  Remise_Web        decimal(5,2) default 0,                -- Remise sur le site
  Actif             tinyint unsigned not null default 1,   -- Actif sur le site
  UploadStatus      tinyint unsigned not null default 0,   -- 0 : a mettre a jour sur le site
  primary key (Client_Web_Id),
  unique(Client_Site_Id, Site_Id),
  index idx_client_id (Client_Id),
  constraint cfk_client_web_site_id foreign key (Site_Id) references SITE_WEB (Site_Id),
  constraint cfk_client_web_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade
) engine=InnoDB;


create table AFFAIRE (
  Affaire_Id           int unsigned not null auto_increment, -- Identifiant de l'affaire
  Numero               int unsigned default 0,               -- Numéro d'affaire dans la période
  Num_Entier           char(10) default '',                  -- Numéro intégral de l'affaire
  Client_Id            char(10) default null,                -- Code client
  Denomination         varchar(50) default '',               -- Dénomination
  Telephone            varchar(20) default '',               -- Téléphone
  Fax                  varchar(20) default '',               -- Fax
  Email                varchar(64) default '',               -- Email
  Intitule             varchar(20) default '',               -- Intitulé de l'affaire
  Util_R               int default null,                     -- Utilisateur responsable
  Commentaires         text,                                 -- Commentaires sur l'affaire
  Util_C               int not null,                         -- Utilisateur de création
  Util_M               int not null,                         -- Utilisateur de dernière modification
  Date_C               bigint unsigned default 0,            -- Date de création
  Date_M               bigint unsigned default 0,            -- Date de dernière modification
  Etat                 char(1) default 'N',                  -- Etat de l'affaire (N=Non validée,T=En cours,A=Annulée,C=Clôturée,Z=Non aboutie)
  Date_Cloture         bigint unsigned default 0,            -- Date de clôture
  Type_Fact            char(2) default 'CC',                 -- Type de facturation (GA=Groupement d'Affaires, GC=Groupement de Commandes, CC=Commande, BL=Bon de Livraison)
  Frais_Port_Prem      tinyint unsigned default 0,           -- Frais de port sur 1ère facture
  Mode_Envoi_Facture   char(1) default 'C',                  -- Mode d'envoi de la facture (C=Courrier,F=Fax,M=Mail)
  Periode_Facturation  char(1) default 'I',                  -- Période de facturation (I=Immédiate,M=Fin de mois,D=à partir de la Date)
  Date_Facturation     bigint unsigned default 0,            -- Date à partir de laquelle on peut facturer si période facturation = D
  Mode_Facturation     char(1) default 'E',                  -- Mode de facturation (E=A l'Expédition, C=A la Commande)
  Sans_Livraison       tinyint unsigned default 0,           -- Sans livraison (oui/non) (pas de BL)
  Activation_CP        tinyint unsigned default 1,           -- Activation automatique des codes produits à la livraison (1=oui,0=non)
  Fact_Sep_FP          tinyint unsigned default 0,           -- Facturation séparée des frais de port (1=oui,0=non)
  primary key (Affaire_Id),
  index idx_client_id (Client_Id),
  constraint cfk_affaire_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade
) engine=InnoDB;



create table COMMANDE_CLIENT (
  Commande_Id          int unsigned not null auto_increment, -- Identifiant de commande client
  Affaire_Id           int unsigned default null,            -- Identifiant d'affaire
  Client_Id            char(10) default null,                -- Identifiant client
  Util_R               int default null,                     -- Responsable de la commande
  Date_C               bigint unsigned default 0,            -- Date de création
  Date_M               bigint unsigned default 0,            -- Date de mise à jour
  Util_C               int not null,                         -- Utilisateur de création
  Util_M               int not null,                         -- Utilisateur de mise à jour
  Etat                 char(1) default 'N',                  -- Etat de la commande  (N=Non validée,T=En cours,A=Annulée,C=Clôturée,Z=Non aboutie)
  Statut_Logistique    char(1) default 'N',                  -- Statut logistique de la commande (N=Non validée,T=A traiter,E=Expédiée)
  Date_Commande        bigint unsigned default 0,            -- Date de la commande
  Date_Validation      bigint unsigned default 0,            -- Date de validation de la commande
  Date_Annulation      bigint unsigned default 0,            -- Date d'annulation de la commande
  Ref_Commande         varchar(20) default '',               -- Référence commande (n° donné par le client ou n° devis)
  Numero               varchar(11) default '',               -- Numéro de commande interne
  Edition_TTC          tinyint unsigned default 0,           -- Edition en TTC (1=oui,0=non)
  Regime_TVA           char(1) default 'G',                  -- Régime TVA (G=Général, T=forcer l'application de la TVA, E=Exonération de TVA)
  Assujetti_TVA        tinyint unsigned default 0,           -- Assujetti à la TVA (1=oui,0=non)
  Num_TVA_Intra        varchar(14) default '',               -- Numéro de TVA intracommunautaire
  Bloque               tinyint unsigned default 0,           -- Commande bloquée (1=oui,0=non)
  Code_Tarif           tinyint unsigned default 1,           -- Code tarif utilisé (1-5)
  Delai                bigint unsigned default 0,            -- Délai de livraison
  Soldee               tinyint unsigned default 0,           -- Commande soldée (1=oui,0=non)
  Facturee             tinyint unsigned default 0,           -- Commande facturée
  Mode_Expedition      int unsigned default null,            -- Mode d'expédition des colis
  Secteur_Activite     int unsigned default null,            -- Secteur d'activité
  Taux_Indicatif       decimal(7,4) unsigned default 0,      -- Taux indicatif de conversion (MID)
  Statut_Paiement      tinyint unsigned default 0,           -- Statut du paiement (0=non payé, 1=pour payé, 2=payé partiellement)
  Mode_Reg_Id          int unsigned default null,            -- Mode de règlement
  Commentaires_Fin     text,                                 -- Commentaires de fin de commande
  Commentaires_Int     text,                                 -- Commentaires internes
  Commentaires_Hid     text,                                 -- Commentaires cachés
  Mentions             text,                                 -- Mentions
  Remise               decimal(9,6) unsigned default 0,      -- Pourcentage de remise
  Montant_Remise       decimal(9,2) unsigned default 0,      -- Montant de remise uniquement si remise en montant sinon 0
  PRemise_FP           decimal(9,6) unsigned default 0,      -- Pourcentage de remise sur frais de port
  MRemise_FP           decimal(9,2) unsigned default 0,      -- Montant de remise sur frais de port uniquement si remise en montant sinon 0
  Escompte             decimal(5,2) unsigned default 0,      -- Pourcentage d'escompte
  Frais_Port           decimal(10,2) unsigned default 0,     -- Montant des frais de port
  Taux_TVA_Port        decimal(4,2) unsigned default 0,      -- Taux de TVA des frais de port
  Code_TVA_Port        int unsigned not null,                -- Code de TVA des frais de port
  Old_Acompte          decimal(14,2) unsigned default 0,     -- OBSOLETE - Montant d'acompte
  Total_HT             decimal(14,2) unsigned default 0,     -- Total HT de la commande
  Total_TTC            decimal(14,2) unsigned default 0,     -- Total TTC de la commande
  Marge_HT             decimal(14,2) default 0,              -- Montant de marge HT
  Vers_Calc            tinyint unsigned default 2,           -- Version de calcul de document
  Denomination         varchar(50) default '',               -- Dénomination client
  Adresse_1            varchar(80) default '',               -- Ligne d'adresse 1
  Adresse_2            varchar(50) default '',               -- Ligne d'adresse 2
  Adresse_3            varchar(50) default '',               -- Ligne d'adresse 3
  Code_Postal          varchar(10) default '',               -- Code postal
  Ville                varchar(50) default '',               -- Ville
  Code_Pays            char(2) default 'FR',                 -- Code pays
  Civ_Inter            tinyint unsigned default 0,           -- Civilité de l'interlocuteur
  Nom_Inter            varchar(30) default '',               -- Nom de l'interlocuteur
  Prenom_Inter         varchar(30) default '',               -- Prénom de l'interlocuteur
  Tel_Inter            varchar(20) default '',               -- Téléphone de l'interlocuteur
  Fax_Inter            varchar(20) default '',               -- Fax de l'interlocuteur
  Email_Inter          varchar(64) default '',               -- Email de l'interlocuteur
  Denomination_Liv     varchar(50) default '',               -- Dénomination de livraison
  Adresse_1_Liv        varchar(80) default '',               -- Ligne d'adresse 1 de livraison
  Adresse_2_Liv        varchar(50) default '',               -- Ligne d'adresse 2 de livraison
  Adresse_3_Liv        varchar(50) default '',               -- Ligne d'adresse 3 de livraison
  Code_Postal_Liv      varchar(10) default '',               -- Code postal de livraison
  Ville_Liv            varchar(50) default '',               -- Ville de livraison
  Code_Pays_Liv        char(2) default 'FR',                 -- Code pays de livraison
  Civ_Inter_Liv        tinyint unsigned default 0,           -- Civilité de l'interlocuteur de livraison
  Nom_Inter_Liv        varchar(30) default '',               -- Nom de l'interlocuteur de livraison
  Prenom_Inter_Liv     varchar(30) default '',               -- Prénom de l'interlocuteur de livraison
  Tel_Inter_Liv        varchar(20) default '',               -- Téléphone de l'interlocuteur de livraison
  Fax_Inter_Liv        varchar(20) default '',               -- Fax de l'interlocuteur de livraison
  Email_Inter_Liv      varchar(64) default '',               -- Email de l'interlocuteur de livraison
  Denomination_Envoi   varchar(50) default '',               -- Dénomination d'envoi facture
  Adresse_1_Envoi      varchar(80) default '',               -- Ligne d'adresse 1 d'envoi facture
  Adresse_2_Envoi      varchar(50) default '',               -- Ligne d'adresse 2 d'envoi facture
  Adresse_3_Envoi      varchar(50) default '',               -- Ligne d'adresse 3 d'envoi facture
  Code_Postal_Envoi    varchar(10) default '',               -- Code postal d'envoi facture
  Ville_Envoi          varchar(50) default '',               -- Ville d'envoi facture
  Code_Pays_Envoi      char(2) default 'FR',                 -- Code pays d'envoi facture
  Civ_Inter_Envoi      tinyint unsigned default 0,           -- Civilité de l'interlocuteur d'envoi
  Nom_Inter_Envoi      varchar(30) default '',               -- Nom de l'interlocuteur d'envoi
  Prenom_Inter_Envoi   varchar(30) default '',               -- Prénom de l'interlocuteur d'envoi
  Tel_Inter_Envoi      varchar(20) default '',               -- Téléphone de l'interlocuteur d'envoi
  Fax_Inter_Envoi      varchar(20) default '',               -- Fax de l'interlocuteur d'envoi
  Email_Inter_Envoi    varchar(64) default '',               -- Email de l'interlocuteur d'envoi
  primary key (Commande_Id),
  index idx_affaire_id (Affaire_Id),
  index idx_client_id (Client_Id),
  index idx_mode_expedition (Mode_Expedition),
  index idx_secteur_activite (Secteur_Activite),
  index idx_code_tva_port (Code_TVA_Port),
  index idx_mode_reg_id (Mode_Reg_Id),
  constraint cfk_commande_client_affaire_id foreign key (Affaire_Id) references AFFAIRE (Affaire_Id),
  constraint cfk_commande_client_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_commande_client_mode_expedition foreign key (Mode_Expedition) references MODE_LIVRAISON (Mode_Liv_Id),
  constraint cfk_commande_client_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_commande_client_code_tva_port foreign key (Code_TVA_Port) references TAUX_TVA (Code_TVA),
  constraint cfk_commande_client_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;



create table COMMANDE_CLIENT_WEB (
  Commande_Id          int unsigned not null,                -- Identifiant de la commande client
  Site_Web_Id          int not null,                         -- Identifiant du site web
  Ref_Com_Web          varchar(20) default '',               -- Référence de la commande sur le site web
  Num_Transaction      varchar(20) default '',               -- Numéro de transaction CB
  Origine              varchar(30) default '',               -- Origine de la commande web
  Client_Web_Id        int unsigned not null,                -- Identifiant du client web
  Statut_Modifie       tinyint unsigned default 0,           -- Statut modifié depuis la dernière maj (1=oui,0=non) (webservice)
  Mail_Manager         varchar(64) default '',               -- Email du manager des agences
  Code_Porte           varchar(30) default '',               -- Code porte pour la livraison
  Infos_Commande       varchar(100) default '',              -- Informations diverses provenant du site web
  Envoi_Multiple       tinyint unsigned default 0,           -- Envoi multiple de la commande (1=oui,0=non)
  primary key (Commande_Id),
  index idx_site_web_id (Site_Web_Id),
  index idx_client_web_id (Client_Web_Id),
  constraint cfk_commande_client_web_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id),
  constraint cfk_commande_client_web_site_web_id foreign key (Site_Web_Id) references SITE_WEB (Site_Id),
  constraint cfk_commande_client_web_client_web_id foreign key (Client_Web_Id) references CLIENT_WEB (Client_Web_Id)
) engine=InnoDB;



create table LIGNE_COMMANDE_CLIENT (
  Ligne_Id            int unsigned not null auto_increment,  -- Identifiant de la ligne de commande
  Commande_Id         int unsigned not null,                 -- Identifiant de la commande
  Rank                int unsigned not null,                 -- Numéro d'ordre dans la commande
  Type_Ligne          char(1) default 'I',                   -- Type de la ligne (S=Stock, I=Indépendante)
  Reference           varchar(40) default '',                -- Référence de l'article
  Designation         varchar(100) default '',               -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,      -- Quantité
  Prix_Unitaire       decimal(14,4) unsigned default 0,      -- Prix unitaire de l'article
  Ristourne           decimal(5,2) unsigned default 0,       -- Pourcentage de ristourne
  Taux_TVA            decimal(4,2) unsigned default 0,       -- Taux de TVA
  Code_TVA            int unsigned default 1,                -- Code TVA
  Commentaire_Avant   text,                                  -- Commentaire placé avant la ligne
  Commentaire_Apres   text,                                  -- Commentaire placé après la ligne
  Libelle             varchar(20) default '',                -- Libellé supplémentaire
  Code_Stats          varchar(10) default '',                -- Code de statistiques
  Unite               char(3) default 'U',                   -- Unité de vente
  Nb_Pieces           int unsigned default 0,                -- Nombre de pièces
  Num_Lot             varchar(15) default '',                -- Numéro de lot
  Date_Peremption     bigint unsigned default 0,             -- Date de péremption
  Commission          decimal(4,2) unsigned default 0,       -- Taux de commission
  Montant_Ligne       decimal(14,2) unsigned default 0,      -- Montant de la ligne
  Soldee              tinyint unsigned default 0,            -- Ligne soldée (entièrement livrée)
  Statut              char(1) default 'V',                   -- Statut de la ligne (V=Valide, A=Annulée)
  Prix_Achat          decimal(14,4) unsigned default 0,      -- Prix d'achat unitaire HT
  Marge_Ligne         decimal(14,2) default 0,               -- Montant de marge HT sur la ligne
  primary key (Ligne_Id),
  index idx_commande_id (Commande_Id),
  index idx_code_tva (Code_TVA),
  index idx_reference (Reference),
  constraint cfk_ligne_commande_client_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id),
  constraint cfk_ligne_commande_client_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA)
) engine=InnoDB;


create table COMMANDE_CLIENT_INITIALE (
  Commande_Id          int unsigned not null,                -- Identifiant de commande client
  Affaire_Id           int unsigned default null,            -- Identifiant d'affaire
  Client_Id            char(10) default null,                -- Identifiant client
  Util_R               int default null,                     -- Responsable de la commande
  Date_C               bigint unsigned default 0,            -- Date de création
  Date_M               bigint unsigned default 0,            -- Date de mise à jour
  Util_C               int not null,                         -- Utilisateur de création
  Util_M               int not null,                         -- Utilisateur de mise à jour
  Etat                 char(1) default 'N',                  -- Etat de la commande  (N=Non validée,T=En cours,A=Annulée,C=Clôturée,Z=Non aboutie)
  Statut_Logistique    char(1) default 'N',                  -- Statut logistique de la commande (N=Non validée,T=A traiter,E=Expédiée)
  Date_Commande        bigint unsigned default 0,            -- Date de la commande
  Date_Validation      bigint unsigned default 0,            -- Date de validation de la commande
  Date_Annulation      bigint unsigned default 0,            -- Date d'annulation de la commande
  Ref_Commande         varchar(20) default '',               -- Référence commande (n° donné par le client ou n° devis)
  Numero               varchar(11) default '',               -- Numéro de commande interne
  Edition_TTC          tinyint unsigned default 0,           -- Edition en TTC (1=oui,0=non)
  Regime_TVA           char(1) default 'G',                  -- Régime TVA (G=Général, T=forcer l'application de la TVA, E=Exonération de TVA)
  Assujetti_TVA        tinyint unsigned default 0,           -- Assujetti à la TVA (1=oui,0=non)
  Num_TVA_Intra        varchar(14) default '',               -- Numéro de TVA intracommunautaire
  Bloque               tinyint unsigned default 0,           -- Commande bloquée (1=oui,0=non)
  Code_Tarif           tinyint unsigned default 1,           -- Code tarif utilisé (1-5)
  Delai                bigint unsigned default 0,            -- Délai de livraison
  Soldee               tinyint unsigned default 0,           -- Commande soldée (1=oui,0=non)
  Facturee             tinyint unsigned default 0,           -- Commande facturée
  Mode_Expedition      int unsigned default null,            -- Mode d'expédition des colis
  Secteur_Activite     int unsigned default null,            -- Secteur d'activité
  Taux_Indicatif       decimal(7,4) unsigned default 0,      -- Taux indicatif de conversion (MID)
  Statut_Paiement      tinyint unsigned default 0,           -- Statut du paiement (0=non payé, 1=pour payé, 2=payé partiellement)
  Mode_Reg_Id          int unsigned default null,            -- Mode de règlement
  Commentaires_Fin     text,                                 -- Commentaires de fin de commande
  Commentaires_Int     text,                                 -- Commentaires internes
  Commentaires_Hid     text,                                 -- Commentaires cachés
  Mentions             text,                                 -- Mentions
  Remise               decimal(9,6) unsigned default 0,      -- Pourcentage de remise
  Montant_Remise       decimal(9,2) unsigned default 0,      -- Montant de remise uniquement si remise en montant sinon 0
  PRemise_FP           decimal(9,6) unsigned default 0,      -- Pourcentage de remise sur frais de port
  MRemise_FP           decimal(9,2) unsigned default 0,      -- Montant de remise sur frais de port uniquement si remise en montant sinon 0
  Escompte             decimal(5,2) unsigned default 0,      -- Pourcentage d'escompte
  Frais_Port           decimal(10,2) unsigned default 0,     -- Montant des frais de port
  Taux_TVA_Port        decimal(4,2) unsigned default 0,      -- Taux de TVA des frais de port
  Code_TVA_Port        int unsigned not null,                -- Code de TVA des frais de port
  Old_Acompte          decimal(14,2) unsigned default 0,     -- OBSOLETE - Montant d'acompte
  Total_HT             decimal(14,2) unsigned default 0,     -- Total HT de la commande
  Total_TTC            decimal(14,2) unsigned default 0,     -- Total TTC de la commande
  Marge_HT             decimal(14,2) default 0,              -- Montant de marge HT
  Vers_Calc            tinyint unsigned default 2,           -- Version de calcul de document
  Denomination         varchar(50) default '',               -- Dénomination client
  Adresse_1            varchar(80) default '',               -- Ligne d'adresse 1
  Adresse_2            varchar(50) default '',               -- Ligne d'adresse 2
  Adresse_3            varchar(50) default '',               -- Ligne d'adresse 3
  Code_Postal          varchar(10) default '',               -- Code postal
  Ville                varchar(50) default '',               -- Ville
  Code_Pays            char(2) default 'FR',                 -- Code pays
  Civ_Inter            tinyint unsigned default 0,           -- Civilité de l'interlocuteur
  Nom_Inter            varchar(30) default '',               -- Nom de l'interlocuteur
  Prenom_Inter         varchar(30) default '',               -- Prénom de l'interlocuteur
  Tel_Inter            varchar(20) default '',               -- Téléphone de l'interlocuteur
  Fax_Inter            varchar(20) default '',               -- Fax de l'interlocuteur
  Email_Inter          varchar(64) default '',               -- Email de l'interlocuteur
  Denomination_Liv     varchar(50) default '',               -- Dénomination de livraison
  Adresse_1_Liv        varchar(80) default '',               -- Ligne d'adresse 1 de livraison
  Adresse_2_Liv        varchar(50) default '',               -- Ligne d'adresse 2 de livraison
  Adresse_3_Liv        varchar(50) default '',               -- Ligne d'adresse 3 de livraison
  Code_Postal_Liv      varchar(10) default '',               -- Code postal de livraison
  Ville_Liv            varchar(50) default '',               -- Ville de livraison
  Code_Pays_Liv        char(2) default 'FR',                 -- Code pays de livraison
  Civ_Inter_Liv        tinyint unsigned default 0,           -- Civilité de l'interlocuteur de livraison
  Nom_Inter_Liv        varchar(30) default '',               -- Nom de l'interlocuteur de livraison
  Prenom_Inter_Liv     varchar(30) default '',               -- Prénom de l'interlocuteur de livraison
  Tel_Inter_Liv        varchar(20) default '',               -- Téléphone de l'interlocuteur de livraison
  Fax_Inter_Liv        varchar(20) default '',               -- Fax de l'interlocuteur de livraison
  Email_Inter_Liv      varchar(64) default '',               -- Email de l'interlocuteur de livraison
  Denomination_Envoi   varchar(50) default '',               -- Dénomination d'envoi facture
  Adresse_1_Envoi      varchar(80) default '',               -- Ligne d'adresse 1 d'envoi facture
  Adresse_2_Envoi      varchar(50) default '',               -- Ligne d'adresse 2 d'envoi facture
  Adresse_3_Envoi      varchar(50) default '',               -- Ligne d'adresse 3 d'envoi facture
  Code_Postal_Envoi    varchar(10) default '',               -- Code postal d'envoi facture
  Ville_Envoi          varchar(50) default '',               -- Ville d'envoi facture
  Code_Pays_Envoi      char(2) default 'FR',                 -- Code pays d'envoi facture
  Civ_Inter_Envoi      tinyint unsigned default 0,           -- Civilité de l'interlocuteur d'envoi
  Nom_Inter_Envoi      varchar(30) default '',               -- Nom de l'interlocuteur d'envoi
  Prenom_Inter_Envoi   varchar(30) default '',               -- Prénom de l'interlocuteur d'envoi
  Tel_Inter_Envoi      varchar(20) default '',               -- Téléphone de l'interlocuteur d'envoi
  Fax_Inter_Envoi      varchar(20) default '',               -- Fax de l'interlocuteur d'envoi
  Email_Inter_Envoi    varchar(64) default '',               -- Email de l'interlocuteur d'envoi
  primary key (Commande_Id),
  index idx_affaire_id (Affaire_Id),
  index idx_client_id (Client_Id),
  index idx_mode_expedition (Mode_Expedition),
  index idx_secteur_activite (Secteur_Activite),
  index idx_code_tva_port (Code_TVA_Port),
  index idx_mode_reg_id (Mode_Reg_Id),
  constraint cfk_commande_client_initiale_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id),
  constraint cfk_commande_client_initiale_affaire_id foreign key (Affaire_Id) references AFFAIRE (Affaire_Id),
  constraint cfk_commande_client_initiale_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_commande_client_initiale_mode_expedition foreign key (Mode_Expedition) references MODE_LIVRAISON (Mode_Liv_Id),
  constraint cfk_commande_client_initiale_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_commande_client_initiale_code_tva_port foreign key (Code_TVA_Port) references TAUX_TVA (Code_TVA),
  constraint cfk_commande_client_initiale_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;


create table LIGNE_COMMANDE_CLIENT_INITIALE (
  Ligne_Id            int unsigned not null,                 -- Identifiant de la ligne de commande
  Commande_Id         int unsigned not null,                 -- Identifiant de la commande
  Rank                int unsigned not null,                 -- Numéro d'ordre dans la commande
  Type_Ligne          char(1) default 'I',                   -- Type de la ligne (S=Stock, I=Indépendante)
  Reference           varchar(40) default '',                -- Référence de l'article
  Designation         varchar(100) default '',               -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,      -- Quantité
  Prix_Unitaire       decimal(14,4) unsigned default 0,      -- Prix unitaire de l'article
  Ristourne           decimal(5,2) unsigned default 0,       -- Pourcentage de ristourne
  Taux_TVA            decimal(4,2) unsigned default 0,       -- Taux de TVA
  Code_TVA            int unsigned default 1,                -- Code TVA
  Commentaire_Avant   text,                                  -- Commentaire placé avant la ligne
  Commentaire_Apres   text,                                  -- Commentaire placé après la ligne
  Libelle             varchar(20) default '',                -- Libellé supplémentaire
  Code_Stats          varchar(10) default '',                -- Code de statistiques
  Unite               char(3) default 'U',                   -- Unité de vente
  Nb_Pieces           int unsigned default 0,                -- Nombre de pièces
  Num_Lot             varchar(15) default '',                -- Numéro de lot
  Date_Peremption     bigint unsigned default 0,             -- Date de péremption
  Commission          decimal(4,2) unsigned default 0,       -- Taux de commission
  Montant_Ligne       decimal(14,2) unsigned default 0,      -- Montant de la ligne
  Soldee              tinyint unsigned default 0,            -- Ligne soldée (entièrement livrée)
  Statut              char(1) default 'V',                   -- Statut de la ligne (V=Valide, A=Annulée)
  Prix_Achat          decimal(14,4) unsigned default 0,      -- Prix d'achat unitaire HT
  Marge_Ligne         decimal(14,2) default 0,               -- Montant de marge HT sur la ligne
  primary key (Ligne_Id),
  index idx_commande_id (Commande_Id),
  index idx_code_tva (Code_TVA),
  index idx_reference (Reference),
  constraint cfk_ligne_commande_client_initiale_ligne_id foreign key (Ligne_Id) references LIGNE_COMMANDE_CLIENT (Ligne_Id),
  constraint cfk_ligne_commande_client_initiale_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT_INITIALE (Commande_Id),
  constraint cfk_ligne_commande_client_initiale_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA)
) engine=InnoDB;


create table HISTORIQUE_COMMANDE_CLIENT (
  Hist_Id             int unsigned not null auto_increment,  -- Identifiant de l'historique
  Commande_Id         int unsigned not null,                 -- Identifiant commande client
  Date                bigint unsigned default 0,             -- Date de changement
  Util_M              int not null,                          -- Utilisateur ayant effectué le changement
  Ref_Ligne           int unsigned default null,             -- Identifiant de la ligne modifiée
  Libelle             text,                                  -- Libellé du changement
  primary key (Hist_Id),
  index idx_commande_id (Commande_Id),
  index idx_ref_ligne (Ref_Ligne),
  constraint cfk_historique_commande_client_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id),
  constraint cfk_historique_commande_client_ref_ligne foreign key (Ref_Ligne) references LIGNE_COMMANDE_CLIENT (Ligne_Id)
) engine=InnoDB;



create table DEVIS (
  Devis_Id            int unsigned not null auto_increment, -- Identifiant de devis
  Date_Devis          bigint unsigned default 0,            -- Date du devis
  Remise              decimal(9,6) unsigned default 0,      -- Pourcentage de remise
  Montant_Remise      decimal(9,2) unsigned default 0,      -- Montant de remise uniquement si remise en montant sinon 0
  PRemise_FP          decimal(9,6) unsigned default 0,      -- Pourcentage de remise sur frais de port
  MRemise_FP          decimal(9,2) unsigned default 0,      -- Montant de remise sur frais de port uniquement si remise en montant sinon 0
  Escompte            decimal(5,2) unsigned default 0,      -- Pourcentage d'escompte
  Old_Acompte         decimal(14,2) unsigned default 0,     -- OBSOLETE - Montant d'acompte TTC
  Frais_Port          decimal(10,2) unsigned default 0,     -- Montant des frais de port
  Commentaires_Fin    text,                                 -- Commentaires de fin de devis
  Commentaires_Int    text,                                 -- Commentaires internes
  Commentaires_Hid    text,                                 -- Commentaires cachés
  Date_C              bigint unsigned default 0,            -- Date de création du devis
  Date_M              bigint unsigned default 0,            -- Date de mise à jour
  Util_C              int not null,                         -- Utilisateur créateur du devis
  Util_M              int not null,                         -- Utilisateur ayant fait la dernière modification du devis
  Util_R              int default null,                     -- Utilisateur responsable du devis
  Numero              int unsigned default 0,               -- Numero de devis
  Num_Entier          char(10) default '',                  -- Numéro sous sa forme intégrale
  Etat                char(1) default 'N',                  -- Etat du devis (H=archivé,F=facturé,A=validé en affaire,N=validable,D=non validable)
  Intitule            varchar(20) default '',               -- Intitulé du devis
  Date_Exp            bigint unsigned default 0,            -- Date d'expiration de l'offre
  Total_HT            decimal(14,2) default 0,              -- Total HT du devis
  Total_TTC           decimal(14,2) default 0,              -- Montant TTC du devis
  Mode_Reg_Id         int unsigned default null,            -- Mode de règlement
  Date_Validation     bigint unsigned default 0,            -- Date de validation en commande
  Denomination        varchar(50) default '',               -- Raison sociale
  Adresse_1           varchar(80) default '',               -- Ligne d'adresse 1
  Adresse_2           varchar(50) default '',               -- Ligne d'adresse 2
  Adresse_3           varchar(50) default '',               -- Ligne d'adresse 3
  Code_Postal         varchar(10) default '',               -- Code postal
  Ville               varchar(50) default '',               -- Ville
  Code_Pays           char(2) default 'FR',                 -- Code pays
  Client_Id           char(10) default null,                -- Identifiant client
  Civ_Inter           tinyint unsigned default 0,
  Nom_Inter           varchar(30) default '',               -- Nom et prénom du client
  Prenom_Inter        varchar(30) default '',
  Tel_Inter           varchar(20) default '',
  Fax_Inter           varchar(20) default '',
  Email_Inter         varchar(64) default '',
  Code_Tarif          tinyint unsigned default 1,           -- Code tarif utilisé
  Edition_TTC         tinyint unsigned default 0,           -- 1 si le devis est édité en TTC
  Taux_Indicatif      decimal(7,4) unsigned default 0,
  Assujetti_TVA       tinyint unsigned default 0,           -- Assujetti à la TVA (1=oui,0=non)
  Num_TVA_Intra       varchar(14) default '',               -- Numéro de TVA intracommunautaire
  Denomination_Liv    varchar(50) default '',               -- Denomination de livraison
  Adresse_1_Liv       varchar(80) default '',               -- Ligne d'adresse 1 de livraison
  Adresse_2_Liv       varchar(50) default '',               -- Ligne d'adresse 2 de livraison
  Adresse_3_Liv       varchar(50) default '',               -- Ligne d'adresse 3 de livraison
  Code_Postal_Liv     varchar(10) default '',               -- Code postal de livraison
  Ville_Liv           varchar(50) default '',               -- Ville de livraison
  Code_Pays_Liv       char(2) default 'FR',                 -- Code pays de livraison
  Civ_Inter_Liv       tinyint unsigned default 0,           -- Civilité de l'interlocuteur de livraison
  Nom_Inter_Liv       varchar(30) default '',               -- Nom de l'interlocuteur de livraison
  Prenom_Inter_Liv    varchar(30) default '',               -- Prénom de l'interlocuteur de livraison
  Tel_Inter_Liv       varchar(20) default '',               -- Téléphone de l'interlocuteur de livraison
  Fax_Inter_Liv       varchar(20) default '',               -- Fax de l'interlocuteur de livraison
  Email_Inter_Liv     varchar(64) default '',               -- E-Mail de l'interlocuteur de livraison
  Mentions            text,                                 -- Mentions
  Taux_TVA_Port       decimal(4,2) unsigned default 0,      -- Taux de TVA des frais de port
  Code_TVA_Port       int unsigned not null,                -- Code de TVA des frais de port
  Regime_TVA          char(1) default 'G',                  -- Régime TVA (G=général, T=forcer la TVA, E=exonération)
  Denomination_Envoi  varchar(50) default '',               -- Dénomination d'envoi devis
  Adresse_1_Envoi     varchar(80) default '',               -- Ligne d'adresse 1 d'envoi devis
  Adresse_2_Envoi     varchar(50) default '',               -- Ligne d'adresse 2 d'envoi devis
  Adresse_3_Envoi     varchar(50) default '',               -- Ligne d'adresse 3 d'envoi devis
  Code_Postal_Envoi   varchar(10) default '',               -- Code postal d'envoi devis
  Ville_Envoi         varchar(50) default '',               -- Ville d'envoi devis
  Code_Pays_Envoi     char(2) default 'FR',                 -- Code pays d'envoi devis
  Civ_Inter_Envoi     tinyint unsigned default 0,           -- Civilité de l'interlocuteur d'envoi
  Nom_Inter_Envoi     varchar(30) default '',               -- Nom de l'interlocuteur d'envoi
  Prenom_Inter_Envoi  varchar(30) default '',               -- Prénom de l'interlocuteur d'envoi
  Tel_Inter_Envoi     varchar(20) default '',               -- Téléphone de l'interlocuteur d'envoi
  Fax_Inter_Envoi     varchar(20) default '',               -- Fax de l'interlocuteur d'envoi
  Email_Inter_Envoi   varchar(64) default '',               -- Email de l'interlocuteur d'envoi
  Vers_Calc           tinyint unsigned default 2,           -- Version de calcul de document
  Secteur_Activite    int unsigned default null,            -- Secteur d'activité
  primary key (Devis_Id),
  index idx_code_tva_port (Code_TVA_Port),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_client_id (Client_Id),
  index idx_secteur_activite (Secteur_Activite),
  constraint cfk_devis_code_tva_port foreign key (Code_TVA_Port) references TAUX_TVA (Code_TVA),
  constraint cfk_devis_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id),
  constraint cfk_devis_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_devis_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id)
) engine=InnoDB;


create table LIGNE_DEVIS (
  Ligne_Id            int unsigned auto_increment,          -- Identifiant unique de ligne
  Devis_Id            int unsigned not null,                -- Numéro de devis
  Rank                int unsigned not null,                -- Numéro d'ordre dans le devis
  Reference           varchar(40) default '',               -- Code article
  Type_Ligne          char(1) default 'I',                  -- Type de la ligne (S=Stock,I=Indépendante)
  Designation         varchar(100) default '',              -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,     -- Quantité
  Prix                decimal(14,4) unsigned default 0,     -- Prix de l'article
  Ristourne           decimal(5,2) unsigned default 0,      -- Pourcentage de ristourne
  Code_TVA            int unsigned default 1,               -- Code TVA
  Commentaire         text,                                 -- Commentaire bas associé à la ligne
  Commentaire_Avant   text,                                 -- Commentaire haut associé à la ligne
  Libelle             varchar(20) default '',               -- Libelle supplémentaire
  Taux_TVA            decimal(4,2) unsigned default 0,      -- Taux de TVA
  Code_Stats          varchar(10) default '',               -- code de statistiques
  Unite               char(3) default 'U',                  -- unité de vente
  Num_Lot             varchar(15) default '',               -- numéro de lot
  Nb_Pieces           int unsigned default 0,               -- nombre de pièces par quantité
  Date_Peremption     bigint unsigned default 0,            -- date de péremption
  Commission          decimal(4,2) unsigned default 0,      -- Taux de commission
  Montant_Ligne       decimal(14,2) unsigned default 0,     -- Montant de la ligne
  primary key (Ligne_Id),
  index idx_code_tva (Code_TVA),
  index idx_devis_id (Devis_Id),
  constraint cfk_ligne_devis_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_ligne_devis_devis_id foreign key (Devis_Id) references DEVIS (Devis_Id)
) engine=InnoDB;


create table BON_LIVRAISON (
  Bon_Id              int unsigned not null auto_increment, -- Identifiant du bon de livraison
  Commande_Id         int unsigned not null,                -- Identifiant de la commande client
  Numero              int unsigned default 0,               -- Numéro du bon de livraison
  Num_Entier          char(10) default '',                  -- Numéro sous sa forme intégrale
  Date_Liv            bigint unsigned default 0,            -- Date de livraison
  Date_C              bigint unsigned default 0,            -- Date de création
  Date_M              bigint unsigned default 0,            -- Date de dernière mise à jour
  Util_C              int not null,                         -- Utilisateur de création
  Util_M              int not null,                         -- Utilisateur ayant fait la dernière modification du BL
  Commentaires_Fin    text,                                 -- Commentaires de fin de BL
  Commentaires_Int    text,                                 -- Commentaires internes
  Commentaires_Hid    text,                                 -- Commentaires cachés
  Mentions            text,                                 -- Mentions
  Nb_Colis            int unsigned default 0,               -- Nombre de colis
  Frais_Sup           decimal(12,2) unsigned default 0,     -- Frais de port supplémentaires établis à la livraison
  Etat                char(1) default 'N',                  -- Etat du bon de livraison (V=validé,N=non validé,A=Annulé)
  Fournisseur_Id      char(10) default null,                -- Identifiant du fournisseur si livraison directe
  Com_Fournisseur_Id  int unsigned default null,            -- Identifiant de la commande fournisseur si livraison directe
  Date_DEB            bigint unsigned default 0,            -- Date de l'export DEB
  Date_Edition_Lot    bigint unsigned default 0,            -- Date de l'édition par lot
  Edition_BP          tinyint unsigned default 0,           -- le BP était-il édité lors de l'édition par lot? 0->non; 1->oui
  Denomination_Liv    varchar(100) default '',              -- Dénomination pour la livraison
  Adresse_1_Liv       varchar(80) default '',               -- Ligne d'adresse 1 de livraison
  Adresse_2_Liv       varchar(50) default '',               -- Ligne d'adresse 2 de livraison
  Adresse_3_Liv       varchar(50) default '',               -- Ligne d'adresse 3 de livraison
  Code_Postal_Liv     varchar(10) default '',               -- Code postal de l'adresse de livraison
  Ville_Liv           varchar(50) default '',               -- Ville de l'adresse de livraison
  Code_Pays_Liv       char(2) default 'FR',                 -- Code pays de livraison
  Civ_Inter_Liv       tinyint unsigned default 0,           -- Civilité du contact de livraison
  Nom_Inter_Liv       varchar(30) default '',               -- Nom du contact de livraison
  Prenom_Inter_Liv    varchar(30) default '',               -- Prénom du contact de livraison
  Tel_Inter_Liv       varchar(20) default '',               -- Téléphone du contact de livraison
  Fax_Inter_Liv       varchar(20) default '',               -- Fax du contact de livraison
  Email_Inter_Liv     varchar(64) default '',               -- Email du contact de livraison
  Mode_Expedition     int unsigned default null,            -- Mode d'expédition
  Statut_Expedition   char(1) default 'N',                  -- Statut d'expédition (N=Pas de statut, P=Préparée, E=Expédiée, L=Livrée)
  Facture             tinyint unsigned default 0,           -- Bon de livraison entièrement facturé (1=oui,0=non)
  Total_HT            decimal(14,2) default 0,              -- Total HT
  Total_TTC           decimal(14,2) default 0,              -- Total TTC
  primary key (Bon_Id),
  index idx_commande_id (Commande_Id),
  index idx_com_fournisseur_id (Com_Fournisseur_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  index idx_mode_expedition (Mode_Expedition),
  constraint cfk_bon_livraison_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id),
  constraint cfk_bon_livraison_com_fournisseur_id foreign key (Com_Fournisseur_Id) references COMMANDE_FOURNISSEUR (Commande_Id),
  constraint cfk_bon_livraison_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade,
  constraint cfk_bon_livraison_mode_expedition foreign key (Mode_Expedition) references MODE_LIVRAISON (Mode_Liv_Id)
) engine=InnoDB;


create table LIGNE_BON_LIVRAISON (
  Ligne_Id            int unsigned not null auto_increment, -- Identifiant de la ligne de BL
  Bon_Id              int unsigned not null,                -- Identifiant du bon de livraison
  Ref_Ligne           int unsigned not null,                -- Ligne correspondante de la commande client
  Rank                int unsigned not null,                -- Rang de l'article sur le BL
  Quantite            decimal(10,3) unsigned default 1,     -- Quantité
  Num_Lot             varchar(15) default '',               -- Numéro de lot
  Nb_Pieces           int unsigned default 0,               -- Nombre de pièces par quantité
  Date_Peremption     bigint unsigned default 0,            -- Date de péremption
  Montant_Ligne       decimal(14,2) unsigned default 0,     -- Montant de la ligne
  Statut              char(1) default 'V',                  -- Statut de la ligne (V=Valide,A=Annulée)
  primary key (Ligne_Id),
  index idx_ref_ligne (Ref_Ligne),
  index idx_bon_id (Bon_Id),
  constraint cfk_ligne_bon_livraison_bon_id foreign key (Bon_Id) references BON_LIVRAISON (Bon_Id),
  constraint cfk_ligne_bon_livraison_ref_ligne foreign key (Ref_Ligne) references LIGNE_COMMANDE_CLIENT (Ligne_Id)
) engine=InnoDB;


create table CODE_PRODUIT_LIGNE_BL (
  Ligne_Id            int unsigned not null,                -- Identifiant de la ligne de bon de livraison
  Produit_Id          int unsigned not null,                -- Identifiant du code produit
  primary key (Ligne_Id, Produit_Id),
  constraint cfk_code_produit_produit_id foreign key (Produit_Id) references CODE_PRODUIT (Produit_Id),
  constraint cfk_code_produit_ligne_id foreign key (Ligne_Id) references LIGNE_BON_LIVRAISON (Ligne_Id)
) engine=InnoDB;



create table BON_RETOUR_CLIENT (
  Bon_Id              int unsigned not null auto_increment, -- Identifiant du bon de retour
  BL_Id               int unsigned not null,                -- Identifiant du bon de livraison
  Numero              char(10) default '',                  -- Numéro du bon de retour (RCyymm0000)
  Date_Bon            bigint unsigned default 0,            -- Date du bon de retour
  Date_Retour         bigint unsigned default 0,            -- Date de retour de la marchandise
  Date_C              bigint unsigned default 0,            -- Date de création
  Date_M              bigint unsigned default 0,            -- Date de dernière mise à jour
  Util_C              int not null,                         -- Utilisateur de création
  Util_M              int not null,                         -- Utilisateur ayant fait la dernière modification du bon de retour
  Commentaires_Fin    text,                                 -- Commentaires de fin de BL
  Commentaires_Int    text,                                 -- Commentaires internes
  Commentaires_Hid    text,                                 -- Commentaires cachés
  Mentions            text,                                 -- Mentions
  Etat                char(1) default 'N',                  -- Etat du bon de retour (V=Validé,N=Non validé,A=Annulé,E=En attente)
  Denomination        varchar(100) default '',              -- Dénomination
  Adresse_1           varchar(80) default '',               -- Ligne d'adresse 1
  Adresse_2           varchar(50) default '',               -- Ligne d'adresse 2
  Adresse_3           varchar(50) default '',               -- Ligne d'adresse 3
  Code_Postal         varchar(10) default '',               -- Code postal
  Ville               varchar(50) default '',               -- Ville
  Code_Pays           char(2) default 'FR',                 -- Code pays
  Civ_Inter           tinyint unsigned default 0,           -- Civilité du contact
  Nom_Inter           varchar(30) default '',               -- Nom du contact
  Prenom_Inter        varchar(30) default '',               -- Prénom du contact
  Tel_Inter           varchar(20) default '',               -- Téléphone du contact
  Fax_Inter           varchar(20) default '',               -- Fax du contact
  Email_Inter         varchar(64) default '',               -- Email du contact
  Total_HT            decimal(14,2) default 0,              -- Total HT
  Total_TTC           decimal(14,2) default 0,              -- Total TTC
  primary key (Bon_Id),
  index idx_bl_id (BL_Id),
  constraint cfk_bon_retour_client_bl_id foreign key (BL_Id) references BON_LIVRAISON (Bon_Id)
) engine=InnoDB;


create table LIGNE_BON_RETOUR_CLIENT (
  Ligne_Id            int unsigned not null auto_increment, -- Identifiant de la ligne de bon de retour
  Bon_Id              int unsigned not null,                -- Identifiant du bon de retour
  Ligne_BL            int unsigned not null,                -- Ligne correspondante de BL
  Rank                int unsigned not null,                -- Rang de l'article sur le bon de retour
  Quantite            decimal(10,3) unsigned default 1,     -- Quantité
  Nb_Pieces           int unsigned default 0,               -- Nombre de pièces par quantité
  Montant_Ligne       decimal(14,2) unsigned default 0,     -- Montant de la ligne
  primary key (Ligne_Id),
  index idx_ligne_bl (Ligne_BL),
  index idx_bon_id (Bon_Id),
  constraint cfk_ligne_bon_retour_client_bon_id foreign key (Bon_Id) references BON_RETOUR_CLIENT (Bon_Id),
  constraint cfk_ligne_bon_retour_client_ligne_bl foreign key (Ligne_BL) references LIGNE_BON_LIVRAISON (Ligne_Id)
) engine=InnoDB;



create table FACTURE (
  Facture_Id          int unsigned not null auto_increment, -- Identifiant facture
  Date_Facture        bigint unsigned default 0,            -- Date de la facture
  Numero              int unsigned default 0,               -- Numéro de facture
  Num_Entier          varchar(12) default '',               -- Numéro sous sa forme intégrale
  Commentaires_Fin    text,                                 -- Commentaires de fin de facture
  Commentaires_Int    text,                                 -- Commentaires internes
  Commentaires_Hid    text,                                 -- Commentaires cachés
  Nom_Resp            varchar(30) default '',               -- Nom du responsable
  Prenom_Resp         varchar(20) default '',               -- Prénom du responsable
  Civ_Inter           tinyint unsigned default 0,
  Nom_Inter           varchar(30) default '',               -- Nom et prénom du client
  Prenom_Inter        varchar(30) default '',
  Tel_Inter           varchar(20) default '',
  Fax_Inter           varchar(20) default '',
  Email_Inter         varchar(64) default '',
  Client_Id           char(10) default null,                -- Code client
  Denomination        varchar(50) default '',               -- Raison sociale
  Adresse_1           varchar(80) default '',               -- Ligne d'adresse 1 de facturation
  Adresse_2           varchar(50) default '',               -- Ligne d'adresse 2 de facturation
  Adresse_3           varchar(50) default '',               -- Ligne d'adresse 3 de facturation
  Code_Postal         varchar(10) default '',               -- Code postal de facturation
  Ville               varchar(50) default '',               -- Ville de facturation
  Code_Pays           char(2) default 'FR',                 -- Code pays
  Date_C              bigint unsigned default 0,            -- date de création
  Date_M              bigint unsigned default 0,            -- date de mise à jour
  Util_C              int not null,                         -- utilisateur créateur de la facture
  Util_M              int not null,                         -- utilisateur ayant fait la dernière modification de la facture
  Util_R              int default null,                     -- utilisateur responsable de la facture
  Old_Acompte         decimal(14,2) unsigned default 0,     -- OBSOLETE - Montant d'acompte TTC
  Remise              decimal(9,6) unsigned default 0,      -- Pourcentage de remise
  Montant_Remise      decimal(9,2) unsigned default 0,      -- Montant de remise uniquement si remise en montant sinon 0
  PRemise_FP          decimal(9,6) unsigned default 0,      -- Pourcentage de remise sur frais de port
  MRemise_FP          decimal(9,2) unsigned default 0,      -- Montant de remise sur frais de port uniquement si remise en montant sinon 0
  Escompte            decimal(6,3) unsigned default 0,      -- Pourcentage d'escompte
  Frais_Port          decimal(10,2) unsigned default 0,     -- Montant HT des frais de port
  Total_HT            decimal(14,2) unsigned default 0,     -- Total HT de la facture
  Total_TVA           decimal(14,2) unsigned default 0,     -- Total TVA
  Total_TTC           decimal(14,2) unsigned default 0,     -- Montant TTC de la facture
  Marge_HT            decimal(14,2) default 0,              -- Montant de marge HT
  Directe             tinyint unsigned default 0,           -- Facture directe (non liée à une affaire) (1=oui,0=non)
  Code_Tarif          tinyint unsigned default 1,           -- Code tarif utilisé
  Transferee          tinyint unsigned default 0,           -- 1 si facture transférée en compta
  Taux_TVA_Port       decimal(4,2) unsigned default 0,      -- Taux de TVA des frais de port
  Code_TVA_Port       int unsigned not null,                -- Code de TVA des frais de port
  Edition_TTC         tinyint unsigned default 0,           -- 1 si la facture est éditée en ttc
  Eco_Taxe            decimal(10,2) unsigned default 0,     -- Montant HT de l'eco-participation dans la facture
  Taux_Indicatif      decimal(7,4) unsigned default 0,
  Assujetti_TVA       tinyint unsigned default 0,           -- Assujetti à la TVA (1=oui,0=non)
  TVA_Liv             tinyint unsigned default 0,           -- Application de la TVA du pays de livraison (1=oui,0=non)
  Num_TVA_Intra       varchar(14) default '',               -- Numéro de TVA intracommunautaire
  Denomination_Liv    varchar(50) default '',               -- Denomination de livraison
  Adresse_1_Liv       varchar(80) default '',               -- Ligne d'adresse 1 de livraison
  Adresse_2_Liv       varchar(50) default '',               -- Ligne d'adresse 2 de livraison
  Adresse_3_Liv       varchar(50) default '',               -- Ligne d'adresse 3 de livraison
  Code_Postal_Liv     varchar(10) default '',               -- Code postal de livraison
  Ville_Liv           varchar(50) default '',               -- Ville de livraison
  Code_Pays_Liv       char(2) default 'FR',                 -- Code pays de livraison
  Civ_Inter_Liv       tinyint unsigned default 0,           -- Civilité de l'interlocuteur de livraison
  Nom_Inter_Liv       varchar(30) default '',               -- Nom de l'interlocuteur de livraison
  Prenom_Inter_Liv    varchar(30) default '',               -- Prénom de l'interlocuteur de livraison
  Tel_Inter_Liv       varchar(20) default '',               -- Téléphone de l'interlocuteur de livraison
  Fax_Inter_Liv       varchar(20) default '',               -- Fax de l'interlocuteur de livraison
  Email_Inter_Liv     varchar(64) default '',               -- E-Mail de l'interlocuteur de livraison
  Num_Unique          int unsigned default null,            -- Numéro unique chronologique selon la validation de la facture ou avoir
  Mentions            text,                                 -- Mentions
  Date_DEB            bigint unsigned default 0,            -- Date de l'export DEB
  Regime_TVA          char(1) default 'G',                  -- Régime TVA (G=général, T=forcer la TVA, E=exonération)
  Date_Edition_Lot    bigint unsigned default 0,            -- Date de l'édition par lot
  Denomination_Envoi  varchar(50) default '',               -- Dénomination d'envoi facture
  Adresse_1_Envoi     varchar(80) default '',               -- Ligne d'adresse 1 d'envoi facture
  Adresse_2_Envoi     varchar(50) default '',               -- Ligne d'adresse 2 d'envoi facture
  Adresse_3_Envoi     varchar(50) default '',               -- Ligne d'adresse 3 d'envoi facture
  Code_Postal_Envoi   varchar(10) default '',               -- Code postal d'envoi facture
  Ville_Envoi         varchar(50) default '',               -- Ville d'envoi facture
  Code_Pays_Envoi     char(2) default 'FR',                 -- Code pays d'envoi facture
  Civ_Inter_Envoi     tinyint unsigned default 0,           -- Civilité de l'interlocuteur d'envoi
  Nom_Inter_Envoi     varchar(30) default '',               -- Nom de l'interlocuteur d'envoi
  Prenom_Inter_Envoi  varchar(30) default '',               -- Prénom de l'interlocuteur d'envoi
  Tel_Inter_Envoi     varchar(20) default '',               -- Téléphone de l'interlocuteur d'envoi
  Fax_Inter_Envoi     varchar(20) default '',               -- Fax de l'interlocuteur d'envoi
  Email_Inter_Envoi   varchar(64) default '',               -- Email de l'interlocuteur d'envoi
  Date_Edition_Auto   bigint unsigned default 0,            -- Date d'édition automatique
  Mode_Envoi_Facture  char(1) default 'C',                  -- Mode d'envoi de la facture (C=Courrier,F=Fax,M=Mail)
  Date_Envoi          bigint unsigned default 0,            -- Date d'envoi de la facture
  Vers_Calc           tinyint unsigned default 2,           -- Version de calcul de document
  Secteur_Activite    int unsigned default null,            -- Secteur d'activité
  Statut_Paiement     char(1) default 'N',                  -- Statut du paiement (N=Non payé, P=Partiellement payé, T=Totalement payé)
  primary key (Facture_Id),
  index idx_code_tva_port (Code_TVA_Port),
  index idx_secteur_activite (Secteur_Activite),
  index idx_client_id (Client_Id),
  constraint cfk_facture_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_facture_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_facture_code_tva_port foreign key (Code_TVA_Port) references TAUX_TVA (Code_TVA)
) engine=InnoDB;


create table LIGNE_FACTURE (
  Ligne_Id            int unsigned not null auto_increment, -- Identifiant de la ligne de facture
  Facture_Id          int unsigned not null,                -- Identifiant facture
  Ref_Ligne           int unsigned default null,            -- Ligne correspondante dans la commande client
  Rank                int unsigned not null,                -- Numéro d'ordre dans la facture
  Reference           varchar(40) default '',               -- Code article
  Type_Ligne          char(1) default 'I',                  -- Type de la ligne (S=Stock,I=Indépendante)
  Designation         varchar(100) default '',              -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,     -- Quantité
  Prix                decimal(14,4) unsigned default 0,     -- Prix unitaire HT de l'article
  Ristourne           decimal(5,2) unsigned default 0,      -- Taux de ristourne
  Taux_TVA            decimal(4,2) unsigned default 0,      -- Taux de TVA
  Code_TVA            int unsigned default 1,               -- Code de TVA
  Commentaire         text,                                 -- Commentaire bas associé à la ligne
  Commentaire_Avant   text,                                 -- Commentaire haut associé à la ligne
  Libelle             varchar(20) default '',               -- Libelle supplémentaire
  Code_Stats          varchar(10) default '',               -- code de statistiques
  Unite               char(3) default 'U',                  -- unité de vente
  Num_Lot             varchar(15) default '',               -- numéro de lot
  Nb_Pieces           int unsigned default 0,               -- nombre de pièces par quantité
  Date_Peremption     bigint unsigned default 0,            -- date de péremption
  Commission          decimal(4,2) unsigned default 0,      -- Taux de commission
  Montant_Ligne       decimal(14,2) unsigned default 0,     -- Montant de la ligne
  Prix_Achat          decimal(14,4) unsigned default 0,     -- Prix d'achat unitaire HT
  Marge_Ligne         decimal(14,2) default 0,              -- Montant de marge HT sur la ligne
  primary key (Ligne_Id),
  index idx_facture_id (Facture_Id),
  index idx_code_tva (Code_TVA),
  index idx_ref_ligne (Ref_Ligne),
  constraint cfk_ligne_facture_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_ligne_facture_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id),
  constraint cfk_ligne_facture_ref_ligne foreign key (Ref_Ligne) references LIGNE_COMMANDE_CLIENT (Ligne_Id)
) engine=InnoDB;


create table ECHEANCE_FACTURE_CLIENT (
  Echeance_Id         int unsigned not null auto_increment,  -- Identifiant de l'échéance
  Facture_Id          int unsigned not null,                 -- Identifiant de la facture
  Mode_Reg_Id         int unsigned default null,             -- Mode de règlement de l'échéance
  Date_Echeance       bigint unsigned default 0,             -- Date d'échéance
  Montant             decimal(14,2) unsigned default 0,      -- Montant de l'échéance
  primary key (Echeance_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_facture_id (Facture_Id),
  constraint cfk_echeance_facture_client_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id),
  constraint cfk_echeance_facture_client_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id)
) engine=InnoDB;


create table ACOMPTE_CLIENT (
  Acompte_Id          int unsigned not null auto_increment,  -- Identifiant de l'acompte
  Commande_Id         int unsigned not null,                 -- Identifiant de la commande client
  Statut              char(1) default 'V',                   -- Statut de l'acompte (V=Validé,A=Annulé)
  Date_Acompte        bigint unsigned default 0,             -- Date de l'acompte
  Numero              varchar(12) default '',                -- Numéro de facture
  Libelle             varchar(100) default '',               -- Libellé de l'acompte
  Mode_Reg_Id         int unsigned not null,                 -- Mode de règlement
  Taux_TVA            decimal(4,2) unsigned default 0,       -- Taux de TVA
  Code_TVA            int unsigned not null,                 -- Code de TVA
  Total_HT            decimal(14,2) unsigned default 0,      -- Total HT
  Total_TVA           decimal(14,2) unsigned default 0,      -- Total TVA
  Total_TTC           decimal(14,2) unsigned default 0,      -- Total TTC
  Commentaires_Fin    text,                                  -- Commentaires de fin d'acompte
  Client_Id           char(10) default null,                 -- Code client
  Denomination        varchar(50) default '',                -- Dénomination de facturation
  Adresse_1           varchar(80) default '',                -- Ligne d'adresse 1 de facturation
  Adresse_2           varchar(50) default '',                -- Ligne d'adresse 2 de facturation
  Adresse_3           varchar(50) default '',                -- Ligne d'adresse 3 de facturation
  Code_Postal         varchar(10) default '',                -- Code postal de facturation
  Ville               varchar(50) default '',                -- Ville de facturation
  Code_Pays           char(2) default 'FR',                  -- Code pays
  Civ_Inter           tinyint unsigned default 0,            -- Civilié du contact
  Nom_Inter           varchar(30) default '',                -- Nom du contact
  Prenom_Inter        varchar(30) default '',                -- Prénom du contact
  Tel_Inter           varchar(20) default '',                -- Téléphone du contact
  Fax_Inter           varchar(20) default '',                -- Fax du contact
  Email_Inter         varchar(64) default '',                -- Email du contact
  Denomination_Envoi  varchar(50) default '',                -- Dénomination d'envoi
  Adresse_1_Envoi     varchar(80) default '',                -- Ligne d'adresse 1 d'envoi
  Adresse_2_Envoi     varchar(50) default '',                -- Ligne d'adresse 2 d'envoi
  Adresse_3_Envoi     varchar(50) default '',                -- Ligne d'adresse 3 d'envoi
  Code_Postal_Envoi   varchar(10) default '',                -- Code postal d'envoi
  Ville_Envoi         varchar(50) default '',                -- Ville d'envoi
  Code_Pays_Envoi     char(2) default 'FR',                  -- Code pays d'envoi
  Civ_Inter_Envoi     tinyint unsigned default 0,            -- Civilité du contact d'envoi
  Nom_Inter_Envoi     varchar(30) default '',                -- Nom du contact d'envoi
  Prenom_Inter_Envoi  varchar(30) default '',                -- Prénom du contact d'envoi
  Tel_Inter_Envoi     varchar(20) default '',                -- Téléphone du contact d'envoi
  Fax_Inter_Envoi     varchar(20) default '',                -- Fax du contact d'envoi
  Email_Inter_Envoi   varchar(64) default '',                -- Email du contact d'envoi
  Date_C              bigint unsigned default 0,             -- Date de création
  Date_M              bigint unsigned default 0,             -- Date de dernière modification
  Util_C              int not null,                          -- Utilisateur créateur de l'acompte
  Util_M              int not null,                          -- Utilisateur ayant modifier l'acompte en dernier
  Util_R              int default null,                      -- Utilisateur responsable de la facture
  Comptabilise        tinyint unsigned default 0,            -- Transféré en comptabilité (oui/non)
  Compta_Annul        tinyint unsigned default 0,            -- Annulé en comptabilité (oui/non)
  primary key (Acompte_Id),
  index idx_client_id (Client_Id),
  index idx_code_tva (Code_TVA),
  index idx_commande_id (Commande_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  constraint cfk_acompte_client_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_acompte_client_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_acompte_client_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id),
  constraint cfk_acompte_client_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;


create table IMPUTATION_ACOMPTE_FACTURE_CLIENT (
  Acompte_Id          int unsigned not null,                 -- Identifiant de l'acompte client
  Facture_Id          int unsigned not null,                 -- Identifiant de la facture client
  Montant             decimal(14,2) unsigned default 0,
  primary key (Acompte_Id, Facture_Id),
  constraint cfk_imputation_acompte_facture_client_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id),
  constraint cfk_imputation_acompte_facture_client_acompte_id foreign key (Acompte_Id) references ACOMPTE_CLIENT (Acompte_Id)
) engine=InnoDB;


create table IMPUTATION_LIGNE_BL_FC (
  Ref_Ligne_BL        int unsigned not null,                -- Ligne du bon de livraison
  Ref_Ligne_FC        int unsigned not null,                -- Ligne de la facture client
  Quantite            decimal(10,3) unsigned default 0,     -- Quantité facturée du BL
  primary key (Ref_Ligne_BL, Ref_Ligne_FC),
  constraint cfk_imputation_ligne_bl_fc_ref_ligne_bl foreign key (Ref_Ligne_BL) references LIGNE_BON_LIVRAISON (Ligne_Id),
  constraint cfk_imputation_ligne_bl_fc_ref_ligne_fc foreign key (Ref_Ligne_FC) references LIGNE_FACTURE (Ligne_Id)
) engine=InnoDB;


create table CODE_PRODUIT_LIGNE_FC (
  Ligne_Id            int unsigned not null,                -- Identifiant de la ligne de facture client
  Produit_Id          int unsigned not null,                -- Identifiant du code produit
  primary key (Ligne_Id, Produit_Id),
  constraint cfk_code_produit_ligne_fc_produit_id foreign key (Produit_Id) references CODE_PRODUIT (Produit_Id),
  constraint cfk_code_produit_ligne_fc_ligne_id foreign key (Ligne_Id) references LIGNE_FACTURE (Ligne_Id)
) engine=InnoDB;


create table AFFAIRE_FACTURE (
  Affaire_Id          int unsigned not null,                -- Identifiant affaire
  Facture_Id          int unsigned not null,                -- Identifiant facture
  primary key (Affaire_Id, Facture_Id),
  constraint cfk_affaire_facture_affaire_id foreign key (Affaire_Id) references AFFAIRE (Affaire_Id),
  constraint cfk_affaire_facture_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id)
) engine=InnoDB;


create table COMMANDE_CLIENT_FACTURE (
  Commande_Id         int unsigned not null,                -- Identifiant commande client
  Facture_Id          int unsigned not null,                -- Identifiant facture
  Frais_Port          decimal(10,2) unsigned default 0,     -- Montant de frais de port
  primary key (Commande_Id, Facture_Id),
  constraint cfk_commande_client_facture_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id),
  constraint cfk_commande_client_facture_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id)
) engine=InnoDB;


create table AVOIR (
  Avoir_Id            int unsigned not null auto_increment, -- Identifiant avoir
  Date_Avoir          bigint unsigned default 0,            -- Date de l'avoir
  Numero              int unsigned default 0,               -- Numéro d'avoir
  Num_Entier          varchar(12) not null default '',      -- Numéro sous sa forme intégrale
  Commentaires_Fin    text,                                 -- Commentaires de fin d'avoir
  Commentaires_Int    text,                                 -- Commentaires internes
  Commentaires_Hid    text,                                 -- Commentaires cachés
  Nom_Resp            varchar(30) default '',               -- Nom du responsable
  Prenom_Resp         varchar(20) default '',               -- Prénom du responsable
  Civ_Inter           tinyint unsigned default 0,
  Nom_Inter           varchar(30) default '',               -- Nom et prénom du client
  Prenom_Inter        varchar(30) default '',
  Tel_Inter           varchar(20) default '',
  Fax_Inter           varchar(20) default '',
  Email_Inter         varchar(64) default '',
  Client_Id           char(10) default null,                -- Code client
  Denomination        varchar(50) default '',               -- Raison sociale
  Adresse_1           varchar(80) default '',               -- Ligne d'adresse 1 de facturation
  Adresse_2           varchar(50) default '',               -- Ligne d'adresse 2 de facturation
  Adresse_3           varchar(50) default '',               -- Ligne d'adresse 3 de facturation
  Code_Postal         varchar(10) default '',               -- Code postal de facturation
  Ville               varchar(50) default '',               -- Ville de facturation
  Code_Pays           char(2) default 'FR',                 -- Code pays
  Date_C              bigint unsigned default 0,            -- date de création
  Date_M              bigint unsigned default 0,            -- date de mise à jour
  Util_C              int not null,                         -- utilisateur créateur de l'avoir
  Util_M              int not null,                         -- utilisateur ayant fait la dernière modification de l'avoir
  Util_R              int default null,                     -- utilisateur responsable de l'avoir
  Remise              decimal(9,6) unsigned default 0,      -- Pourcentage de remise
  Montant_Remise      decimal(9,2) unsigned default 0,      -- Montant de remise uniquement si remise en montant sinon 0
  PRemise_FP          decimal(9,6) unsigned default 0,      -- Pourcentage de remise sur frais de port
  MRemise_FP          decimal(9,2) unsigned default 0,      -- Montant de remise sur frais de port uniquement si remise en montant sinon 0
  Escompte            decimal(6,3) unsigned default 0,      -- Pourcentage d'escompte
  Frais_Port          decimal(10,2) unsigned default 0,     -- Montant HT des frais de port
  Taux_TVA_Port       decimal(4,2) unsigned default 0,      -- Taux de TVA des frais de port
  Code_TVA_Port       int unsigned not null,                -- Code de TVA des frais de port
  Total_HT            decimal(14,2) unsigned default 0,     -- Total HT
  Total_TVA           decimal(14,2) unsigned default 0,     -- Total TVA
  Total_TTC           decimal(14,2) unsigned default 0,     -- Montant TTC
  Marge_HT            decimal(14,2) default 0,              -- Montant de marge HT
  Direct              tinyint unsigned default 0,           -- Avoir direct (non lié à une affaire) (1=oui,0=non)
  Code_Tarif          tinyint unsigned default 1,           -- Code tarif utilisé
  Transfere           tinyint unsigned default 0,           -- 1 si avoir transféré en compta
  Etat                char(1) default 'N',                  -- Etat pour règlement (N=Non imputé,T=imputé Totalement)
  Montant_Restant     decimal(14,2) default 0,              -- Montant restant à imputer en saisie règlement
  Edition_TTC         tinyint unsigned default 0,           -- 1 si l'avoir est édité en ttc
  Taux_Indicatif      decimal(7,4) unsigned default 0,      --
  Assujetti_TVA       tinyint unsigned default 0,           -- Assujetti à la TVA (1=oui,0=non)
  TVA_Liv             tinyint unsigned default 0,           -- Application de la TVA du pays de livraison (1=oui,0=non)
  Num_TVA_Intra       varchar(14) default '',               -- Numéro de TVA intracommunautaire
  Denomination_Liv    varchar(50) default '',               -- Denomination de livraison
  Adresse_1_Liv       varchar(80) default '',               -- Ligne d'adresse 1 de livraison
  Adresse_2_Liv       varchar(50) default '',               -- Ligne d'adresse 2 de livraison
  Adresse_3_Liv       varchar(50) default '',               -- Ligne d'adresse 3 de livraison
  Code_Postal_Liv     varchar(10) default '',               -- Code postal de livraison
  Ville_Liv           varchar(50) default '',               -- Ville de livraison
  Code_Pays_Liv       char(2) default 'FR',                 -- Code pays de livraison
  Civ_Inter_Liv       tinyint unsigned default 0,           -- Civilité de l'interlocuteur de livraison
  Nom_Inter_Liv       varchar(30) default '',               -- Nom de l'interlocuteur de livraison
  Prenom_Inter_Liv    varchar(30) default '',               -- Prénom de l'interlocuteur de livraison
  Tel_Inter_Liv       varchar(20) default '',               -- Téléphone de l'interlocuteur de livraison
  Fax_Inter_Liv       varchar(20) default '',               -- Fax de l'interlocuteur de livraison
  Email_Inter_Liv     varchar(64) default '',               -- E-Mail de l'interlocuteur de livraison
  Num_Unique          int unsigned default null,            -- Numéro unique chronologique selon la validation de la facture ou avoir
  Mentions            text,                                 -- Mentions
  Regime_TVA          char(1) default 'G',                  -- Régime TVA (G=général, T=forcer la TVA, E=exonération)
  Denomination_Envoi  varchar(50) default '',               -- Dénomination d'envoi de l'avoir
  Adresse_1_Envoi     varchar(80) default '',               -- Ligne d'adresse 1 d'envoi de l'avoir
  Adresse_2_Envoi     varchar(50) default '',               -- Ligne d'adresse 2 d'envoi de l'avoir
  Adresse_3_Envoi     varchar(50) default '',               -- Ligne d'adresse 3 d'envoi de l'avoir
  Code_Postal_Envoi   varchar(10) default '',               -- Code postal d'envoi de l'avoir
  Ville_Envoi         varchar(50) default '',               -- Ville d'envoi de l'avoir
  Code_Pays_Envoi     char(2) default 'FR',                 -- Code pays d'envoi de l'avoir
  Civ_Inter_Envoi     tinyint unsigned default 0,           -- Civilité de l'interlocuteur d'envoi
  Nom_Inter_Envoi     varchar(30) default '',               -- Nom de l'interlocuteur d'envoi
  Prenom_Inter_Envoi  varchar(30) default '',               -- Prénom de l'interlocuteur d'envoi
  Tel_Inter_Envoi     varchar(20) default '',               -- Téléphone de l'interlocuteur d'envoi
  Fax_Inter_Envoi     varchar(20) default '',               -- Fax de l'interlocuteur d'envoi
  Email_Inter_Envoi   varchar(64) default '',               -- Email de l'interlocuteur d'envoi
  Mode_Envoi_Avoir    char(1) default 'C',                  -- Mode d'envoi de l'avoir (C=Courrier,F=Fax,M=Mail)
  Date_Envoi          bigint unsigned default 0,            -- Date d'envoi de l'avoir
  Vers_Calc           tinyint unsigned default 2,           -- Version de calcul de document
  Secteur_Activite    int unsigned default null,            -- Secteur d'activité
  primary key (Avoir_Id),
  index idx_code_tva_port (Code_TVA_Port),
  index idx_secteur_activite (Secteur_Activite),
  index idx_client_id (Client_Id),
  constraint cfk_avoir_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_avoir_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_avoir_code_tva_port foreign key (Code_TVA_Port) references TAUX_TVA (Code_TVA)
) engine=InnoDB;


create table LIGNE_AVOIR (
  Ligne_Id            int unsigned not null auto_increment, -- Identifiant de la ligne d'avoir
  Avoir_Id            int unsigned not null,                -- Identifiant avoir
  Ref_Ligne           int unsigned default null,            -- Ligne correspondante dans la commande client
  Rank                int unsigned not null,                -- Numéro d'ordre dans l'avoir
  Reference           varchar(40),                          -- Code article
  Type_Ligne          char(1) default 'I',                  -- Type de la ligne (S=Stock,I=Indépendante)
  Designation         varchar(100),                         -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,     -- Quantité
  Prix                decimal(14,4),                        -- Prix unitaire HT de l'article
  Ristourne           decimal(5,2) unsigned,                -- Taux de ristourne
  Code_TVA            int unsigned default 1,               -- Code TVA
  Taux_TVA            decimal(4,2) unsigned,                -- Taux de TVA
  Commentaire         text,                                 -- Commentaire bas associé à la ligne
  Commentaire_Avant   text,                                 -- Commentaire haut associé à la ligne
  Libelle             varchar(20) default '',               -- Libelle supplémentaire
  Code_Stats          varchar(10) default '',               -- code de statistiques
  Unite               char(3) default 'U',                  -- unité de vente
  Num_Lot             varchar(15) default '',               -- numéro de lot
  Nb_Pieces           int unsigned default 0,               -- nombre de pièces par quantité
  Date_Peremption     bigint unsigned default 0,            -- date de péremption
  Commission          decimal(4,2) unsigned default 0,      -- Taux de commission
  Montant_Ligne       decimal(14,2) unsigned default 0,     -- Montant de la ligne
  Prix_Achat          decimal(14,4) unsigned default 0,     -- Prix d'achat unitaire HT
  Marge_Ligne         decimal(14,2) default 0,              -- Montant de marge HT sur la ligne
  primary key (Ligne_Id),
  index idx_avoir_id (Avoir_Id),
  index idx_code_tva (Code_TVA),
  index idx_ref_ligne (Ref_Ligne),
  constraint cfk_ligne_avoir_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_ligne_avoir_avoir_id foreign key (Avoir_Id) references AVOIR (Avoir_Id),
  constraint cfk_ligne_avoir_ref_ligne foreign key (Ref_Ligne) references LIGNE_COMMANDE_CLIENT (Ligne_Id)
) engine=InnoDB;


create table CODE_PRODUIT_LIGNE_AC (
  Ligne_Id            int unsigned not null,                -- Identifiant de la ligne d'avoir client
  Produit_Id          int unsigned not null,                -- Identifiant du code produit
  primary key (Ligne_Id, Produit_Id),
  constraint cfk_code_produit_ligne_ac_produit_id foreign key (Produit_Id) references CODE_PRODUIT (Produit_Id),
  constraint cfk_code_produit_ligne_ac_ligne_id foreign key (Ligne_Id) references LIGNE_AVOIR (Ligne_Id)
) engine=InnoDB;


create table FACTURE_AVOIR (
  Facture_Id          int unsigned not null,                -- identifiant facture
  Avoir_Id            int unsigned not null,                -- identifiant avoir
  primary key (Facture_Id, Avoir_Id),
  constraint cfk_facture_avoir_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id),
  constraint cfk_facture_avoir_avoir_id foreign key (Avoir_Id) references AVOIR (Avoir_Id)
) engine=InnoDB;


create table BON_LIVRAISON_FACTURE (
  Bon_Id              int unsigned not null,                -- Identifiant du bon de livraison
  Facture_Id          int unsigned not null,                -- Identifiant de la facture client
  primary key (Bon_Id, Facture_Id),
  constraint cfk_bon_livraison_facture_bon_id foreign key (Bon_Id) references BON_LIVRAISON (Bon_Id),
  constraint cfk_bon_livraison_facture_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id)
) engine=InnoDB;


create table PROFORMA (
  Proforma_Id         int unsigned not null auto_increment, -- Identifiant proforma
  Date_Proforma       bigint unsigned default 0,            -- Date du proforma
  Echeance            bigint unsigned default 0,            -- Date d'échéance de paiement
  Mode_Reg_Id         int unsigned default null,            -- Mode de règlement
  Numero              int unsigned default 0,               -- Numéro de proforma
  Num_Entier          varchar(10) default '',               -- Numéro sous sa forme intégrale
  Commentaires_Fin    text,                                 -- Commentaires de fin de proforma
  Nom_Resp            varchar(30) default '',               -- Nom du responsable
  Prenom_Resp         varchar(20) default '',               -- Prénom du responsable
  Civ_Inter           tinyint unsigned default 0,           -- Civilité de l'interlocuteur
  Nom_Inter           varchar(30) default '',               -- Nom de l'interlocuteur
  Prenom_Inter        varchar(20) default '',               -- Prénom de l'interlocuteur
  Tel_Inter           varchar(20) default '',
  Fax_Inter           varchar(20) default '',
  Email_Inter         varchar(64) default '',
  Client_Id           char(10) default null,                -- Code client
  Denomination        varchar(50) default '',               -- Raison sociale
  Adresse_1           varchar(80) default '',               -- Ligne d'adresse 1 de facturation
  Adresse_2           varchar(50) default '',               -- Ligne d'adresse 2 de facturation
  Adresse_3           varchar(50) default '',               -- Ligne d'adresse 3 de facturation
  Code_Postal         varchar(10) default '',               -- Code postal de facturation
  Ville               varchar(50) default '',               -- Ville de facturation
  Code_Pays           char(2) default 'FR',                 -- Code pays
  Date_C              bigint unsigned default 0,            -- date de création
  Util_C              int not null,                         -- utilisateur créateur de la proforma
  Util_R              int default null,                     -- utilisateur responsable de la proforma
  Old_Acompte         decimal(14,2) unsigned default 0,     -- OBSOLETE - Montant d'acompte TTC
  Remise              decimal(9,6) unsigned default 0,      -- Pourcentage de remise
  PRemise_FP          decimal(9,6) unsigned default 0,      -- Pourcentage de remise sur frais de port
  Escompte            decimal(6,3) unsigned default 0,      -- Pourcentage d'escompte
  Frais_Port          decimal(10,2) unsigned default 0,     -- Montant HT des frais de port
  Total_HT            decimal(14,2) unsigned default 0,     -- Total HT du proforma
  Total_TTC           decimal(14,2) unsigned default 0,     -- Montant TTC du proforma
  Taux_TVA_Port       decimal(4,2) unsigned default 0,      -- Taux de TVA des frais de port
  Code_TVA_Port       int unsigned not null,                -- Code de TVA des frais de port
  Edition_TTC         tinyint unsigned default 0,           -- 1 si le proforma est éditée en ttc
  Eco_Taxe            decimal(10,2) default 0,              -- Montant HT de l'eco-participation dans le proforma
  Assujetti_TVA       tinyint unsigned default 0,           -- Assujetti à la TVA (1=oui,0=non)
  Num_TVA_Intra       varchar(14) default '',               -- Numéro de TVA intracommunautaire
  Denomination_Liv    varchar(50) default '',               -- Denomination de livraison
  Adresse_1_Liv       varchar(80) default '',               -- Ligne d'adresse 1 de livraison
  Adresse_2_Liv       varchar(50) default '',               -- Ligne d'adresse 2 de livraison
  Adresse_3_Liv       varchar(50) default '',               -- Ligne d'adresse 3 de livraison
  Code_Postal_Liv     varchar(10) default '',               -- Code postal de livraison
  Ville_Liv           varchar(50) default '',               -- Ville de livraison
  Code_Pays_Liv       char(2) default 'FR',                 -- Code pays de livraison
  Civ_Inter_Liv       tinyint unsigned default 0,           -- Civilité de l'interlocuteur de livraison
  Nom_Inter_Liv       varchar(30) default '',               -- Nom de l'interlocuteur de livraison
  Prenom_Inter_Liv    varchar(30) default '',               -- Prénom de l'interlocuteur de livraison
  Tel_Inter_Liv       varchar(20) default '',               -- Téléphone de l'interlocuteur de livraison
  Fax_Inter_Liv       varchar(20) default '',               -- Fax de l'interlocuteur de livraison
  Email_Inter_Liv     varchar(64) default '',               -- E-Mail de l'interlocuteur de livraison
  Mentions            text,                                 -- Mentions
  Regime_TVA          char(1) default 'G',                  -- Régime TVA (G=général, T=forcer la TVA, E=exonération)
  Denomination_Envoi  varchar(50) default '',               -- Dénomination d'envoi de la proforma
  Adresse_1_Envoi     varchar(80) default '',               -- Ligne d'adresse 1 d'envoi de la proforma
  Adresse_2_Envoi     varchar(50) default '',               -- Ligne d'adresse 2 d'envoi de la proforma
  Adresse_3_Envoi     varchar(50) default '',               -- Ligne d'adresse 3 d'envoi de la proforma
  Code_Postal_Envoi   varchar(10) default '',               -- Code postal d'envoi de la proforma
  Ville_Envoi         varchar(50) default '',               -- Ville d'envoi de la proforma
  Code_Pays_Envoi     char(2) default 'FR',                 -- Code pays d'envoi de la proforma
  Civ_Inter_Envoi     tinyint unsigned default 0,           -- Civilité de l'interlocuteur d'envoi
  Nom_Inter_Envoi     varchar(30) default '',               -- Nom de l'interlocuteur d'envoi
  Prenom_Inter_Envoi  varchar(30) default '',               -- Prénom de l'interlocuteur d'envoi
  Tel_Inter_Envoi     varchar(20) default '',               -- Téléphone de l'interlocuteur d'envoi
  Fax_Inter_Envoi     varchar(20) default '',               -- Fax de l'interlocuteur d'envoi
  Email_Inter_Envoi   varchar(64) default '',               -- Email de l'interlocuteur d'envoi
  Vers_Calc           tinyint unsigned default 2,           -- Version de calcul de document
  primary key (Proforma_Id),
  index idx_code_tva_port (Code_TVA_Port),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_client_id (Client_Id),
  constraint cfk_proforma_code_tva_port foreign key (Code_TVA_Port) references TAUX_TVA (Code_TVA),
  constraint cfk_proforma_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_proforma_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;


create table LIGNE_PROFORMA (
  Ligne_Id            int unsigned not null auto_increment, -- Identifiant de la ligne de proforma
  Proforma_Id         int unsigned not null,                -- Identifiant proforma
  Rank                int unsigned not null,                -- Numéro d'ordre dans le proforma
  Reference           varchar(40) default '',               -- Code article
  Type_Ligne          char(1) default 'I',                  -- Type de la ligne (S=Stock,I=Indépendante)
  Designation         varchar(100) default '',              -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,     -- Quantité
  Prix                decimal(14,4) unsigned default 0,     -- Prix unitaire HT de l'article
  Ristourne           decimal(5,2) unsigned default 0,      -- Taux de ristourne
  Taux_TVA            decimal(4,2) unsigned default 0,      -- Taux de TVA
  Code_TVA            int unsigned default 1,               -- Code de TVA
  Commentaire         text,                                 -- Commentaire bas associé à la ligne
  Commentaire_Avant   text,                                 -- Commentaire haut associé à la ligne
  Libelle             varchar(20) default '',               -- Libelle supplémentaire
  Unite               char(3) default 'U',                  -- unité de vente
  Num_Lot             varchar(15) default '',               -- numéro de lot
  Nb_Pieces           int unsigned default 0,               -- nombre de pièces par quantité
  Date_Peremption     bigint unsigned default 0,            -- date de péremption
  Commission          decimal(4,2) unsigned default 0,      -- Taux de commission
  Montant_Ligne       decimal(14,2) unsigned default 0,     -- Montant de la ligne
  primary key (Ligne_Id),
  index idx_code_tva (Code_TVA),
  index idx_proforma_id (Proforma_Id),
  constraint cfk_ligne_proforma_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_ligne_proforma_proforma_id foreign key (Proforma_Id) references PROFORMA (Proforma_Id)
) engine=InnoDB;


create table PROFORMA_DEVIS (
  Proforma_Id         int unsigned not null,    -- Identifiant de la proforma
  Devis_Id            int unsigned not null,    -- Identifiant du devis
  primary key (Proforma_Id, Devis_Id),
  constraint cfk_proforma_devis_proforma_id foreign key (Proforma_Id) references PROFORMA (Proforma_Id),
  constraint cfk_proforma_devis_devis_id foreign key (Devis_Id) references DEVIS (Devis_Id)
) engine=InnoDB;


create table PROFORMA_FACTURE_CLIENT (
  Proforma_Id         int unsigned not null,    -- Identifiant de la proforma
  Facture_Id          int unsigned not null,    -- Identifiant de la facture client
  primary key (Proforma_Id, Facture_Id),
  constraint cfk_proforma_facture_client_proforma_id foreign key (Proforma_Id) references PROFORMA (Proforma_Id),
  constraint cfk_proforma_facture_client_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id)
) engine=InnoDB;


create table PROFORMA_COMMANDE_CLIENT (
  Proforma_Id         int unsigned not null,    -- Identifiant de la proforma
  Commande_Id         int unsigned not null,    -- identifiant de la commande client
  primary key (Proforma_Id, Commande_Id),
  constraint cfk_proforma_commande_client_proforma_id foreign key (Proforma_Id) references PROFORMA (Proforma_Id),
  constraint cfk_proforma_commande_client_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id)
) engine=InnoDB;


create table PROFORMA_ACOMPTE_CLIENT (
  Proforma_Id         int unsigned not null,    -- Identifiant de la proforma
  Acompte_Id          int unsigned not null,    -- Identifiant de l'acompte client
  primary key (Proforma_Id, Acompte_Id),
  constraint cfk_proforma_acompte_client_proforma_id foreign key (Proforma_Id) references PROFORMA (Proforma_Id),
  constraint cfk_proforma_acompte_client_acompte_id foreign key (Acompte_Id) references ACOMPTE_CLIENT (Acompte_Id)
) engine=InnoDB;


-- ----------------- LISTES DIVERSES ----------------------------------------------


create table COMPTE_FAMILLE_ARTICLE (
  Famille_Id         int unsigned not null,       -- Identifiant de la famille d'article
  Code_TVA           int unsigned not null,       -- Code TVA
  Compte_Vente       char(8) default null,        -- Compte de vente
  Compte_Achat       char(8) default null,        -- Compte d'achat
  primary key (Famille_Id, Code_TVA),
  index idx_compte_vente (Compte_Vente),
  index idx_compte_achat (Compte_Achat),
  constraint cfk_compte_famille_article_famille_id foreign key (Famille_Id) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_compte_famille_article_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_compte_famille_article_compte_vente foreign key (Compte_Vente) references COMPTE (Numero_Compte),
  constraint cfk_compte_famille_article_compte_achat foreign key (Compte_Achat) references COMPTE (Numero_Compte)
) engine=InnoDB;


create table COMPTE_FAMILLE_ARTICLE_TVA_NATIONAL_UE (
  Famille_Id       int unsigned not null,         -- Identifiant de la famille d'article
  Code_TVA         int unsigned not null,         -- Code TVA d'un taux francais > 0
  Code_Pays        char(2) not null,              -- Code pays de l'UE (hors France)
  Compte_Vente     char(8) not null,              -- Numéro de compte de vente
  primary key (Famille_Id, Code_TVA, Code_Pays),
  index idx_compte_vente (Compte_Vente),
  constraint cfk_compte_famille_article_tva_national_ue_famille_id foreign key (Famille_Id) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_compte_famille_article_tva_national_ue_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_compte_famille_article_tva_national_ue_compte_vente foreign key (Compte_Vente) references COMPTE (Numero_Compte)
) engine=InnoDB;


-- ---------------- SUIVI DES REGLEMENTS CLIENTS -------------------------------------------


create table ECHEANCE_CLIENT (
  Echeance_Id         int unsigned not null auto_increment,  -- Identifiant de l'échéance
  Date_Echeance       bigint unsigned default 0,             -- Date d'échéance effective
  Echeance_Initiale   bigint unsigned default 0,             -- Date d'échéance initiale
  Client_Id           char(10) default null,                 -- Identifiant client
  Denomination        varchar(50) default '',                -- Dénomination client
  Montant             decimal(14,2) unsigned default 0,      -- Montant de l'échéance
  Montant_Restant     decimal(14,2) unsigned default 0,      -- Montant restant dû
  Mode_Reg_Id         int unsigned not null,                 -- Mode de règlement initial
  Etat                char(1) default 'N',                   -- Etat de l'échéance (N=Non imputée,P=imputée Partiellement,T=imputée Totalement)
  Commentaires        varchar(100) default '',               -- Commentaires sur l'échéance
  primary key (Echeance_Id),
  index idx_client_id (Client_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  constraint cfk_echeance_client_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id),
  constraint cfk_echeance_client_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade
) engine=InnoDB;


create table FACTURE_ECHEANCE_CLIENT (
  Echeance_Id         int unsigned not null,     -- Identifiant de l'échéance client
  Facture_Id          int unsigned not null,     -- Identifiant de la facture client
  primary key (Echeance_Id, Facture_Id),
  constraint cfk_facture_echeance_client_echeance_id foreign key (Echeance_Id) references ECHEANCE_CLIENT (Echeance_Id),
  constraint cfk_facture_echeance_client_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id)
) engine=InnoDB;


create table ACOMPTE_ECHEANCE_CLIENT (
  Echeance_Id         int unsigned not null,     -- Identifiant de l'échéance client
  Acompte_Id          int unsigned not null,     -- Identifiant de l'acompte client
  primary key (Echeance_Id, Acompte_Id),
  constraint cfk_acompte_echeance_client_echeance_id foreign key (Echeance_Id) references ECHEANCE_CLIENT (Echeance_Id),
  constraint cfk_acompte_echeance_client_acompte_id foreign key (Acompte_Id) references ACOMPTE_CLIENT (Acompte_Id)
) engine=InnoDB;


create table REMISE_BANQUE (
  Remise_Id           int unsigned not null auto_increment,  -- Identifiant de la remise en banque
  Numero              char(9) default '',                    -- Numéro de la remise en banque (Ryymm0000)
  Date_Remise         bigint unsigned default 0,             -- Date de la remise en banque
  Banque_Remise       int unsigned not null,                 -- Identifiant de la banque de remise
  Etat                char(1) default 'V',                   -- Etat de la remise (V=Validée, A=Annulée)
  Type_Reg_Id         int unsigned not null,                 -- Type de règlement
  Comptabilise        tinyint unsigned default 0,            -- Comptabilisé (oui/non)
  Compta_Annul        tinyint unsigned default 0,            -- Annulé en comptabilité (oui/non)
  Date_Annul          bigint unsigned default 0,             -- Date d'annulation
  Montant             decimal(14,2) unsigned default 0,      -- Montant de la remise en banque
  primary key (Remise_Id),
  index idx_banque_remise (Banque_Remise),
  index idx_type_reg (Type_Reg_Id),
  constraint cfk_remise_banque_banque_remise foreign key (Banque_Remise) references BANQUE (Banque_Id),
  constraint cfk_remise_banque_type_reg_id foreign key (Type_Reg_Id) references TYPE_REGLEMENT (Type_Reg_Id)
) engine=InnoDB;


create table REGLEMENT_CLIENT (
  Reglement_Id        int unsigned not null auto_increment,  -- Identifiant du règlement
  Date_Reg            bigint unsigned default 0,             -- Date du règlement
  Mode_Reg_Id         int unsigned not null,                 -- Mode de règlement effectif
  Client_Id           char(10) default null,                 -- Identifiant client
  Denomination        varchar(50) default '',                -- Dénomination client
  Banque_Remise       int unsigned default null,             -- Banque de remise
  Num_Piece           varchar(20) default '',                -- Numéro de pièce
  Banque_Client       varchar(30) default '',                -- Banque émettrice du règlement
  Montant             decimal(14,2) unsigned default 0,      -- Montant du règlement
  Montant_Restant     decimal(14,2) unsigned default 0,      -- Montant restant à imputer
  Etat                char(1) default 'N',                   -- Etat de l'imputation du règlement (N=Non imputée,P=imputée Partiellement,T=imputée Totalement)
  Statut              char(1) default 'V',                   -- Statut du règlement (V=Valide,A=Annulé,C=règlement anticipé sur Commande)
  Compta_Enc          tinyint unsigned default 0,            -- Comptabilisé en encaissement (oui/non)
  Compta_Annul        tinyint unsigned default 0,            -- Annulé en comptabilité (oui/non)
  Echeance_Remise     bigint unsigned default 0,             -- Date d'échéance de remise en banque
  Commentaires        varchar(100) default '',               -- Commentaires sur le règlement
  Commande_Id         int unsigned default null,             -- Identifiant de la commande client en cas de règlement anticipé uniquement
  primary key (Reglement_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_client_id (Client_Id),
  index idx_banque_remise (Banque_Remise),
  index idx_commande_id (Commande_Id),
  constraint cfk_reglement_client_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id),
  constraint cfk_reglement_client_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_reglement_client_banque_remise foreign key (Banque_Remise) references BANQUE (Banque_Id),
  constraint cfk_reglement_client_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id)
) engine=InnoDB;


create table REMISE_REGLEMENT_CLIENT (
  Remise_Id           int unsigned not null,                 -- Identifiant de la remise en banque
  Reglement_Id        int unsigned not null,                 -- Identifiant du règlement
  primary key (Remise_Id, Reglement_Id),
  constraint cfk_remise_reglement_client_remise_id foreign key (Remise_Id) references REMISE_BANQUE (Remise_Id),
  constraint cfk_remise_reglement_client_reglement_id foreign key (Reglement_Id) references REGLEMENT_CLIENT (Reglement_Id)
) engine=InnoDB;


create table LIGNE_REMISE_ESPECE (
  Remise_Id          int unsigned not null,                  -- Identifiant de la remise en banque
  Monnaie_Id         int unsigned not null,                  -- Identifiant de la monnaie
  Quantite           int unsigned default 0,                 -- Quantité de monnaie remise
  primary key (Remise_Id, Monnaie_Id),
  constraint cfk_ligne_remise_espece_remise_id foreign key (Remise_Id) references REMISE_BANQUE (Remise_Id)
) engine=InnoDB;


create table IMPUTATION_ECHEANCE_CLIENT (
  Imputation_Id          int unsigned not null auto_increment,  -- Identifiant de l'imputation
  Echeance_Id            int unsigned not null,                 -- Identifiant de l'échéance
  Montant                decimal(14,2) unsigned default 0,      -- Montant imputé à l'échéance
  Date_Imputation        bigint unsigned default 0,             -- Date d'imputation
  primary key (Imputation_Id),
  index idx_echeance_id (Echeance_Id),
  constraint cfk_imputation_echeance_client_echeance_id foreign key (Echeance_Id) references ECHEANCE_CLIENT (Echeance_Id)
) engine=InnoDB;


create table IMPUTATION_ECHEANCE_AVOIR_CLIENT (
  Imputation_Id          int unsigned not null,                 -- Identifiant de l'imputation
  Avoir_Id               int unsigned not null,                 -- Identifiant de l'avoir
  primary key (Imputation_Id, Avoir_Id),
  constraint cfk_imputation_echeance_avoir_client_imputation_id foreign key (Imputation_Id) references IMPUTATION_ECHEANCE_CLIENT (Imputation_Id),
  constraint cfk_imputation_echeance_avoir_client_avoir_id foreign key (Avoir_Id) references AVOIR (Avoir_Id)
) engine=InnoDB;


create table IMPUTATION_ECHEANCE_REGLEMENT_CLIENT (
  Imputation_Id          int unsigned not null,                 -- Identifiant de l'imputation
  Reglement_Id           int unsigned not null,                 -- Identifiant du règlement
  primary key (Imputation_Id, Reglement_Id),
  constraint cfk_imputation_echeance_reglement_client_imputation_id foreign key (Imputation_Id) references IMPUTATION_ECHEANCE_CLIENT (Imputation_Id),
  constraint cfk_imputation_echeance_reglement_client_reglement_id foreign key (Reglement_Id) references REGLEMENT_CLIENT (Reglement_Id)
) engine=InnoDB;


create table REGULARISATION_ECHEANCE_CLIENT (
  Regularisation_Id      int unsigned not null auto_increment,  -- Identifiant de la régularisation
  Imputation_Id          int unsigned not null,                 -- Identifiant de l'imputation
  Montant                decimal(14,2) unsigned default 0,      -- Montant de la régularisation
  Comptabilise           tinyint unsigned default 0,            -- Transféré en comptabilité
  Date_Regul             bigint unsigned default 0,             -- Date de la régularisation
  Date_Annul             bigint unsigned default 0,             -- Date d'annulation
  Compta_Annul           tinyint unsigned default 0,            -- Annulé en comptabilité
  primary key (Regularisation_Id),
  index idx_imputation_id (Imputation_Id),
  constraint cfk_regularisation_echeance_client_imputation_id foreign key (Imputation_Id) references IMPUTATION_ECHEANCE_CLIENT (Imputation_Id)
) engine=InnoDB;


create table MOTIF_REMBOURSEMENT (
  Motif_Id               int unsigned not null auto_increment,  -- Identifiant du motif
  Libelle                varchar(25) default '',                -- Libellé du motif
  Actif                  tinyint unsigned default 1,            -- Valeur active (oui/non)
  primary key (Motif_Id),
  unique (Libelle)
) engine=InnoDB;


create table REMBOURSEMENT_CLIENT (
  Remboursement_Id       int unsigned not null auto_increment,  -- Identifiant du remboursement
  Date_Remboursement     bigint unsigned default 0,             -- Date du remboursement
  Montant                decimal(14,2) unsigned default 0,      -- Montant du remboursement
  Montant_Restant        decimal(14,2) unsigned default 0,      -- Montant restant à imputer
  Etat                   char(1) default 'N',                   -- Etat de l'imputation du remboursement (N=Non imputée,P=imputée Partiellement,T=imputée Totalement)
  Statut                 char(1) default 'V',                   -- Statut du remboursement (V=Valide,A=Annulé)
  Comptabilise           tinyint unsigned default 0,            -- Transféré en comptabilité (oui/non)
  Compta_Annul           tinyint unsigned default 0,            -- Annulé en comptabilité (oui/non)
  Banque_Retrait         int unsigned default null,             -- Banque de retrait
  Mode_Reg_Id            int unsigned default null,             -- Mode de règlement
  Client_Id              char(10) default null,                 -- Identifiant client
  Denomination           varchar(50) default '',                -- Dénomination client
  Num_Piece              varchar(20) default '',                -- Numéro de pièce
  Commentaires           varchar(100) default '',               -- Commentaires sur le remboursement
  Motif                  int unsigned not null,                 -- Motif de remboursement
  primary key (Remboursement_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_client_id (Client_Id),
  index idx_banque_retrait (Banque_Retrait),
  index idx_motif (Motif),
  constraint cfk_remboursement_client_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id),
  constraint cfk_remboursement_client_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_remboursement_client_banque_retrait foreign key (Banque_Retrait) references BANQUE (Banque_Id),
  constraint cfk_remboursement_client_motif foreign key (Motif) references MOTIF_REMBOURSEMENT (Motif_Id)
) engine=InnoDB;


create table IMPUTATION_AVOIR_CLIENT (
  Imputation_Id          int unsigned not null auto_increment,  -- Identifiant de l'imputation
  Avoir_Id               int unsigned not null,                 -- Identifiant de l'avoir
  Montant                decimal(14,2) unsigned default 0,      -- Montant imputé à l'avoir
  Date_Imputation        bigint unsigned default 0,             -- Date d'imputation
  primary key (Imputation_Id),
  index idx_avoir_id (Avoir_Id),
  constraint cfk_imputation_avoir_client_avoir_id foreign key (Avoir_Id) references AVOIR (Avoir_Id)
) engine=InnoDB;


create table IMPUTATION_REGLEMENT_CLIENT (
  Imputation_Id          int unsigned not null auto_increment,  -- Identifiant de l'imputation
  Reglement_Id           int unsigned not null,                 -- Identifiant du règlement
  Montant                decimal(14,2) unsigned default 0,      -- Montant imputé au règlement
  Date_Imputation        bigint unsigned default 0,             -- Date d'imputation
  primary key (Imputation_Id),
  index idx_reglement_id (Reglement_Id),
  constraint cfk_imputation_reglement_client_reglement_id foreign key (Reglement_Id) references REGLEMENT_CLIENT (Reglement_Id)
) engine=InnoDB;


create table IMPUTATION_AVOIR_REMBOURSEMENT_CLIENT (
  Imputation_Id          int unsigned not null,                 -- Identifiant de l'imputation
  Remboursement_Id       int unsigned not null,                 -- Identifiant du remboursement
  primary key (Imputation_Id, Remboursement_Id),
  constraint cfk_imputation_avoir_remboursement_client_imputation_id foreign key (Imputation_Id) references IMPUTATION_AVOIR_CLIENT (Imputation_Id),
  constraint cfk_imputation_avoir_remboursement_client_remboursement_id foreign key (Remboursement_Id) references REMBOURSEMENT_CLIENT (Remboursement_Id)
) engine=InnoDB;


create table IMPUTATION_REGLEMENT_REMBOURSEMENT_CLIENT (
  Imputation_Id          int unsigned not null,                 -- Identifiant de l'imputation
  Remboursement_Id       int unsigned not null,                 -- Identifiant du remboursement
  primary key (Imputation_Id, Remboursement_Id),
  constraint cfk_imputation_reglement_remboursement_client_imputation_id foreign key (Imputation_Id) references IMPUTATION_REGLEMENT_CLIENT (Imputation_Id),
  constraint cfk_imputation_reglement_remboursement_client_remboursement_id foreign key (Remboursement_Id) references REMBOURSEMENT_CLIENT (Remboursement_Id)
) engine=InnoDB;


create table REGULARISATION_REGLEMENT_CLIENT (
  Regularisation_Id      int unsigned not null auto_increment,  -- Identifiant de la régularisation
  Imputation_Id          int unsigned not null,                 -- Identifiant de l'imputation
  Montant                decimal(14,2) unsigned default 0,      -- Montant de la régularisation
  Comptabilise           tinyint unsigned default 0,            -- Transféré en comptabilité
  Date_Regul             bigint unsigned default 0,             -- Date de la régularisation
  Date_Annul             bigint unsigned default 0,             -- Date d'annulation
  Compta_Annul           tinyint unsigned default 0,            -- Annulé en comptabilité
  primary key (Regularisation_Id),
  index idx_imputation_id (Imputation_Id),
  constraint cfk_regularisation_reglement_client_imputation_id foreign key (Imputation_Id) references IMPUTATION_REGLEMENT_CLIENT (Imputation_Id)
) engine=InnoDB;


create table REGULARISATION_AVOIR_CLIENT (
  Regularisation_Id      int unsigned not null auto_increment,  -- Identifiant de la régularisation
  Imputation_Id          int unsigned not null,                 -- Identifiant de l'imputation
  Montant                decimal(14,2) unsigned default 0,      -- Montant de la régularisation
  Comptabilise           tinyint unsigned default 0,            -- Transféré en comptabilité
  Date_Regul             bigint unsigned default 0,             -- Date de la régularisation
  Date_Annul             bigint unsigned default 0,             -- Date d'annulation
  Compta_Annul           tinyint unsigned default 0,            -- Annulé en comptabilité
  primary key (Regularisation_Id),
  index idx_imputation_id (Imputation_Id),
  constraint cfk_regularisation_avoir_client_imputation_id foreign key (Imputation_Id) references IMPUTATION_AVOIR_CLIENT (Imputation_Id)
) engine=InnoDB;




-- Historique des relances à revoir.... + insérer un numéro de relance ?

create table RELANCE (
  Echeance_Id         int unsigned not null,          -- Identifiant de l'échéance
  Date_Relance        bigint unsigned default 0,      -- Date de la relance
  primary key (Echeance_Id, Date_Relance),
  constraint cfk_relance_echeance_id foreign key (Echeance_Id) references ECHEANCE_CLIENT (Echeance_Id)
) engine=InnoDB;



-- ---------------- FACTURES ET AVOIRS FOURNISSEURS -------------------------------------------


create table FACTURE_FOURNISSEUR (
  Facture_Id          int unsigned not null auto_increment,  -- Identifiant facture
  Date_Facture        bigint unsigned default 0,             -- Date de la facture
  Numero              varchar(20) default '',                -- Numéro de facture
  Statut              char(1) default 'N',                   -- Statut de la facture (N=Non validée,V=Validée)
  Commentaires_Fin    text,                                  -- Commentaires de fin de commande
  Commentaires_Int    text,                                  -- Commentaires internes non imprimables
  Commentaires_Hid    text,                                  -- Commentaires internes cachés
  Nom_Resp            varchar(30) default '',                -- Nom du responsable
  Prenom_Resp         varchar(20) default '',                -- Prénom du responsable
  Civ_Inter           tinyint unsigned default 0,            -- Civilité de l'interlocuteur
  Nom_Inter           varchar(30) default '',                -- Nom de l'interlocuteur
  Prenom_Inter        varchar(20) default '',                -- Prénom de l'interlocuteur
  Tel_Inter           varchar(20) default '',
  Fax_Inter           varchar(20) default '',
  Email_Inter         varchar(64) default '',
  Fournisseur_Id      char(10) default null,                 -- Code fournisseur
  Denomination        varchar(50) default '',                -- Raison sociale
  Adresse_1           varchar(80) default '',                -- Ligne d'adresse 1 de facturation
  Adresse_2           varchar(50) default '',                -- Ligne d'adresse 2 de facturation
  Adresse_3           varchar(50) default '',                -- Ligne d'adresse 3 de facturation
  Code_Postal         varchar(10) default '',                -- Code postal de facturation
  Ville               varchar(50) default '',                -- Ville de facturation
  Code_Pays           char(2) default 'FR',                  -- Code pays
  Date_C              bigint unsigned default 0,             -- date de création
  Date_M              bigint unsigned default 0,             -- date de mise à jour
  Util_C              int not null,                          -- utilisateur créateur de la facture
  Util_M              int not null,                          -- utilisateur ayant fait la dernière modification de la facture
  Util_R              int default null,                      -- utilisateur responsable de la facture
  Remise              decimal(5,2) unsigned default 0,       -- Pourcentage de remise
  MRemise             decimal(9,2) unsigned default 0,       -- Montant de remise uniquement si remise en montant sinon 0
  PRemise_FP          decimal(9,6) unsigned default 0,       -- Pourcentage de remise sur frais de port
  MRemise_FP          decimal(9,2) unsigned default 0,       -- Montant de remise sur frais de port uniquement si remise en montant sinon 0
  Escompte            decimal(5,2) unsigned default 0,       -- Pourcentage d'escompte
  Frais_Port          decimal(10,2) unsigned default 0,      -- Montant HT des frais de port
  Total_HT            decimal(14,2) unsigned default 0,      -- Total HT de la facture
  Total_TTC           decimal(14,2) unsigned default 0,      -- Montant TTC de la facture
  Transferee          tinyint unsigned default 0,            -- 1 si facture transférée en compta
  Taux_TVA_Port       decimal(4,2) unsigned default 0,       -- Taux de TVA des frais de port
  Code_TVA_Port       int unsigned not null,                 -- Code de TVA des frais de port
  Mentions            text,                                  -- Mentions
  Vers_Calc           tinyint unsigned default 2,            -- Version de calcul de document
  Secteur_Activite    int unsigned default null,             -- Secteur d'activité
  Statut_Paiement     char(1) default 'N',                   -- Statut du paiement (N=Non payé, P=Partiellement payé, T=Totalement payé)
  primary key (Facture_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  index idx_code_tva_port (Code_TVA_Port),
  index idx_secteur_activite (Secteur_Activite),
  constraint cfk_facture_fournisseur_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_facture_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade,
  constraint cfk_facture_fournisseur_code_tva_port foreign key (Code_TVA_Port) references TAUX_TVA (Code_TVA)
) engine=InnoDB;


create table LIGNE_FACTURE_FOURNISSEUR (
  Ligne_Id            int unsigned not null auto_increment, -- Identifiant de la ligne
  Facture_Id          int unsigned not null,                -- Identifiant facture
  Ref_Ligne           int unsigned default null,            -- Ligne correspondante dans la commande fournisseur
  Rank                int unsigned not null,                -- Numéro d'ordre dans la facture
  Reference           varchar(40) default '',               -- Code article
  Ref_Fournisseur     varchar(40) default '',               -- Référence article chez le fournisseur
  Type_Ligne          char(1) default 'I',                  -- Type de la ligne (S=Stock,I=Indépendante)
  Designation         varchar(100) default '',              -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,     -- Quantité
  Prix                decimal(14,4) unsigned default 0,     -- Prix unitaire HT de l'article
  Ristourne           decimal(5,2) unsigned default 0,      -- Taux de ristourne
  Taux_TVA            decimal(4,2) unsigned default 0,      -- Taux de TVA
  Code_TVA            int unsigned default 1,               -- Code de TVA
  Commentaire         text,                                 -- Commentaire bas associé à la ligne
  Commentaire_Avant   text,                                 -- Commentaire haut associé à la ligne
  Num_Lot             varchar(15) default '',               -- numéro de lot
  Nb_Pieces           int unsigned default 0,               -- nombre de pièces par quantité
  Date_Peremption     bigint unsigned default 0,            -- date de péremption
  Unite               char(3) default 'U',                  -- unité de vente
  Montant_Ligne       decimal(14,2) unsigned default 0,     -- Montant de la ligne
  primary key (Ligne_Id),
  index idx_code_tva (Code_TVA),
  index idx_facture_id (Facture_Id),
  index idx_ref_ligne (Ref_Ligne),
  constraint cfk_ligne_facture_fournisseur_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_ligne_facture_fournisseur_facture_id foreign key (Facture_Id) references FACTURE_FOURNISSEUR (Facture_Id),
  constraint cfk_ligne_facture_fournisseur_ref_ligne foreign key (Ref_Ligne) references LIGNE_COMMANDE_FOURNISSEUR (Ligne_Id)
) engine=InnoDB;


create table ECHEANCE_FACTURE_FOURNISSEUR (
  Echeance_Id         int not null auto_increment,           -- Identifiant de l'échéance
  Facture_Id          int unsigned not null,                 -- Identifiant de la facture
  Mode_Reg_Id         int unsigned default null,             -- Mode de règlement de l'échéance
  Date_Echeance       bigint unsigned default 0,             -- Date d'échéance
  Montant             decimal(14,2) unsigned default 0,      -- Montant de l'échéance
  primary key (Echeance_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_facture_id (Facture_Id),
  constraint cfk_echeance_facture_fournisseur_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id),
  constraint cfk_echeance_facture_fournisseur_facture_id foreign key (Facture_Id) references FACTURE_FOURNISSEUR (Facture_Id)
) engine=InnoDB;


create table ACOMPTE_FOURNISSEUR (
  Acompte_Id          int not null auto_increment,           -- Identifiant de l'acompte
  Commande_Id         int unsigned not null,                 -- Identifiant de la commande fournisseur
  Statut              char(1) default 'V',                   -- Statut de l'acompte (V=Validé,A=Annulé)
  Date_Acompte        bigint unsigned default 0,             -- Date de l'acompte
  Numero              varchar(12) default '',                -- Numéro de facture
  Libelle             varchar(100) default '',               -- Libellé de l'acompte
  Mode_Reg_Id         int unsigned not null,                 -- Mode de règlement
  Taux_TVA            decimal(4,2) unsigned default 0,       -- Taux de TVA
  Code_TVA            int unsigned not null,                 -- Code de TVA
  Total_HT            decimal(14,2) unsigned default 0,      -- Total HT
  Total_TVA           decimal(14,2) unsigned default 0,      -- Total TVA
  Total_TTC           decimal(14,2) unsigned default 0,      -- Total TTC
  Commentaires_Fin    text,                                  -- Commentaires de fin d'acompte
  Fournisseur_Id      char(10) default null,                 -- Code fournisseur
  Denomination        varchar(50) default '',                -- Dénomination de facturation
  Adresse_1           varchar(80) default '',                -- Ligne d'adresse 1 de facturation
  Adresse_2           varchar(50) default '',                -- Ligne d'adresse 2 de facturation
  Adresse_3           varchar(50) default '',                -- Ligne d'adresse 3 de facturation
  Code_Postal         varchar(10) default '',                -- Code postal de facturation
  Ville               varchar(50) default '',                -- Ville de facturation
  Code_Pays           char(2) default 'FR',                  -- Code pays
  Civ_Inter           tinyint unsigned default 0,            -- Civilié du contact
  Nom_Inter           varchar(30) default '',                -- Nom du contact
  Prenom_Inter        varchar(30) default '',                -- Prénom du contact
  Tel_Inter           varchar(20) default '',                -- Téléphone du contact
  Fax_Inter           varchar(20) default '',                -- Fax du contact
  Email_Inter         varchar(64) default '',                -- Email du contact
  Date_C              bigint unsigned default 0,             -- Date de création
  Date_M              bigint unsigned default 0,             -- Date de dernière modification
  Util_C              int not null,                          -- Utilisateur créateur de l'acompte
  Util_M              int not null,                          -- Utilisateur ayant modifier l'acompte en dernier
  Util_R              int default null,                      -- Utilisateur responsable de la facture
  Comptabilise        tinyint unsigned default 0,            -- Transféré en comptabilité (oui/non)
  Compta_Annul        tinyint unsigned default 0,            -- Annulé en comptabilité (oui/non)
  primary key (Acompte_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  index idx_code_tva (Code_TVA),
  index idx_commande_id (Commande_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  constraint cfk_acompte_fournisseur_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_acompte_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade,
  constraint cfk_acompte_fournisseur_commande_id foreign key (Commande_Id) references COMMANDE_FOURNISSEUR (Commande_Id),
  constraint cfk_acompte_fournisseur_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;


create table COMMANDE_FOURNISSEUR_FACTURE (
  Commande_Id         int unsigned not null,                -- Identifiant commande fournisseur
  Facture_Id          int unsigned not null,                -- Identifiant facture fournisseur
--  Frais_Port          decimal(10,2) unsigned default 0,     -- Montant de frais de port
  primary key (Commande_Id, Facture_Id),
  constraint cfk_commande_fournisseur_facture_commande_id foreign key (Commande_Id) references COMMANDE_FOURNISSEUR (Commande_Id),
  constraint cfk_commande_fournisseur_facture_facture_id foreign key (Facture_Id) references FACTURE_FOURNISSEUR (Facture_Id)
) engine=InnoDB;


create table BON_RECEPTION_FACTURE (
  Bon_Id              int unsigned not null,                -- Identifiant du bon de réception
  Facture_Id          int unsigned not null,                -- Identifiant de la facture fournisseur
  primary key (Bon_Id, Facture_Id),
  constraint cfk_bon_reception_facture_bon_id foreign key (Bon_Id) references BON_RECEPTION (BR_Id),
  constraint cfk_bon_reception_facture_facture_id foreign key (Facture_Id) references FACTURE_FOURNISSEUR (Facture_Id)
) engine=InnoDB;


create table IMPUTATION_ACOMPTE_FACTURE_FOURNISSEUR (
  Acompte_Id          int not null,                          -- Identifiant de l'acompte fournisseur
  Facture_Id          int unsigned not null,                 -- Identifiant de la facture fournisseur
  Montant             decimal(14,2) unsigned default 0,
  primary key (Acompte_Id, Facture_Id),
  constraint cfk_imputation_acompte_facture_fournisseur_facture_id foreign key (Facture_Id) references FACTURE_FOURNISSEUR (Facture_Id),
  constraint cfk_imputation_acompte_facture_fournisseur_acompte_id foreign key (Acompte_Id) references ACOMPTE_FOURNISSEUR (Acompte_Id)
) engine=InnoDB;


create table IMPUTATION_LIGNE_BR_FF (
  Ref_Ligne_BR        int unsigned not null,                -- Ligne du bon de réception
  Ref_Ligne_FF        int unsigned not null,                -- Ligne de la facture fournisseur
  Quantite            decimal(10,3) unsigned default 0,     -- Quantité facturée du BR
  primary key (Ref_Ligne_BR, Ref_Ligne_FF),
  constraint cfk_imputation_ligne_br_ff_ref_ligne_br foreign key (Ref_Ligne_BR) references LIGNE_BON_RECEPTION (Ligne_Id),
  constraint cfk_imputation_ligne_br_ff_ref_ligne_ff foreign key (Ref_Ligne_FF) references LIGNE_FACTURE_FOURNISSEUR (Ligne_Id)
) engine=InnoDB;


create table AVOIR_FOURNISSEUR (
  Avoir_Id              int unsigned not null auto_increment,  -- Identifiant avoir_fournisseur
  Date_Avoir            bigint unsigned default 0,             -- Date de l'avoir
  Numero                char(20) default '',                   -- Numéro de l'avoir
  Statut                char(1) default 'N',                   -- Statut de l'avoir (N=Non validé, V=Validé)
  Commentaires_Fin      text,                                  -- Commentaires de fin de commande
  Commentaires_Int      text,                                  -- Commentaires internes non imprimables
  Commentaires_Hid    text,                                    -- Commentaires internes cachés
  Nom_Resp              varchar(30) default '',                -- Nom du responsable
  Prenom_Resp           varchar(20) default '',                -- Prénom du responsable
  Civ_Inter             tinyint unsigned default 0,            -- Civilité de l'interlocuteur
  Nom_Inter             varchar(30) default '',                -- Nom de l'interlocuteur
  Prenom_Inter          varchar(20) default '',                -- Prénom de l'interlocuteur
  Tel_Inter             varchar(20) default '',                --
  Fax_Inter             varchar(20) default '',                --
  Email_Inter           varchar(64) default '',                --
  Fournisseur_Id        char(10) default null,                 -- Code fournisseur
  Denomination          varchar(50) default '',                -- Raison sociale
  Adresse_1             varchar(80) default '',                -- Adresse facturation
  Adresse_2             varchar(50) default '',                -- Complément d'adresse de facturation
  Adresse_3             varchar(50) default '',                -- Ligne d'adresse 3 de facturation
  Code_Postal           varchar(10) default '',                -- Code postal de facturation
  Ville                 varchar(50) default '',                -- Ville de facturation
  Code_Pays             char(2) default 'FR',                  -- Code pays
  Date_C                bigint unsigned default 0,             -- date de création
  Date_M                bigint unsigned default 0,             -- date de mise à jour
  Util_C                int not null,                          -- utilisateur créateur de l'avoir
  Util_M                int not null,                          -- utilisateur ayant fait la dernière modification de l'avoir
  Util_R                int default null,                      -- utilisateur responsable de l'avoir
  Total_HT              decimal(14,2) unsigned default 0,      -- Total HT de l'avoir
  Total_TTC             decimal(14,2) unsigned default 0,      -- Montant TTC de l'avoir
  Code_Tarif            tinyint unsigned default 1,            -- Code tarif utilisé
  Transfere             tinyint unsigned default 0,            -- 1 si avoir transféré en compta
  Montant_Restant       decimal(14,2) default 0,               -- Montant restant à imputer
  Etat                  char(1) default 'N',                   -- Etat pour règlement (N=Non imputé,P=Partiellement imputé, T=imputé Totalement)
  Remise                decimal(5,2) unsigned default 0,       -- Pourcentage de remise
  MRemise               decimal(9,2) unsigned default 0,       -- Montant de remise uniquement si remise en montant sinon 0
  PRemise_FP            decimal(9,6) unsigned default 0,       -- Pourcentage de remise sur frais de port
  MRemise_FP            decimal(9,2) unsigned default 0,       -- Montant de remise sur frais de port uniquement si remise en montant sinon 0
  Escompte              decimal(5,2) unsigned default 0,       -- Pourcentage d'escompte
  Frais_Port            decimal(10,2) unsigned default 0,      -- Montant HT des frais de port
  Taux_TVA_Port         decimal(4,2) unsigned default 0,       -- Taux de TVA des frais de port
  Code_TVA_Port         int unsigned not null,                 -- Code de TVA des frais de port
  Mentions              text,                                  -- Mentions
  Vers_Calc             tinyint unsigned default 2,            -- Version de calcul de document
  Secteur_Activite      int unsigned default null,             -- Secteur d'activité
  primary key (Avoir_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  index idx_code_tva_port (Code_TVA_Port),
  index idx_secteur_activite (Secteur_Activite),
  constraint cfk_avoir_fournisseur_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_avoir_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade,
  constraint cfk_avoir_fournisseur_code_tva_port foreign key (Code_TVA_Port) references TAUX_TVA (Code_TVA)
) engine=InnoDB;


create table LIGNE_AVOIR_FOURNISSEUR (
  Ligne_Id            int unsigned not null auto_increment, -- Identifiant de la ligne
  Avoir_Id            int unsigned not null,                -- Identifiant avoir
  Ref_Ligne_CF        int unsigned default null,            -- Ligne correspondante de la commande fournisseur
  Ref_Ligne_FF        int unsigned default null,            -- Ligne correspondante de la facture fournisseur
  Rank                int unsigned not null,                -- Numéro d'ordre dans l'avoir
  Reference           varchar(40) default '',               -- Code article
  Ref_Fournisseur     varchar(40) default '',               -- Référence article chez le fournisseur
  Type_Ligne          char(1) default 'I',                  -- Type de la ligne (S=Stock,I=Indépendante)
  Designation         varchar(100) default '',              -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,     -- Quantité
  Prix                decimal(14,4) unsigned default 0,     -- Prix unitaire HT de l'article
  Code_TVA            int unsigned default 1,               -- Code TVA
  Taux_TVA            decimal(4,2) unsigned default 0,      -- Taux de TVA
  Commentaire         text,                                 -- Commentaire bas associé à la ligne
  Commentaire_Avant   text,                                 -- Commentaire haut associé à la ligne
  Libelle             varchar(20) default '',               -- Libelle supplémentaire
  Ristourne           decimal(5,2) unsigned default 0,      -- Taux de ristourne
  Num_Lot             varchar(15) default '',               -- numéro de lot
  Nb_Pieces           int unsigned default 0,               -- nombre de pièces par quantité
  Date_Peremption     bigint unsigned default 0,            -- date de péremption
  Unite               char(3) default 'U',                  -- unité de vente
  Montant_Ligne       decimal(14,2) unsigned default 0,     -- Montant de la ligne
  primary key (Ligne_Id),
  index idx_code_tva (Code_TVA),
  index idx_avoir_id (Avoir_Id),
  index idx_ref_ligne_cf (Ref_Ligne_CF),
  index idx_ref_ligne_ff (Ref_Ligne_FF),
  constraint cfk_ligne_avoir_fournisseur_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA),
  constraint cfk_ligne_avoir_fournisseur_avoir_id foreign key (Avoir_Id) references AVOIR_FOURNISSEUR (Avoir_Id),
  constraint cfk_ligne_avoir_fournisseur_ref_ligne_cf foreign key (Ref_Ligne_CF) references LIGNE_COMMANDE_FOURNISSEUR (Ligne_Id),
  constraint cfk_ligne_avoir_fournisseur_ref_ligne_ff foreign key (Ref_Ligne_FF) references LIGNE_FACTURE_FOURNISSEUR (Ligne_Id)
) engine=InnoDB;


create table COMMANDE_FOURNISSEUR_AVOIR (
  Commande_Id         int unsigned not null,                -- Identifiant commande fournisseur
  Avoir_Id            int unsigned not null,                -- Identifiant avoir fournisseur
--  Frais_Port          decimal(10,2) unsigned default 0,     -- Montant de frais de port
  primary key (Commande_Id, Avoir_Id),
  constraint cfk_commande_fournisseur_avoir_commande_id foreign key (Commande_Id) references COMMANDE_FOURNISSEUR (Commande_Id),
  constraint cfk_commande_fournisseur_avoir_avoir_id foreign key (Avoir_Id) references AVOIR_FOURNISSEUR (Avoir_Id)
) engine=InnoDB;


create table FACTURE_AVOIR_FOURNISSEUR (
  Facture_Id          int unsigned not null,                -- Identifiant facture fournisseur
  Avoir_Id            int unsigned not null,                -- Identifiant avoir fournisseur
  primary key (Facture_Id, Avoir_Id),
  constraint cfk_facture_avoir_fournisseur_facture_id foreign key (Facture_Id) references FACTURE_FOURNISSEUR (Facture_Id),
  constraint cfk_facture_avoir_fournisseur_avoir_id foreign key (Avoir_Id) references AVOIR_FOURNISSEUR (Avoir_Id)
) engine=InnoDB;



-- ---------------- SUIVI DES REGLEMENTS FOURNISSEURS -------------------------------------------


create table ECHEANCE_FOURNISSEUR (
  Echeance_Id          int unsigned not null auto_increment,  -- Identifiant échéance de règlement au fournisseur
  Date_Echeance        bigint unsigned default 0,             -- Date de fin de l'échéance réelle
  Echeance_Initiale    bigint unsigned default 0,             -- Date de fin de l'échéance initialement prévue
  Fournisseur_Id       char(10) default null,                 -- Code fournisseur
  Denomination         varchar(50) default '',                -- Raison sociale du fournisseur
  Montant              decimal(14,2) default 0,               -- Montant de l'échéance
  Montant_Restant      decimal(14,2) default 0,               -- Montant restant dû de l'échéance
  Etat                 char(1) default 'N',                   -- Etat de l'imputation de l'échéance (N=Non imputée,P=imputée Partiellement,T=imputée Totalement)
  Mode_Reg_Id          int unsigned not null,                 -- Mode de règlement prevu
  Commentaires         varchar(100) default '',               -- Commentaires sur l'échéance
  primary key (Echeance_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  constraint cfk_echeance_fournisseur_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id),
  constraint cfk_echeance_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade
) engine=InnoDB;


create table FACTURE_ECHEANCE_FOURNISSEUR (
  Echeance_Id         int unsigned not null,     -- Identifiant de l'échéance fournisseur
  Facture_Id          int unsigned not null,     -- Identifiant de la facture fournisseur
  primary key (Echeance_Id, Facture_Id),
  constraint cfk_facture_echeance_fournisseur_echeance_id foreign key (Echeance_Id) references ECHEANCE_FOURNISSEUR (Echeance_Id),
  constraint cfk_facture_echeance_fournisseur_facture_id foreign key (Facture_Id) references FACTURE_FOURNISSEUR (Facture_Id)
) engine=InnoDB;


create table ACOMPTE_ECHEANCE_FOURNISSEUR (
  Echeance_Id         int unsigned not null,     -- Identifiant de l'échéance fournisseur
  Acompte_Id          int not null,              -- Identifiant de l'acompte fournisseur
  primary key (Echeance_Id, Acompte_Id),
  constraint cfk_acompte_echeance_fournisseur_echeance_id foreign key (Echeance_Id) references ECHEANCE_FOURNISSEUR (Echeance_Id),
  constraint cfk_acompte_echeance_fournisseur_acompte_id foreign key (Acompte_Id) references ACOMPTE_FOURNISSEUR (Acompte_Id)
) engine=InnoDB;


create table IMPUTATION_ECHEANCE_FOURNISSEUR (
  Imputation_Id          int not null auto_increment,           -- Identifiant de l'imputation
  Echeance_Id            int unsigned not null,                 -- Identifiant de l'échéance
  Montant                decimal(14,2) unsigned default 0,      -- Montant imputé à l'échéance
  Date_Imputation        bigint unsigned default 0,             -- Date d'imputation
  primary key (Imputation_Id),
  index idx_echeance_id (Echeance_Id),
  constraint cfk_imputation_echeance_fournisseur_echeance_id foreign key (Echeance_Id) references ECHEANCE_FOURNISSEUR (Echeance_Id)
) engine=InnoDB;


create table IMPUTATION_ECHEANCE_AVOIR_FOURNISSEUR (
  Imputation_Id          int not null,                          -- Identifiant de l'imputation
  Avoir_Id               int unsigned not null,                 -- Identifiant de l'avoir
  primary key (Imputation_Id, Avoir_Id),
  constraint cfk_imputation_echeance_avoir_fournisseur_imputation_id foreign key (Imputation_Id) references IMPUTATION_ECHEANCE_FOURNISSEUR (Imputation_Id),
  constraint cfk_imputation_echeance_avoir_fournisseur_avoir_id foreign key (Avoir_Id) references AVOIR_FOURNISSEUR (Avoir_Id)
) engine=InnoDB;


create table REGULARISATION_ECHEANCE_FOURNISSEUR (
  Regularisation_Id      int not null auto_increment,           -- Identifiant de la régularisation
  Imputation_Id          int not null,                          -- Identifiant de l'imputation
  Montant                decimal(14,2) unsigned default 0,      -- Montant de la régularisation
  Comptabilise           tinyint unsigned default 0,            -- Transféré en comptabilité
  Date_Regul             bigint unsigned default 0,             -- Date de la régularisation
  Date_Annul             bigint unsigned default 0,             -- Date d'annulation
  Compta_Annul           tinyint unsigned default 0,            -- Annulé en comptabilité
  primary key (Regularisation_Id),
  index idx_imputation_id (Imputation_Id),
  constraint cfk_regularisation_echeance_fournisseur_imputation_id foreign key (Imputation_Id) references IMPUTATION_ECHEANCE_FOURNISSEUR (Imputation_Id)
) engine=InnoDB;


create table REGLEMENT_FOURNISSEUR (
  Reglement_Id           int unsigned not null auto_increment,  -- Identifiant paiement
  Date_Reg               bigint unsigned default 0,             -- Date de paiement
  Fournisseur_Id         char(10) default null,                 -- Code fournisseur
  Denomination           varchar(50) default '',                -- Raison sociale du fournisseur
  Banque_Retrait         int unsigned not null,                 -- Banque de retrait
  Num_Piece              varchar(20) default '',                -- Numéro de pièce de paiement
  Banque_Fournisseur     varchar(30) default '',                -- Banque du fournisseur
  Montant                decimal(14,2) default 0,               -- Montant du paiement
  Montant_Restant        decimal(14,2) default 0,               -- Montant restant à imputer
  Etat                   char(1) default 'N',                   -- Etat de l'imputation du règlement (N=Non imputée,P=imputée Partiellement,T=imputée Totalement)
  Statut                 char(1) default 'V',                   -- Statut du règlement (V=Validé, A=Annulé)
  Compta_Annul           tinyint unsigned default 0,            -- Réglement annulé en comptabilité
  Comptabilise           tinyint unsigned default 0,            -- Règlement comptabilisé
  Mode_Reg_Id            int unsigned not null,                 -- Mode de paiement effectif
  Commentaires           varchar(100) default '',               -- Commentaires du paiement
  primary key (Reglement_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  index idx_banque_retrait (Banque_Retrait),
  constraint cfk_reglement_fournisseur_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id),
  constraint cfk_reglement_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade,
  constraint cfk_reglement_fournisseur_banque_retrait foreign key (Banque_Retrait) references BANQUE (Banque_Id)
) engine=InnoDB;


create table IMPUTATION_ECHEANCE_REGLEMENT_FOURNISSEUR (
  Imputation_Id          int not null,                          -- Identifiant de l'imputation
  Reglement_Id           int unsigned not null,                 -- Identifiant du règlement
  primary key (Imputation_Id, Reglement_Id),
  constraint cfk_imputation_echeance_reglement_fournisseur_imputation_id foreign key (Imputation_Id) references IMPUTATION_ECHEANCE_FOURNISSEUR (Imputation_Id),
  constraint cfk_imputation_echeance_reglement_fournisseur_reglement_id foreign key (Reglement_Id) references REGLEMENT_FOURNISSEUR (Reglement_Id)
) engine=InnoDB;


create table REMBOURSEMENT_FOURNISSEUR (
  Remboursement_Id       int not null auto_increment,           -- Identifiant du remboursement
  Date_Remboursement     bigint unsigned default 0,             -- Date du remboursement
  Montant                decimal(14,2) unsigned default 0,      -- Montant du remboursement
  Montant_Restant        decimal(14,2) unsigned default 0,      -- Montant restant à imputer
  Etat                   char(1) default 'N',                   -- Etat de l'imputation du remboursement (N=Non imputée,P=imputée Partiellement,T=imputée Totalement)
  Statut                 char(1) default 'V',                   -- Statut du remboursement (V=Valide,A=Annulé)
  Comptabilise           tinyint unsigned default 0,            -- Transféré en comptabilité (oui/non)
  Compta_Annul           tinyint unsigned default 0,            -- Annulé en comptabilité (oui/non)
  Banque_Remise          int unsigned default null,             -- Banque de remise
  Mode_Reg_Id            int unsigned not null,                 -- Mode de règlement
  Fournisseur_Id         char(10) default null,                 -- Identifiant fournisseur
  Denomination           varchar(50) default '',                -- Dénomination fournisseur
  Num_Piece              varchar(20) default '',                -- Numéro de pièce
  Commentaires           varchar(100) default '',               -- Commentaires sur le remboursement
  Motif                  int unsigned not null,                 -- Motif de remboursement
  Banque_Fournisseur     varchar(30) default '',                -- Banque fournisseur
  primary key (Remboursement_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_fournisseur_id (Fournisseur_Id),
  index idx_banque_remise (Banque_Remise),
  index idx_motif (Motif),
  constraint cfk_remboursement_fournisseur_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id),
  constraint cfk_remboursement_fournisseur_fournisseur_id foreign key (Fournisseur_Id) references FICHE_FOURNISSEUR (Fournisseur_Id) on update cascade,
  constraint cfk_remboursement_fournisseur_banque_remise foreign key (Banque_Remise) references BANQUE (Banque_Id),
  constraint cfk_remboursement_fournisseur_motif foreign key (Motif) references MOTIF_REMBOURSEMENT (Motif_Id)
) engine=InnoDB;


create table REMISE_REMBOURSEMENT_FOURNISSEUR (
  Remise_Id              int unsigned not null,                 -- Identifiant de la remise en banque
  Remboursement_Id       int not null,                          -- Identifiant du remboursement
  primary key (Remise_Id, Remboursement_Id),
  constraint cfk_remise_reglement_fournisseur_remise_id foreign key (Remise_Id) references REMISE_BANQUE (Remise_Id),
  constraint cfk_remise_reglement_fournisseur_remboursement_id foreign key (Remboursement_Id) references REMBOURSEMENT_FOURNISSEUR (Remboursement_Id)
) engine=InnoDB;


create table IMPUTATION_AVOIR_FOURNISSEUR (
  Imputation_Id          int not null auto_increment,           -- Identifiant de l'imputation
  Avoir_Id               int unsigned not null,                 -- Identifiant de l'avoir
  Montant                decimal(14,2) unsigned default 0,      -- Montant imputé à l'avoir
  Date_Imputation        bigint unsigned default 0,             -- Date d'imputation
  primary key (Imputation_Id),
  index idx_avoir_id (Avoir_Id),
  constraint cfk_imputation_avoir_fournisseur_avoir_id foreign key (Avoir_Id) references AVOIR_FOURNISSEUR (Avoir_Id)
) engine=InnoDB;


create table IMPUTATION_REGLEMENT_FOURNISSEUR (
  Imputation_Id          int not null auto_increment,           -- Identifiant de l'imputation
  Reglement_Id           int unsigned not null,                 -- Identifiant du règlement
  Montant                decimal(14,2) unsigned default 0,      -- Montant imputé au règlement
  Date_Imputation        bigint unsigned default 0,             -- Date d'imputation
  primary key (Imputation_Id),
  index idx_reglement_id (Reglement_Id),
  constraint cfk_imputation_reglement_fournisseur_reglement_id foreign key (Reglement_Id) references REGLEMENT_FOURNISSEUR (Reglement_Id)
) engine=InnoDB;


create table IMPUTATION_AVOIR_REMBOURSEMENT_FOURNISSEUR (
  Imputation_Id          int not null,                          -- Identifiant de l'imputation
  Remboursement_Id       int not null,                          -- Identifiant du remboursement
  primary key (Imputation_Id, Remboursement_Id),
  constraint cfk_imputation_avoir_remboursement_fournisseur_imputation_id foreign key (Imputation_Id) references IMPUTATION_AVOIR_FOURNISSEUR (Imputation_Id),
  constraint cfk_imputation_avoir_remboursement_fournisseur_remboursement_id foreign key (Remboursement_Id) references REMBOURSEMENT_FOURNISSEUR (Remboursement_Id)
) engine=InnoDB;


create table IMPUTATION_REGLEMENT_REMBOURSEMENT_FOURNISSEUR (
  Imputation_Id          int not null,                          -- Identifiant de l'imputation
  Remboursement_Id       int not null,                          -- Identifiant du remboursement
  primary key (Imputation_Id, Remboursement_Id),
  constraint cfk_imputation_reglement_remboursement_fournisseur_imputation_id foreign key (Imputation_Id) references IMPUTATION_REGLEMENT_FOURNISSEUR (Imputation_Id),
  constraint cfk_imputation_reglement_remboursement_fournisseur_remboursement foreign key (Remboursement_Id) references REMBOURSEMENT_FOURNISSEUR (Remboursement_Id)
) engine=InnoDB;


create table REGULARISATION_REGLEMENT_FOURNISSEUR (
  Regularisation_Id      int not null auto_increment,           -- Identifiant de la régularisation
  Imputation_Id          int not null,                          -- Identifiant de l'imputation
  Montant                decimal(14,2) unsigned default 0,      -- Montant de la régularisation
  Comptabilise           tinyint unsigned default 0,            -- Transféré en comptabilité
  Date_Regul             bigint unsigned default 0,             -- Date de la régularisation
  Date_Annul             bigint unsigned default 0,             -- Date d'annulation
  Compta_Annul           tinyint unsigned default 0,            -- Annulé en comptabilité
  primary key (Regularisation_Id),
  index idx_imputation_id (Imputation_Id),
  constraint cfk_regularisation_reglement_fournisseur_imputation_id foreign key (Imputation_Id) references IMPUTATION_REGLEMENT_FOURNISSEUR (Imputation_Id)
) engine=InnoDB;


create table REGULARISATION_AVOIR_FOURNISSEUR (
  Regularisation_Id      int not null auto_increment,           -- Identifiant de la régularisation
  Imputation_Id          int not null,                          -- Identifiant de l'imputation
  Montant                decimal(14,2) unsigned default 0,      -- Montant de la régularisation
  Comptabilise           tinyint unsigned default 0,            -- Transféré en comptabilité
  Date_Regul             bigint unsigned default 0,             -- Date de la régularisation
  Date_Annul             bigint unsigned default 0,             -- Date d'annulation
  Compta_Annul           tinyint unsigned default 0,            -- Annulé en comptabilité
  primary key (Regularisation_Id),
  index idx_imputation_id (Imputation_Id),
  constraint cfk_regularisation_avoir_fournisseur_imputation_id foreign key (Imputation_Id) references IMPUTATION_AVOIR_FOURNISSEUR (Imputation_Id)
) engine=InnoDB;



-- ---------------- COLISAGE - ETIQUETAGE --------------------------------------------------------


create table COLIS (
  Colis_Id       int unsigned not null auto_increment,  -- identifiant colis
  Bon_Id         int unsigned default 0,                -- identifiant du bon de livraison
  Ident_Suivi    varchar(20) default '',                -- identifiant transporteur pour suivi du colis
  Numero         int unsigned default 0,                -- numéro du colis
  Poids          decimal(10,3) unsigned default 0,      -- poids du colis en kg
  Lien           varchar(200) default '',               -- lien vers le suivi de commande
  primary key (Colis_Id),
  index idx_bon_id (Bon_Id),
  constraint cfk_colis_bon_id foreign key (Bon_Id) references BON_LIVRAISON (Bon_Id)
) engine=InnoDB;


create table CONTENU_COLIS (
  Colis_Id       int unsigned not null,              -- identifiant colis
  Ref_Ligne      int unsigned not null,              -- ligne correspondante de la commande
  Quantite       decimal(10,3) unsigned default 0,   -- quantité de l'article dans le colis
  Poids          decimal(10,3) unsigned default 0,   -- poids unitaire en kg
  primary key (Ref_Ligne, Colis_Id),
  constraint cfk_contenu_colis_colis_id foreign key (Colis_Id) references COLIS (Colis_Id),
  constraint cfk_contenu_colis_ref_ligne foreign key (Ref_Ligne) references LIGNE_COMMANDE_CLIENT (Ligne_Id)
) engine=InnoDB;


create table MODELE_ETIQUETTE (
  Modele_Id      varchar(10) not null,      -- identifiant modèle
  Description    varchar(100) default '',   -- description du modèle
  Class          varchar(100) default '',   -- class java
  primary key (Modele_Id)
) engine=InnoDB;



-- ---------------- ABONNEMENTS -------------------------------------------------------------------

create table MODELE (
  Modele_Id                   int unsigned not null auto_increment, -- Identifiant du modele
  Reference_modele            char(10) not null,                    -- Reference du modele
  Libelle_modele              varchar(40) not null,                 -- libelle du modele
  Periodicite                 tinyint unsigned,                     -- Valeur de la periodicite
  Type_periodicite            tinyint unsigned,                     -- Type de periodicite(1=jour(s),2=semaine(s),3=mois,4=an(s))
  Duree_contrat               int unsigned,                         -- Valeur de la duree du contrat
  Type_duree_contrat          tinyint unsigned,                     -- Type de duree (1=jour(s),2=semaine(s),3=mois,4=an(s))
  Type_contrat                tinyint unsigned,                     -- Type contrat  (1=sans reconduction,2=reconduction tacite
  Duree_recon_contrat         int unsigned,                         -- Valeur de la duree du contrat
  Type_duree_recon_contrat    tinyint unsigned,                     -- Type de duree (1=jour(s),2=semaine(s),3=mois,4=an(s))
  OptionRachat                tinyint unsigned,                     -- Option de rachat en fin d'abonnement dans le cas d'un abonnement sans reconduction (0 = non, 1 = oui)
  Delai_preavis               tinyint unsigned,                     -- Valeur en mois du preavis (1,2 ou 3 mois)
  Delai_gen_facture           tinyint unsigned,                     -- delai en jour pour generation de la facture avant envoi
  nbPeriodeOfferte            tinyint unsigned,                     -- nombre de periode offerte
  Delais_reglement            tinyint unsigned,                     -- delai en jour pour le reglement d'un facture
  Type_reglement              tinyint unsigned,                     -- type de reglement (1=net,2=fin de mois,3=fin de mois le)
  Val_type_reglement          tinyint unsigned default 0,           -- si Type_reglement=3, valeur de fin de mois le sinon 0
  Commentaires                text,                                 -- commentaires associé à une facture
  Com_ds_facture              tinyint unsigned,                     -- si le commentaire est ecrit dans la facture(1=oui/0=non)
  Code_tarif                  tinyint unsigned default 1,           -- code tarif utilisé
  Mode_Reg_Id                 int unsigned not null,                -- defini le mode de reglement utilisé
  Remise                      decimal(5,2) unsigned,                -- Pourcentage de remise
  MRemise                     decimal(9,2) unsigned default 0,      -- Montant de remise
  Escompte                    decimal(5,2) unsigned,                -- Pourcentage d'escompte
  Frais_Port                  decimal(10,2) unsigned,               -- Montant HT des frais de port
  PRemise_FP                  decimal(9,6) unsigned default 0,      -- Pourcentage de remise sur frais de port
  MRemise_FP                  decimal(9,2) unsigned default 0,      -- Montant de remise sur frais de port uniquement si remise en montant sinon 0
  Date_C                      bigint unsigned default 0,            -- Date de création du modele
  Date_M                      bigint unsigned default 0,            -- Date de mise à jour
  Util_C                      int not null,                         -- Utilisateur créateur du modèle
  Util_M                      int not null,                         -- Utilisateur ayant fait la dernière modification du modèle
  Util_R                      int default null,                     -- Utilisateur responsable du modèle
  Type_facturation            tinyint unsigned,                     -- type de facturation (1 = Terme à echoir et 2 = Terme échu)
  PrefixeNumContrat           varchar(6),                           -- Debut du numero de contrat d'un abonnement
  Edition_TTC                 tinyint unsigned default 0,           -- 1 si le modèle est édité en ttc
  Secteur_Activite            int unsigned default null,            -- Secteur d'activité
  primary key (Modele_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_secteur_activite (Secteur_Activite),
  constraint cfk_modele_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_modele_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;


create table LIGNE_MODELE (
  Ligne_Id            int unsigned not null auto_increment,  -- Identifiant de la ligne
  Modele_Id           int unsigned not null,                 -- Identifiant du modele
  Rank                int unsigned not null,                 -- Numéro d'ordre dans la facture
  Reference           varchar(40),                           -- Code article
  Type_Ligne          char(1),                               -- Type de la ligne (S=Stock,I=Indépendante)
  Designation         varchar(100) default '',               -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,      -- Quantité
  Prix                decimal(14,4),                         -- Prix unitaire HT de l'article
  Ristourne           decimal(5,2) unsigned,                 -- Taux de ristourne
  Code_TVA            int unsigned default 1,                -- Code TVA
  Taux_TVA            decimal(4,2) unsigned,                 -- Taux de TVA
  Commentaire         text,                                  -- Commentaire bas associé à la ligne
  Commentaire_Avant   text,                                  -- Commentaire haut associé à la ligne
  Libelle             varchar(20) default '',                -- Libelle supplémentaire
  primary key (Ligne_Id),
  index idx_modele_id (Modele_Id),
  index idx_code_tva (Code_TVA),
  constraint cfk_ligne_modele_modele_id foreign key (Modele_Id) references MODELE (Modele_Id),
  constraint cfk_ligne_modele_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA)
) engine=InnoDB;


create table ABONNEMENT (
  Abonnement_Id             int unsigned not null auto_increment,  -- Identifiant de l'abonnement
  NumeroMoisPrefixe         int unsigned default 0,                -- numero par mois et par prefixe
  Num_Entier                char(14),                              -- Numero Entier du contrat
  PrefixeNumContrat         varchar(6),                            -- Debut du numero de contrat d'un abonnement
  Modele_Id                 int unsigned not null,                 -- Identifiant du modele (=0 si l'abonnement est créé sans modele)
  Libelle                   varchar(40) not null,                  -- libelle
  Periodicite               tinyint unsigned,                      -- Valeur de la periodicite
  Type_periodicite          tinyint unsigned,                      -- Type de periodicite(1=jour(s),2=semaine(s),3=mois,4=an(s))
  Duree_contrat             int unsigned,                          -- Valeur de la duree du contrat
  Type_duree_contrat        tinyint unsigned,                      -- Type de duree (1=jour(s),2=semaine(s),3=mois,4=an(s))
  Duree_recon_contrat       int unsigned,                          -- Valeur de la duree du contrat
  Type_duree_recon_contrat  tinyint unsigned,                      -- Type de duree (1=jour(s),2=semaine(s),3=mois,4=an(s))
  Type_contrat              tinyint unsigned,                      -- Type contrat  (1=sans reconduction,2=reconduction tacite
  OptionRachat              tinyint unsigned,                      -- Option de rachat en fin d'abonnement dans le cas d'un abonnement sans reconduction (0 = non, 1 = oui)
  ValeurRachat              decimal(14,2),                         -- valeur HT de l'article en cas de rachat
  PourcentageRachat         decimal(5,2) unsigned,                 -- Pourcentage correspond au rachat de l'article
  Delai_preavis             tinyint unsigned,                      -- Valeur en mois du preavis (1,2 ou 3 mois)
  Date_du_preavis           bigint unsigned,                       -- date du preavis (date de fin - delais preavis)
  Delai_gen_facture         tinyint unsigned,                      -- delai en jour pour generation de la facture avant envoi
  nbPeriodeOfferte          tinyint unsigned,                      -- nombre de periode offerte
  Delais_reglement          tinyint unsigned,                      -- delai en jour pour le reglement d'un facture
  Type_reglement            tinyint unsigned,                      -- type de reglement (1=net,2=fin de mois,3=fin de mois le)
  Val_type_reglement        tinyint unsigned default 0,            -- si Type_reglement=3, valeur de fin de mois le sinon 0
  Commentaires              text,                                  -- commentaires associé à une facture
  Date_debut_contrat        bigint unsigned,                       -- date de debut du contrat
  Date_debut_abonnement     bigint unsigned,                       -- date de fin de l'abonnement en cours
  Date_fin_abonnement       bigint unsigned,                       -- date de fin de l'abonnement en cours
  Code_tarif                tinyint unsigned default 1,            -- code tarif utilisé
  Mode_Reg_Id               int unsigned not null,                 -- defini le mode de reglement utilisé
  Remise                    decimal(5,2) unsigned,                 -- Pourcentage de remise
  MRemise                   decimal(9,2) unsigned default 0,       -- Montant de remise
  Escompte                  decimal(5,2) unsigned,                 -- Pourcentage d'escompte
  Frais_Port                decimal(10,2) unsigned,                -- Montant HT des frais de port
  PRemise_FP                decimal(9,6) unsigned default 0,       -- Pourcentage de remise sur frais de port
  MRemise_FP                decimal(9,2) unsigned default 0,       -- Montant de remise sur frais de port uniquement si remise en montant sinon 0
  Etat                      char(1),                               -- Etat de l'abonnement (A=en attente,C=en cours,T=terminé,R=resilié)
  Date_C                    bigint unsigned default 0,             -- Date de création de l'abonnement
  Date_M                    bigint unsigned default 0,             -- Date de mise à jour
  Util_C                    int not null,                          -- Utilisateur créateur de l'abonnement
  Util_M                    int not null,                          -- Utilisateur ayant fait la dernière modification de l'abonnement
  Util_R                    int default null,                      -- Utilisateur responsable de l'abonnement
  Denomination              varchar(50) default '',                --
  Adresse_1                 varchar(80) default '',                -- Ligne d'adresse 1
  Adresse_2                 varchar(50) default '',                -- Ligne d'adresse 2
  Adresse_3                 varchar(50) default '',                -- Ligne d'adresse 3
  Code_Postal               varchar(10),                           --
  Ville                     varchar(50),                           --
  Code_Pays                 char(2) default 'FR',                  -- Code pays
  Client_Id                 char(10) default null,                 -- Identifiant client
  Type_facturation          tinyint unsigned,                      -- type de facturation (1 = à echoire et 2 = à echu)
  Edition_TTC               tinyint unsigned default 0,            -- 1 si l'abonnement est édité en ttc
  Civ_Inter                 tinyint unsigned default 0,
  Nom_Inter                 varchar(30) default '',                -- Nom et prénom du client
  Prenom_Inter              varchar(30) default '',
  Tel_Inter                 varchar(20) default '',
  Fax_Inter                 varchar(20) default '',
  Email_Inter               varchar(64) default '',
  Denomination_Liv          varchar(50) default '',                -- Denomination de livraison
  Adresse_1_Liv             varchar(80) default '',                -- Ligne d'adresse 1 de livraison
  Adresse_2_Liv             varchar(50) default '',                -- Ligne d'adresse 2 de livraison
  Adresse_3_Liv             varchar(50) default '',                -- Ligne d'adresse 3 de livraison
  Code_Postal_Liv           varchar(10) default '',                -- Code postal de livraison
  Ville_Liv                 varchar(50) default '',                -- Ville de livraison
  Code_Pays_Liv             char(2) default 'FR',                  -- Code pays de livraison
  Civ_Inter_Liv             tinyint unsigned default 0,            -- Civilité de l'interlocuteur de livraison
  Nom_Inter_Liv             varchar(30) default '',                -- Nom de l'interlocuteur de livraison
  Prenom_Inter_Liv          varchar(30) default '',                -- Prénom de l'interlocuteur de livraison
  Tel_Inter_Liv             varchar(20) default '',                -- Téléphone de l'interlocuteur de livraison
  Fax_Inter_Liv             varchar(20) default '',                -- Fax de l'interlocuteur de livraison
  Email_Inter_Liv           varchar(64) default '',                -- E-Mail de l'interlocuteur de livraison
  Denomination_Envoi        varchar(50) default '',                -- Dénomination d'envoi facture
  Adresse_1_Envoi           varchar(80) default '',                -- Ligne d'adresse 1 d'envoi facture
  Adresse_2_Envoi           varchar(50) default '',                -- Ligne d'adresse 2 d'envoi facture
  Adresse_3_Envoi           varchar(50) default '',                -- Ligne d'adresse 3 d'envoi facture
  Code_Postal_Envoi         varchar(10) default '',                -- Code postal d'envoi facture
  Ville_Envoi               varchar(50) default '',                -- Ville d'envoi facture
  Code_Pays_Envoi           char(2) default 'FR',                  -- Code pays d'envoi facture
  Civ_Inter_Envoi           tinyint unsigned default 0,            -- Civilité de l'interlocuteur d'envoi
  Nom_Inter_Envoi           varchar(30) default '',                -- Nom de l'interlocuteur d'envoi
  Prenom_Inter_Envoi        varchar(30) default '',                -- Prénom de l'interlocuteur d'envoi
  Tel_Inter_Envoi           varchar(20) default '',                -- Téléphone de l'interlocuteur d'envoi
  Fax_Inter_Envoi           varchar(20) default '',                -- Fax de l'interlocuteur d'envoi
  Email_Inter_Envoi         varchar(64) default '',                -- Email de l'interlocuteur d'envoi
  Assujetti_TVA             tinyint unsigned default 0,            -- Assujetti à la TVA (1=oui,0=non)
  Num_TVA_Intra             varchar(14) default '',                -- Numéro de TVA intracommunautaire
  Mentions                  text,                                  -- Mentions
  Secteur_Activite          int unsigned default null,             -- Secteur d'activité
  primary key (Abonnement_Id),
  index idx_modele_id (Modele_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_client_id (Client_Id),
  index idx_secteur_activite (Secteur_Activite),
  constraint cfk_abonnement_secteur_activite foreign key (Secteur_Activite) references SECTEUR_ACTIVITE (Secteur_Id),
  constraint cfk_abonnement_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade,
  constraint cfk_abonnement_modele_id foreign key (Modele_Id) references MODELE (Modele_Id),
  constraint cfk_abonnement_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;


create table LIGNE_ABONNEMENT (
  Ligne_Id            int unsigned not null auto_increment,  -- Identifiant de la ligne
  Abonnement_Id       int unsigned not null,                 -- Identifiant de l'abonnement
  Rank                int unsigned not null,                 -- Numéro d'ordre dans la facture
  Reference           varchar(40),                           -- Code article
  Type_Ligne          char(1),                               -- Type de la ligne (S=Stock,I=Indépendante)
  Designation         varchar(100),                          -- Désignation de l'article
  Quantite            decimal(10,3) unsigned default 1,      -- Quantité
  Prix                decimal(14,4),                         -- Prix unitaire HT de l'article
  Ristourne           decimal(5,2) unsigned,                 -- Taux de ristourne
  Code_TVA            int unsigned default 1,                -- Code TVA
  Taux_TVA            decimal(4,2) unsigned,                 -- Taux de TVA
  Commentaire         text,                                  -- Commentaire bas associé à la ligne
  Commentaire_Avant   text,                                  -- Commentaire haut associé à la ligne
  Libelle             varchar(20),                           -- Libelle supplémentaire
  primary key (Ligne_Id),
  index idx_code_tva (Code_TVA),
  index idx_abonnement_id (Abonnement_Id),
  constraint cfk_ligne_abonnement_abonnement_id foreign key (Abonnement_Id) references ABONNEMENT (Abonnement_Id),
  constraint cfk_ligne_abonnement_code_tva foreign key (Code_TVA) references TAUX_TVA (Code_TVA)
) engine=InnoDB;


create table ECHEANCE_ABONNEMENT (
  NumEcheance          int unsigned not null,                -- Numero de l'echeance
  Abonnement_Id        int unsigned not null,                -- Identifiant de l'abonnement
  Date_Debut           bigint unsigned,                      -- Date de debut de l'echeance
  Date_Fin             bigint unsigned,                      -- Date de fin de l'echeance
  Date_generation      bigint unsigned,                      -- Date de generation de l'echeance (date à laquelle on l'affiche dans les factures à émettre)
  Facture_Id           int unsigned default null,            -- identifiant de la facture
  Total_HT             decimal(14,2),                        -- Total HT de l'echance
  MontantTTC           decimal(14,2),                        -- Montant TTC de l'echance
  Etat                 char(1),                              -- Etat de l'echeance (A = annulé,E = en attente, G= generé)
  Date_Echeance        bigint unsigned,                      -- Date d'echeance du reglement
  nbJourEcheance       tinyint unsigned,                     -- = nombre de jour de l'echeance si elle ne couvre pas une periode complete, 0 sinon
  Type                 char(1),                              -- Type de l'echéance (N = normal, R = rachat)
  Historique           tinyint unsigned default 0,           -- defini si l'echeance doit être affiché dans l'historique (0=non,1=oui)
  primary key (NumEcheance, Abonnement_Id),
  index idx_facture_id (Facture_Id),
  constraint cfk_echeance_abonnement_abonnement_id foreign key (Abonnement_Id) references ABONNEMENT (Abonnement_Id),
  constraint cfk_echeance_abonnement_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id)
) engine=InnoDB;


-- ------------------- HISTORIQUE DE TRANSFERT DES DEVIS ---------------------------------------

create table DEVIS_COMMANDE_CLIENT (
  Devis_Id      int unsigned not null,     -- Identifiant de devis
  Commande_Id   int unsigned not null,     -- Identifiant de commande client
  primary key (Devis_Id, Commande_Id),
  constraint cfk_devis_commande_client_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id),
  constraint cfk_devis_commande_client_devis_id foreign key (Devis_Id) references DEVIS (Devis_Id)
) engine=InnoDB;


create table DEVIS_FACTURE (
  Devis_Id      int unsigned not null,     -- Identifiant de devis
  Facture_Id    int unsigned not null,     -- Identifiant de facture
  primary key (Devis_Id, Facture_Id),
  constraint cfk_devis_facture_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id),
  constraint cfk_devis_facture_devis_id foreign key (Devis_Id) references DEVIS (Devis_Id)
) engine=InnoDB;



-- ------------------------- COMMERCIAL ---------------------------------------------------------

create table FICHE_COMMERCIAL (
  Commercial_Id     int unsigned not null,        -- identification du commercial
  Code_Commercial   varchar(15) not null,         -- code d'identification du commercial
  Nom               varchar(30) default '',       -- nom du commercial
  Prenom            varchar(20) default '',       -- Prénom du commercial
  Civilite          tinyint unsigned default 0,   -- Civilité (M=1,Mme=2,Mlle=3)
  Adresse_1         varchar(80) default '',       -- Adresse physique (obligatoire)
  Adresse_2         varchar(50) default '',       -- Adresse 2
  Code_Postal       varchar(10) default '',       -- Code postal
  Ville             varchar(50) default '',       -- ville de résidence du commercial
  Code_Pays         char(2) default 'FR',         -- code pays
  Secteur           varchar(50) default '',       -- secteur d'activité
  Tel_1             varchar(20) default '',       -- telephone n°1
  Tel_2             varchar(20) default '',       -- telephone n°2
  Tel_3             varchar(20) default '',       -- telephone n°3
  Fax_1             varchar(20) default '',       -- fax n°1
  Fax_2             varchar(20) default '',       -- fax n°2
  Email_1           varchar(60) default '',       -- email n°1
  Email_2           varchar(60) default '',       -- email n°2
  Supprime          tinyint default 0,            -- suppression virtuelle(plus visible)
  Util_C            int not null,                 -- createur du commercial dans la base de données
  Date_C            bigint unsigned default 0,    -- date de création du commercial
  Util_M            int not null,                 -- dernière personne à avoir modifié le commercial
  Date_M            bigint unsigned default 0,    -- date de la dernière modification
  primary key (Commercial_Id),
  unique(Code_Commercial)
) engine=InnoDB;


create table REGLE_COMMISSION (
  Commission_Id    int unsigned auto_increment,    -- identifiant de la commission
  Commercial_Id    int unsigned not null,          -- code commercial
  Type             char(3) default 'A',            -- type de commission (G globale, A un article, FA une famille et sous-famille, MQ une marque, HS tous les articles hors-stock, AS tous les articles en stock)
  Base_Calcul      char(3) default 'CA',           -- base de calcul de la commission(CA , CA encaissé, M marge, Q quantité)
  Article_Id       varchar(40) default '',         -- identifiant de l'article si jamais la base de calcul est basée dessus
  Famille_1        int unsigned default null,      -- nom de la famille 1 en cas d'application d'une commission dessus
  Famille_2        int unsigned default null,      -- nom de la famille 2 en cas d'application d'une commission dessus
  Famille_3        int unsigned default null,      -- nom de la famille 3 en cas d'application d'une commission dessus
  Marque_Id        int unsigned default null,      -- nom de la marque en cas d'application d'une commission dessus
  Mode_Calcul_Qte  char(3) default 'P',            -- mode de calcul de la commission en quantité (P pourcentage, E euros)
  Base_Calcul_Qte  char(3) default 'CA',           -- base de calcul de la commission en quantité (CA, M marge)
  Periode_Deb      bigint unsigned default 0,      -- date de mise en service de la règle
  Periode_Fin      bigint unsigned default 0,      -- date de fin de mise en service de la règle (0 = toujours active)
  primary key (Commission_Id),
  index idx_commercial_id (Commercial_Id),
  index idx_famille_1 (Famille_1),
  index idx_famille_2 (Famille_2),
  index idx_famille_3 (Famille_3),
  index idx_marque_id (Marque_Id),
  constraint cfk_regle_commission_marque_id foreign key (Marque_Id) references MARQUE_ARTICLE (Marque_Id),
  constraint cfk_regle_commission_famille_1 foreign key (Famille_1) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_regle_commission_famille_2 foreign key (Famille_2) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_regle_commission_famille_3 foreign key (Famille_3) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_regle_commission_commercial_id foreign key (Commercial_Id) references FICHE_COMMERCIAL (Commercial_Id)
) engine=InnoDB;


create table TRANCHE_COMMISSION (
  Tranche_Id     int unsigned not null auto_increment,  -- identifiant de la tranche
  Commission_Id  int unsigned not null,                 -- identifiant de la commission
  Borne_Inf      decimal(14,2) unsigned default 0,      -- borne inférieure de la tranche
  Borne_Sup      decimal(14,2) unsigned default 0,      -- borne supérieure de la tranche
  Valeur         decimal(14,2) unsigned default 0,      -- Valeur appliquée à la commission si appartient à cette tranche
  primary key (Tranche_Id),
  index idx_commission_id (Commission_Id),
  constraint cfk_tranche_commission_commission_id foreign key (Commission_Id) references REGLE_COMMISSION (Commission_Id)
) engine=InnoDB;


create table COMMISSIONNEMENT (
  Commissionnement_Id  int unsigned not null auto_increment,   -- identifiant du commissionnement
  Date_Commission      bigint unsigned default 0,              -- date d'édition du commissionnement
  Periode_Deb          bigint unsigned default 0,              -- date de début de la période de commissionnement
  Periode_Fin          bigint unsigned default 0,              -- date de fin de la période de commissionnement
  Total_HT             decimal(14,2) default 0,                -- chiffre d'affaires HT généré sur la période
  Total_TTC            decimal(14,2) default 0,                -- chiffre d'affaires TTC généré sur la période
  Montant_Commission   decimal(14,2) default 0,                -- montant de la commission sur la période
  Montant_Ajustement   decimal(14,2) default 0,                -- valeur de l'ajustement
  Commentaires         text,                                   -- commentaires
  Filtre               char(3) default 'A',                    -- filtre d'édition
  Util_R               int not null,                           -- identifiant de l'utilisateur qui génère le commissionnement
  Commercial_Id        int unsigned not null,                  -- code du commercial concerné par la commission
  primary key (Commissionnement_Id),
  index idx_commercial_id (Commercial_Id),
  constraint cfk_commissionnement_commercial_id foreign key (Commercial_Id) references FICHE_COMMERCIAL (Commercial_Id)
) engine=InnoDB;


create table LIGNE_COMMISSIONNEMENT (
  Commissionnement_Id  int unsigned not null,                  -- identifiant du commissionnement
  Rank                 int unsigned not null,                  -- Numéro d'ordre dans le commissionnement
  Ref_Client           varchar(50) default '',                 -- Référence du client
  Ref_Article          varchar(40) default '',                 -- Référence de l'article
  Marque_Id            int unsigned default null,              -- Marque
  Famille_1            int unsigned default null,              -- Famille 1
  Famille_2            int unsigned default null,              -- Famille 2
  Famille_3            int unsigned default null,              -- Famille 3
  Detail_Commission    tinyint unsigned default 0,             -- Detail possible : 0 non, 1 oui
  Ref_Facture          varchar(11) default '',                 -- Numéro de facture
  Type_Ligne           char(3) default 'P',                    -- type ligne : P période, V vente dans la période, D détail de la vente
  Date_Deb             bigint unsigned default 0,              -- date de début de la période de commissionnement
  Date_Fin             bigint unsigned default 0,              -- date de fin de la période de commissionnement
  Total_Commission     decimal(14,2) default 0,                -- montant de la commission
  Stock                tinyint unsigned default 0,             -- articles du stock (oui/non)
  primary key (Commissionnement_Id, Rank),
  index idx_famille_1 (Famille_1),
  index idx_famille_2 (Famille_2),
  index idx_famille_3 (Famille_3),
  index idx_marque_id (Marque_Id),
  constraint cfk_ligne_commissionnement_marque_id foreign key (Marque_Id) references MARQUE_ARTICLE (Marque_Id),
  constraint cfk_ligne_commissionnement_famille_1 foreign key (Famille_1) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_ligne_commissionnement_famille_2 foreign key (Famille_2) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_ligne_commissionnement_famille_3 foreign key (Famille_3) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_ligne_commissionnement_commissionnement_id foreign key (Commissionnement_Id) references COMMISSIONNEMENT (Commissionnement_Id)
) engine=InnoDB;


-- ------------------------- ASSOCIATION DE FICHIERS -------------------------------------------------------


create table FICHIER_ASSOC (
  Fichier_Assoc_Id  int unsigned not null auto_increment,  -- identifiant du fichier
  Document_Id       varchar(20) not null default '',       -- code du document
  Type              varchar(20) default '',                -- type de document
  Lien              varchar(255) default '',               -- lien complet vers le fichier
  Nom               varchar(255) default '',               -- nom du fichier
  primary key (Fichier_Assoc_Id)
) engine=InnoDB;


-- ------------------------- GESTION MULTI-SITES MULTI-STOCKS ----------------------------------------------

create table SITE (
  Site_Id           int unsigned not null auto_increment,  -- identifiant du site
  Intitule          varchar(30) default '',                -- intitulé du site
  Denomination      varchar(50) default '',                -- dénomination sociale
  Adresse_1         varchar(80) default '',                -- ligne d'adresse 1
  Adresse_2         varchar(50) default '',                -- ligne d'adresse 2
  Adresse_3         varchar(50) default '',                -- ligne d'adresse 3
  Code_Postal       varchar(10) default '',                -- code postal
  Ville             varchar(50) default '',                -- ville
  Code_Pays         char(2) default 'FR',                  -- code pays
  Tel               varchar(20) default '',
  Fax               varchar(20) default '',
  Email             varchar(64) default '',
  Numero_TVA        varchar(14) default '',                -- Numéro de TVA intracommunautaire
  Stock_Defaut      int unsigned default 0,                -- identifiant du stock par défaut relié à ce site
  primary key (Site_Id)
) engine=InnoDB;


create table STOCK (
  Stock_Id          int unsigned not null auto_increment,  -- identifiant du stock
  Intitule          varchar(30) default '',                -- intitulé du stock
  Denomination      varchar(50) default '',                -- dénomination sociale
  Adresse_1         varchar(80) default '',                -- ligne d'adresse 1
  Adresse_2         varchar(50) default '',                -- ligne d'adresse 2
  Adresse_3         varchar(50) default '',                -- ligne d'adresse 3
  Code_Postal       varchar(10) default '',                -- code postal
  Ville             varchar(50) default '',                -- ville
  Code_Pays         char(2) default 'FR',                  -- code pays
  primary key (Stock_Id)
) engine=InnoDB;


create table STATUT_MVT_STOCK (
  Statut_Id         int unsigned not null auto_increment,  -- Identifiant du statut
  Libelle           varchar(30) default '',                -- Libellé du statut
  primary key (Statut_Id)
) engine=InnoDB;


-- ------------------------- INVENTAIRE --------------------------------------------------------------------


create table INVENTAIRE (
  Inventaire_Id     int unsigned not null auto_increment,   -- identifiant de l'inventaire
  Type_Inventaire   char(1) default 'C',                    -- type inventaire (P=Partiel, C=Complet)
  Marque_Id         int unsigned default null,              -- critère marque
  Famille_1         int unsigned default null,              -- critère famille 1
  Famille_2         int unsigned default null,              -- critère famille 2
  Famille_3         int unsigned default null,              -- critère famille 3
  Etat              char(1) default 'O',                    -- état de l'inventaire (O=Ouvert, C=Cloturé, A=Annulé)
  Date_Cloture      bigint unsigned default 0,              -- date de cloture
  Date_Ouverture    bigint unsigned default 0,              -- date d'ouverture
  Date_Annulation   bigint unsigned default 0,              -- date d'annulation
  primary key (Inventaire_Id),
  index idx_famille_1 (Famille_1),
  index idx_famille_2 (Famille_2),
  index idx_famille_3 (Famille_3),
  index idx_marque_id (Marque_Id),
  constraint cfk_inventaire_marque_id foreign key (Marque_Id) references MARQUE_ARTICLE (Marque_Id),
  constraint cfk_inventaire_famille_1 foreign key (Famille_1) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_inventaire_famille_2 foreign key (Famille_2) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_inventaire_famille_3 foreign key (Famille_3) references FAMILLE_ARTICLE (Famille_Id)
) engine=InnoDB;


create table ARTICLE_INVENTAIRE (
  Ligne_Id          int unsigned not null auto_increment,  -- identifiant de la ligne
  Article_Id        char(40) not null,                     -- identifiant de l'article
  Inventaire_Id     int unsigned not null,                 -- identifiant de l'inventaire
  Qte_Theorique     decimal(12,3) default 0,               -- quantité théorique avant inventaire
  Qte_Inventaire    decimal(12,3) default 0,               -- quantité inventoriée
  Valide            tinyint unsigned default 0,            -- inventaire effectué
  Valorisation      decimal(14,2) unsigned default 0,      -- Valorisation unitaire de la quantité inventoriée
  primary key (Ligne_Id),
  unique(Inventaire_Id, Article_Id),
  index idx_article_id (Article_Id),
  index idx_inventaire_id (Inventaire_Id),
  constraint cfk_article_inventaire_article_id foreign key (Article_Id) references FICHE_ARTICLE (Article_Id),
  constraint cfk_article_inventaire_inventaire_id foreign key (Inventaire_Id) references INVENTAIRE (Inventaire_Id)
) engine=InnoDB;



-- ------------------------- SUIVI D'ACTIVITE --------------------------------------------------------------


create table PARAMETRES (
  Activite char(1) not null,       -- V pour vente de marchandises, P pour production, D pour les deux
  Marge_Com int,                   -- Marge comerciale, en pourcentage
  Marge_Prod int,                  -- Marge brute de production, en pourcentages
  Inventaire_Permanent char(1),    -- L'inventaire est-il permanent ? y pour yes, n pour no
  Coefficient_Saisonnier char(1)   -- Y a t-il des coefficients ssaisonniers ? y pour yes, n pour no
) engine=InnoDB;


create table COEF_SAISONS (
  Mois int  not null,          -- numéro de mois, de 1..12 pour janvier..decembre
  Coefficient int not null,    -- pourcentage correspondant au mois
  primary key (Mois)
) engine=InnoDB;


create table SAUVE_MC (
  Id_Budget int not null,      -- Identifiant du budget
  Mois int not null,           -- Mois concernant la marge
  Annee int not null,          -- Annee concernant la marge
  Marge int not null,          -- Marge en pourcentage
  primary key (Id_Budget,Mois, Annee)
) engine=InnoDB;


create table SAUVE_MP (
  Id_Budget int not null,      -- Identifiant du budget
  Mois int not null,           -- Mois concernant la marge
  Annee int not null,          -- Annee concernant la marge
  Marge int not null,          -- Marge en pourcentage
  primary key (Id_Budget,Mois, Annee)
) engine=InnoDB;


create table SAUVE_SAISIES (
  Id_Budget      int not null,            -- Identifiant du budget
  Numero_Compte  varchar(8) not null,     -- Numéro de compte
  Mois           int not null,            -- Mois concernant la marge
  Annee          int not null,            -- Annee concernant la marge
  Montant        bigint not null,         -- Montant à sauvegarder
  primary key (Id_Budget,Numero_Compte, Mois, Annee)
) engine=InnoDB;


create table SAUVE_RESULTATS (
  Id_Budget  int not null,       -- Identifiant du budget
  Libelle    char(2) not null,   -- CA pour chiffre d'affaires, AD pour achats directs et sous traitance,
                                 -- CP pour charges de personnel, CE pour charges externes
                                 -- IT pour autres impots et taxes, AM pour amortissements, CF pour charges financieres
  Mois       int not null,       -- Mois concernant la marge
  Annee      int not null,       -- Annee concernant la marge
  Montant    bigint not null,    -- Montant à sauvegarder
  primary key (Id_Budget,Libelle, Mois, Annee)
) engine=InnoDB;


create table BUDGET (
  Id_Budget        int not null,     -- Identifiant du budget
  Mois_Debut       int not null,     -- Mois de début du budget
  Annee_Debut      int not null,     -- Annee de début du budget
  Mois_Fin         int not null,     -- Mois de fin du budget
  Annee_Fin        int not null,     -- Annee de fin du budget
  Mois_Debut_Ref   int not null,     -- Mois de reférence de début du budget
  Annee_Debut_Ref  int not null,     -- Annee de reférence de début du budget
  Mois_Fin_Ref     int not null,     -- Mois de reférence de fin du budget
  Annee_Fin_Ref    int not null,     -- Annee de reférence de fin du budget
  primary key (Id_Budget)
) engine=InnoDB;


-- ------------------------- CHAMPS PERSONNALISES ----------------------------------------------------------

create table CHAMP_PERSO (
  Champ_Perso_Id  int unsigned not null auto_increment,   -- Code du champ perso
  Libelle         varchar(50) default '',                 -- Libellé du champ perso
  Type            char(2) default 'CC',                   -- Type du champ (CC: case à cocher, ZT: zone de texte, CT: champ texte, ND: champ numérique décimal, NE: champ numérique entier, LD: liste déroulante, BR: bouton radio, LP: liste perso)
  Famille_1       int unsigned default null,              -- Famille d'article 1
  Famille_2       int unsigned default null,              -- Famille d'article 2
  Famille_3       int unsigned default null,              -- Famille d'article 3
  primary key (Champ_Perso_Id),
  index idx_famille_1 (Famille_1),
  index idx_famille_2 (Famille_2),
  index idx_famille_3 (Famille_3),
  constraint cfk_champ_perso_famille_1 foreign key (Famille_1) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_champ_perso_famille_2 foreign key (Famille_2) references FAMILLE_ARTICLE (Famille_Id),
  constraint cfk_champ_perso_famille_3 foreign key (Famille_3) references FAMILLE_ARTICLE (Famille_Id)
) engine=InnoDB;


create table OPTION_CHAMP_PERSO (
  Liste_Id        int unsigned not null auto_increment,   -- Code de la valeur d'une liste
  Libelle         varchar(50) default '',                 -- Libellé de l'élément de liste
  Valeur          varchar(50) default '',                 -- Valeur de l'élément
  Champ_Perso_Id  int unsigned not null,                  -- Code du champ perso
  primary key (Liste_Id),
  index idx_champ_perso_id (Champ_Perso_Id),
  constraint cfk_option_champ_perso_champ_perso_id foreign key (Champ_Perso_Id) references CHAMP_PERSO (Champ_Perso_Id)
) engine=InnoDB;


create table CHAMP_PERSO_ARTICLE (
  Champ_Perso_Id  int unsigned not null,                  -- Code du champ perso
  Article_Id      char(40) not null,                      -- Identifiant fiche article
  Valeur          varchar(50) default '',                 -- Valeur de l'élément
  primary key (Champ_Perso_Id, Article_Id),
  constraint cfk_champ_perso_article_champ_perso_id foreign key (Champ_Perso_Id) references CHAMP_PERSO (Champ_Perso_Id)
) engine=InnoDB;


create table COLONNE_LISTE_PERSO (
  Colonne_Id      int unsigned not null auto_increment,   -- Code de la colonne
  Libelle         varchar(50) default '',                 -- Libellé de la colonne
  Champ_Perso_Id  int unsigned not null,                  -- Code du champ perso
  primary key (Colonne_Id),
  index idx_champ_perso_id (Champ_Perso_Id),
  constraint cfk_colonne_liste_perso_champ_perso_id foreign key (Champ_Perso_Id) references CHAMP_PERSO (Champ_Perso_Id)
) engine=InnoDB;


create table LIGNE_LISTE_PERSO_ARTICLE (
  Ligne_Id        int unsigned not null auto_increment,   -- Code de la ligne
  Champ_Perso_Id  int unsigned not null,                  -- Code du champ perso
  Article_Id      char(40) not null,                      -- Identifiant fiche article
  primary key (Ligne_Id),
  index idx_champ_perso_id (Champ_Perso_Id),
  constraint cfk_ligne_liste_perso_article_champ_perso_id foreign key (Champ_Perso_Id) references CHAMP_PERSO (Champ_Perso_Id)
) engine=InnoDB;


create table CELLULE_LISTE_PERSO_ARTICLE (
  Ligne_Id        int unsigned not null,                  -- Code de la ligne
  Colonne_Id      int unsigned not null,                  -- Code de la colonne
  Valeur          varchar(50) default '',                 -- Valeur de l'élément
  primary key (Ligne_Id, Colonne_Id),
  constraint cfk_cellule_liste_perso_article_ligne_id foreign key (Ligne_Id) references LIGNE_LISTE_PERSO_ARTICLE (Ligne_Id),
  constraint cfk_cellule_liste_perso_article_colonne_id foreign key (Colonne_Id) references COLONNE_LISTE_PERSO (Colonne_Id)
) engine=InnoDB;


create table PARAM_PAYS_WEB (
  Code_Pays         char(2) not null,                   -- Code pays de l'UE
  Site_Id           int unsigned default null,          -- id du site Physique
  primary key (Code_Pays)
) engine=InnoDB;


-- ------------------------- SUIVI DES N° LOT --------------------------------------------------------------

create table NUM_LOT_BLOQUE (
  Num_Lot             varchar(15) default '',               -- numéro de lot
  primary key (Num_Lot)
) engine=InnoDB;


-- ------------------------------- MENTIONS -----------------------------------------------------------------


create table MENTION_CLIENT (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Client_Id          char(10) not null,                    -- Identifiant du client
  primary key (Mention_Id, Client_Id),
  constraint cfk_mention_client_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_client_client_id foreign key (Client_Id) references FICHE_CLIENT (Client_Id) on update cascade
) engine=InnoDB;


create table MENTION_FAMILLE_CLIENT (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Famille_Id         int unsigned not null,                -- Identifiant de la famille de client
  primary key (Mention_Id, Famille_Id),
  constraint cfk_mention_famille_client_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_famille_client_famille_id foreign key (Famille_Id) references FAMILLE_CLIENT (Famille_Id)
) engine=InnoDB;


create table MENTION_DEVIS (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Devis_Id           int unsigned not null,                -- Identifiant du devis
  primary key (Mention_Id, Devis_Id),
  constraint cfk_mention_devis_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_devis_devis_id foreign key (Devis_Id) references DEVIS (Devis_Id)
) engine=InnoDB;


create table MENTION_COMMANDE_CLIENT (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Commande_Id        int unsigned not null,                -- Identifiant de la commande client
  primary key (Mention_Id, Commande_Id),
  constraint cfk_mention_commande_client_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_commande_client_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id)
) engine=InnoDB;


create table MENTION_BON_LIVRAISON (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Bon_Id             int unsigned not null,                -- Identifiant du bon de livraison
  primary key (Mention_Id, Bon_Id),
  constraint cfk_mention_bon_livraison_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_bon_livraison_bon_id foreign key (Bon_Id) references BON_LIVRAISON (Bon_Id)
) engine=InnoDB;


create table MENTION_BON_RETOUR_CLIENT (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Bon_Id             int unsigned not null,                -- Identifiant du bon de retour client
  primary key (Mention_Id, Bon_Id),
  constraint cfk_mention_bon_retour_client_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_bon_retour_client_bon_id foreign key (Bon_Id) references BON_RETOUR_CLIENT (Bon_Id)
) engine=InnoDB;


create table MENTION_FACTURE (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Facture_Id         int unsigned not null,                -- Identifiant de la facture
  primary key (Mention_Id, Facture_Id),
  constraint cfk_mention_facture_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_facture_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id)
) engine=InnoDB;


create table MENTION_AVOIR (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Avoir_Id           int unsigned not null,                -- Identifiant de l'avoir
  primary key (Mention_Id, Avoir_Id),
  constraint cfk_mention_avoir_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_avoir_avoir_id foreign key (Avoir_Id) references AVOIR (Avoir_Id)
) engine=InnoDB;


create table MENTION_FACTURE_FOURNISSEUR (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Facture_Id         int unsigned not null,                -- Identifiant de la facture
  primary key (Mention_Id, Facture_Id),
  constraint cfk_mention_facture_fournisseur_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_facture_fournisseur_facture_id foreign key (Facture_Id) references FACTURE_FOURNISSEUR (Facture_Id)
) engine=InnoDB;


create table MENTION_AVOIR_FOURNISSEUR (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Avoir_Id           int unsigned not null,                -- Identifiant de l'avoir
  primary key (Mention_Id, Avoir_Id),
  constraint cfk_mention_avoir_fournisseur_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_avoir_fournisseur_avoir_id foreign key (Avoir_Id) references AVOIR_FOURNISSEUR (Avoir_Id)
) engine=InnoDB;


create table MENTION_COMMANDE_FOURNISSEUR (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Commande_Id        int unsigned not null,                -- Identifiant de la commande
  primary key (Mention_Id, Commande_Id),
  constraint cfk_mention_commande_fournisseur_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_commande_fournisseur_commande_id foreign key (Commande_Id) references COMMANDE_FOURNISSEUR (Commande_Id)
) engine=InnoDB;


create table MENTION_BON_RECEPTION (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Bon_Id             int unsigned not null,                -- Identifiant du bon de réception
  primary key (Mention_Id, Bon_Id),
  constraint cfk_mention_bon_reception_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_bon_reception_bon_id foreign key (Bon_Id) references BON_RECEPTION (BR_Id)
) engine=InnoDB;


create table MENTION_BON_RETOUR_FOURNISSEUR (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Bon_Id             int not null,                         -- Identifiant du bon de retour fournisseur
  primary key (Mention_Id, Bon_Id),
  constraint cfk_mention_bon_retour_fournisseur_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_bon_retour_fournisseur_bon_id foreign key (Bon_Id) references BON_RETOUR_FOURNISSEUR (Bon_Id)
) engine=InnoDB;


create table MENTION_ABONNEMENT (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Abonnement_Id      int unsigned not null,                -- Identifiant de l'abonnement
  primary key (Mention_Id, Abonnement_Id),
  constraint cfk_mention_abonnement_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_abonnement_abonnement_id foreign key (Abonnement_Id) references ABONNEMENT (Abonnement_Id)
) engine=InnoDB;


create table MENTION_MODELE (
  Mention_Id         int unsigned not null,                -- Identifiant de la mention
  Modele_Id          int unsigned not null,                -- Identifiant du modèle
  primary key (Mention_Id, Modele_Id),
  constraint cfk_mention_modele_mention_id foreign key (Mention_Id) references LISTE_MENTIONS (Mention_Id),
  constraint cfk_mention_modele_modele_id foreign key (Modele_Id) references MODELE (Modele_Id)
) engine=InnoDB;


-- ------------------- Gestion des versions de documents ----------------------------------------------


create table VERSION_DOCUMENT (
  Version_Id       int unsigned not null auto_increment,   -- Idenfiant de la version
  Num_Version      int unsigned default 0,                 -- Numéro de version
  Date_Edition     bigint unsigned default 0,              -- Date d'édition du document
  Util_E           int not null,                           -- Idenfiant de l'utilisateur
  Email            varchar(64) default '',                 -- Email auquel on envoie le document sinon vide
  primary key (Version_Id)
) engine=InnoDB;


create table VERSION_COMMANDE_CLIENT (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Commande_Id      int unsigned not null,   -- Identifiant de la commande client
  primary key (Version_Id, Commande_Id),
  constraint cfk_version_commande_client_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_commande_client_commande_id foreign key (Commande_Id) references COMMANDE_CLIENT (Commande_Id)
) engine=InnoDB;


create table VERSION_FACTURE (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Facture_Id       int unsigned not null,   -- Identifiant de la facture client
  primary key (Version_Id, Facture_Id),
  constraint cfk_version_facture_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_facture_facture_id foreign key (Facture_Id) references FACTURE (Facture_Id)
) engine=InnoDB;


create table VERSION_AVOIR (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Avoir_Id         int unsigned not null,   -- Identifiant de l'avoir client
  primary key (Version_Id, Avoir_Id),
  constraint cfk_version_avoir_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_avoir_avoir_id foreign key (Avoir_Id) references AVOIR (Avoir_Id)
) engine=InnoDB;


create table VERSION_PROFORMA (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Proforma_Id      int unsigned not null,   -- Identifiant de la facture proforma
  primary key (Version_Id, Proforma_Id),
  constraint cfk_version_proforma_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_proforma_proforma_id foreign key (Proforma_Id) references PROFORMA (Proforma_Id)
) engine=InnoDB;


create table VERSION_DEVIS (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Devis_Id         int unsigned not null,   -- Identifiant du devis
  primary key (Version_Id, Devis_Id),
  constraint cfk_version_devis_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_devis_devis_id foreign key (Devis_Id) references DEVIS (Devis_Id)
) engine=InnoDB;


create table VERSION_ACOMPTE_CLIENT (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Acompte_Id       int unsigned not null,   -- Identifiant de l'acompte
  primary key (Version_Id, Acompte_Id),
  constraint cfk_version_acompte_client_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_acompte_client_acompte_id foreign key (Acompte_Id) references ACOMPTE_CLIENT (Acompte_Id)
) engine=InnoDB;


create table VERSION_COMMANDE_FOURNISSEUR (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Commande_Id      int unsigned not null,   -- Identifiant de la commande fournisseur
  primary key (Version_Id, Commande_Id),
  constraint cfk_version_commande_fournisseur_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_commande_fournisseur_commande_id foreign key (Commande_Id) references COMMANDE_FOURNISSEUR (Commande_Id)
) engine=InnoDB;


create table VERSION_FACTURE_FOURNISSEUR (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Facture_Id       int unsigned not null,   -- Identifiant de la facture fournisseur
  primary key (Version_Id, Facture_Id),
  constraint cfk_version_facture_fournisseur_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_facture_fournisseur_facture_id foreign key (Facture_Id) references FACTURE_FOURNISSEUR (Facture_Id)
) engine=InnoDB;


create table VERSION_ACOMPTE_FOURNISSEUR (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Acompte_Id       int not null,            -- Identifiant de l'acompte
  primary key (Version_Id, Acompte_Id),
  constraint cfk_version_acompte_fournisseur_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_acompte_fournisseur_acompte_id foreign key (Acompte_Id) references ACOMPTE_FOURNISSEUR (Acompte_Id)
) engine=InnoDB;


create table VERSION_AVOIR_FOURNISSEUR (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Avoir_Id         int unsigned not null,   -- Identifiant de l'avoir fournisseur
  primary key (Version_Id, Avoir_Id),
  constraint cfk_version_avoir_fournisseur_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_avoir_fournisseur_avoir_id foreign key (Avoir_Id) references AVOIR_FOURNISSEUR (Avoir_Id)
) engine=InnoDB;


create table VERSION_BON_RETOUR_CLIENT (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Bon_Id           int unsigned not null,   -- Identifiant du bon de retour client
  primary key (Version_Id, Bon_Id),
  constraint cfk_version_bon_retour_client_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_bon_retour_client_bon_id foreign key (Bon_Id) references BON_RETOUR_CLIENT (Bon_Id)
) engine=InnoDB;


create table VERSION_BON_RECEPTION (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Bon_Id           int unsigned not null,   -- Identifiant du bon de réception
  primary key (Version_Id, Bon_Id),
  constraint cfk_version_bon_reception_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_bno_reception_bon_id foreign key (Bon_Id) references BON_RECEPTION (BR_Id)
) engine=InnoDB;


create table VERSION_BON_LIVRAISON (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Bon_Id           int unsigned not null,   -- Identifiant du bon de livraison
  primary key (Version_Id, Bon_Id),
  constraint cfk_version_bon_livraison_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_bon_livraison_bon_id foreign key (Bon_Id) references BON_LIVRAISON (Bon_Id)
) engine=InnoDB;


create table VERSION_BON_RETOUR_FOURNISSEUR (
  Version_Id       int unsigned not null,   -- Identifiant de la version
  Bon_Id           int not null,            -- Identifiant du bon de retour fournisseur
  primary key (Version_Id, Bon_Id),
  constraint cfk_version_bon_retour_fournisseur_version_id foreign key (Version_Id) references VERSION_DOCUMENT (Version_Id),
  constraint cfk_version_bon_retour_fournisseur_bon_id foreign key (Bon_Id) references BON_RETOUR_FOURNISSEUR (Bon_Id)
) engine=InnoDB;




-- ---------------------- RAPPROCHEMENT BANCAIRE ------------------------------------------------------


create table RAPPROCHEMENT (
  Rappro_Id              int unsigned not null auto_increment,  -- Identifiant du rapprochement
  Date_Rappro            bigint unsigned default 0,             -- Date de début du rapprochement
  Num_Releve             varchar(15) default '',                -- Numéro du relevé bancaire
  Date_Releve            bigint unsigned default 0,             -- Date du relevé bancaire
  Solde_Releve           decimal(16,2) default 0,               -- Solde du relevé bancaire
  Date_Cloture           bigint unsigned default 0,             -- Date de cloture du rapprochement
  Type_Rappro            char(1) default 'C',                   -- Type de rapprochement (C=par Compte, J=par Journal)
  Code_Journal           char(3) default null,                  -- Code journal si rapprochement par journal
  Numero_Compte          char(8) not null,                      -- Numéro de compte (Contrepartie si rappro par journal, Compte à utiliser sinon)
  Solde_Final            decimal(16,2) default 0,               -- Solde final
  primary key (Rappro_Id),
  index idx_code_journal (Code_Journal),
  index idx_numero_compte (Numero_Compte),
  constraint cfk_rapprochement_numero_compte foreign key (Numero_Compte) references COMPTE (Numero_Compte),
  constraint cfk_rapprochement_code_journal foreign key (Code_Journal) references JOURNAL (Code_Journal)
) engine=InnoDB;


create table LIGNE_RAPPROCHEMENT (
  Ligne_Rappro_Id        int unsigned not null auto_increment,  -- Identifiant de la ligne de rapprochement
  Rappro_Id              int unsigned not null,                 -- Identifiant du rapprochement
  Op_Id                  int unsigned not null,                 -- Identifiant de l'opération
  Pointage               tinyint unsigned default 0,            -- Pointage de la ligne (oui/non)
  Nom_Base               varchar(16) default '',                -- Nom de la base d'exercice
  primary key (Ligne_Rappro_Id),
  index idx_op_id (Op_Id),
  index idx_rappro_id (Rappro_Id),
  constraint cfk_ligne_rapprochement_rappro_id foreign key (Rappro_Id) references RAPPROCHEMENT (Rappro_Id)
) engine=InnoDB;


create table LIGNE_RB (
  Ligne_RB_Id        int unsigned not null auto_increment,  -- Identifiant de la ligne de RB
  Rappro_Id          int unsigned not null,                 -- Identifiant du rapprochement
  Montant_D          decimal(14,2) unsigned default 0,      -- Montant de la ligne si débit sinon 0
  Montant_C          decimal(14,2) unsigned default 0,      -- Montant de la ligne si crédit sinon 0
  Libelle            varchar(100) default '',               -- Libellé de la ligne
  Pointage           tinyint unsigned default 0,            -- Pointage de la ligne (oui/non)
  Date_Op            bigint unsigned default 0,             -- Date opération RB
  primary key (Ligne_RB_Id),
  index idx_rappro_id (Rappro_Id),
  constraint cfk_ligne_rb_rappro_id foreign key (Rappro_Id) references RAPPROCHEMENT (Rappro_Id)
) engine=InnoDB;


-- --------------------------- NUMEROTATION -------------------------------------------------------------------


create table FORMAT_NUMEROTATION (
  Format_Id          int not null auto_increment,           -- Identifiant du format
  Pattern            varchar(20) default '',                -- Modèle de numérotation
  Periode_Init       char(1) default 'N',                   -- Périodicité de réinitialisation du numéro (N=Néant, A=Année, M=Mois)
  Numero_Init        int unsigned default 1,                -- Numéro d'initialisation
  primary key (Format_Id)
) engine=InnoDB;



-- --------------------------- MODELES DE DOCUMENT ------------------------------------------------------------


create table MODELE_FACTURE_CLIENT (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_AVOIR_CLIENT (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_COMMANDE_CLIENT (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_COMMANDE_FOURNISSEUR (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_FACTURE_FOURNISSEUR (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_AVOIR_FOURNISSEUR (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_DEVIS (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_BON_LIVRAISON (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_BON_RECEPTION (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_BON_PREPARATION (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_ACOMPTE_CLIENT (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_ACOMPTE_FOURNISSEUR (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_BON_RETOUR_CLIENT (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;


create table MODELE_BON_RETOUR_FOURNISSEUR (
  Modele_Id      char(5) not null,          -- Identifiant modèle
  Description    varchar(50) default '',    -- Description du modèle
  Class          varchar(100) default '',   -- Class java
  primary key (Modele_Id)
) engine=InnoDB;




-- --------------------------- GESTIONNAIRE D'OUTILS ----------------------------------------------------------


create table OUTIL (
  Outil_Id          int unsigned not null auto_increment,   -- Identifiant de l'outil
  Numero            int unsigned default 0,                 -- Numéro de l'outil
  Forme             varchar(30) default '',                 -- Forme
  Categorie         varchar(30) default '',                 -- Catégorie
  Type              varchar(20) default '',                 -- Type
  Diametre          decimal(6,2) unsigned default 0,        -- Diamètre
  Rayon             decimal(6,2) unsigned default 0,        -- Rayon
  Longueur          decimal(6,2) unsigned default 0,        -- Longueur
  Largeur           decimal(6,2) unsigned default 0,        -- Largeur
  Hauteur           decimal(6,2) unsigned default 0,        -- Hauteur
  Haut_Lame         decimal(6,2) unsigned default 0,        -- Hauteur de lame
  primary key (Outil_Id)
) engine=InnoDB;



-- --------------------------- Paramètrages du dossier ---------------------------------------------------------

create table PARAM_DOSSIER (
  Mode_Tarif                  char(1) default 'G',               -- Mode de tarification (G=Grille,Q=Quantité)
  Date_Factu                  bigint unsigned default 0,         -- Date limite de facturation
  Com_Devis                   text,                              -- Commentaires imprimables sur tous les devis
  Com_Fact                    text,                              -- Commentaires imprimables sur toutes les factures
  Com_BL                      text,                              -- Commentaires imprimables sur tous les BLs
  Imp_Nom_Devis               tinyint unsigned default 0,        -- Impression nomenclature sur devis
  Imp_Nom_OF                  tinyint unsigned default 0,        -- Impression nomenclature sur of
  Imp_Nom_Facture             tinyint unsigned default 0,        -- Impression nomenclature sur facture
  Imp_Nom_Bon                 tinyint unsigned default 0,        -- Impression nomenclature sur bl
  Imp_Nom_Fiche               tinyint unsigned default 0,        -- Impression nomenclature sur fiche
  Imp_Nom_BP                  tinyint unsigned default 0,        -- Impression nomenclature sur BP
  Imp_Nom_BCF                 tinyint unsigned default 0,        -- Impression nomenclature sur BC fournisseur
  Imp_Desc1_Devis             tinyint unsigned default 0,        -- Impression description 1 sur devis
  Imp_Desc1_OF                tinyint unsigned default 0,        -- Impression description 1 sur of
  Imp_Desc1_Facture           tinyint unsigned default 0,        -- Impression description 1 sur facture
  Imp_Desc1_Bon               tinyint unsigned default 0,        -- Impression description 1 sur bl
  Imp_Desc1_Fiche             tinyint unsigned default 0,        -- Impression description 1 sur fiche
  Imp_Desc1_BP                tinyint unsigned default 0,        -- Impression description 1 sur BP
  Imp_Desc1_BCF               tinyint unsigned default 0,        -- Impression description 1 sur BC fournisseur
  Imp_Desc2_Devis             tinyint unsigned default 0,        -- Impression description 2 sur devis
  Imp_Desc2_OF                tinyint unsigned default 0,        -- Impression description 2 sur of
  Imp_Desc2_Facture           tinyint unsigned default 0,        -- Impression description 2 sur facture
  Imp_Desc2_Bon               tinyint unsigned default 0,        -- Impression description 2 sur bl
  Imp_Desc2_Fiche             tinyint unsigned default 0,        -- Impression description 2 sur fiche
  Imp_Desc2_BP                tinyint unsigned default 0,        -- Impression description 2 sur BP
  Imp_Desc2_BCF               tinyint unsigned default 0,        -- Impression description 2 sur BC fournisseur
  Coeff_1                     decimal(7,5) default 1.1,          -- Coefficient tarif 1 par défaut
  Coeff_2                     decimal(7,5) default 1.2,          -- Coefficient tarif 2 par défaut
  Coeff_3                     decimal(7,5) default 1.3,          -- Coefficient tarif 3 par défaut
  Coeff_4                     decimal(7,5) default 1.4,          -- Coefficient tarif 4 par défaut
  Coeff_5                     decimal(7,5) default 1.5,          -- Coefficient tarif 5 par défaut
  Logo_Adr                    tinyint unsigned default 0,        -- Le logo contient les infos de la société (0=non,1=oui)
  Code_Journal_Achat          char(3) default null,              -- Code journal d'achat par défaut
  Code_Journal_Vente          char(3) default null,              -- Code journal de vente par défaut
  Code_Journal_Regul          char(3) default null,              -- Code journal de régularisation par défaut
  Code_Journal_AN             char(3) not null,                  -- Code journal d'à nouveau par défaut
  Code_Journal_Acpte          char(3) default null,              -- Code journal pour les acomptes reçus
  Code_Journal_Acpte_AC       char(3) default null,              -- Code journal pour les acomptes versés
  Numero_Compte_Clients       char(8) default null,              -- Compte clients divers
  Numero_Compte_Fournisseurs  char(8) default null,              -- Compte fournisseurs divers
  Numero_Compte_Port_AC       char(8) default null,              -- Compte frais de port à l'achat
  Numero_Compte_Port_VE       char(8) default null,              -- Compte frais de port à la vente
  Numero_Compte_Escompte_AC   char(8) default null,              -- Compte d'escompte à l'achat
  Numero_Compte_Escompte_VE   char(8) default null,              -- Compte d'escompte à la vente
  Numero_Compte_Acompte_AC    char(8) default null,              -- Compte d'acompte sur achats
  Numero_Compte_Acompte_VE    char(8) default null,              -- Compte d'acompte sur vente
  Numero_Compte_Regul_AC      char(8) default null,              -- Compte de régularisation des paiements à l'achat
  Numero_Compte_Regul_VE      char(8) default null,              -- Compte de régularisation des paiements à la vente
  Numero_Compte_Tva_Due_IC    char(8) default null,              -- Compte de TVA due intracommunautaire
  Numero_Compte_Tva_Ded_IC    char(8) default null,              -- Compte de TVA déductible sur biens et service Union européenne
  Numero_Compte_Especes       char(8) default null,              -- Compte de virements internes (pour remises espèces)
  Numero_Compte_Attente_BQ    char(8) default null,              -- Compte d'écritures de banque en attente
  Modele_Etiquette            varchar(10) not null,              -- Modèle d'étiquette par défaut
  Lien_Fichier                varchar(100) default 'file://',    -- debut du lien des fichiers
  Lien_Distant                varchar(100) default 'file://',    -- debut du lien de l'acces distant au fichier
  Dossier_Fichier             varchar(100) default '',           -- dossier ou sont les fichiers
  Vente_TTC                   tinyint unsigned default 0,        -- facturation par défaut en ht(0) ou ttc(1)
  Type_Calcul_Stock           tinyint unsigned default 0,        -- 0 = calcul standard, 1 = calcul avec réservation
  Calcul_Stock                tinyint unsigned default 0,        -- 0 = pas de calcul du stock en affaire, 1 = calcul du stock en affaire
  BL_Chiffre                  tinyint unsigned default 0,        -- 0 = BL non chiffré par défaut, 1 = BL chiffré par défaut
  BR_Chiffre                  tinyint unsigned default 0,        -- 0 = BR non chiffré par défaut, 1 = BR chiffré par défaut
  Imprimer_Adr_Liv            tinyint unsigned default 0,        -- 0 = ne pas afficher l'adresse de livraison si FR par défaut, 1 = afficher l'adresse de livraison par défaut
  Duree_Reservation           int unsigned default 0,            -- nombre de jours de réservation des produits 0 : pas de réservation
  Prefixe_Facture             varchar(3) default 'F',            -- préfixe de facture
  Prefixe_Avoir               varchar(3) default 'A',            -- préfixe d'avoir
  Act_Code_Stats              tinyint unsigned default 0,        -- activation du code statistique (1=oui,0=non)
  Produit_Frais               tinyint unsigned default 0,        -- vente de produits frais (1=oui,0=non)
  Niveau_Obligation_Intro     tinyint unsigned default 4,        -- niveau d'obligation à l'introduction
  Niveau_Obligation_Expe      tinyint unsigned default 4,        -- niveau d'obligation à l'expédition
  Code_Regime_Intro           tinyint unsigned default 11,       -- code de régime statistique à l'introduction pour la DEB
  Code_Regime_Expe            tinyint unsigned default 21,       -- code de régime statistique à l'expédition pour la DEB
  Nature_Transaction_Intro    tinyint unsigned default 11,       -- code de transaction à l'introduction pour la DEB
  Nature_Transaction_Expe     tinyint unsigned default 21,       -- code de transaction à l'expédition pour la DEB
  Conditions_Liv_Intro        char(3) default 'CFR',             -- code de conditions de livraisons à l'introduction pour la DEB
  Conditions_Liv_Expe         char(3) default 'CFR',             -- code de conditions de livraisons à l'expédition pour la DEB
  Mode_Transport_Intro        tinyint unsigned default 3,        -- mode de transport à l'introduction pour la DEB
  Mode_Transport_Expe         tinyint unsigned default 3,        -- mode de transport à l'expédition pour la DEB
  Imp_LCR                     tinyint unsigned default 0,        -- Impression des LCR sur les factures
  Imp_RIB                     tinyint unsigned default 0,        -- Impression du RIB sur la facture (si règlement=virement)
  Frais_Port_Prem             tinyint unsigned default 0,        -- Frais de port sur la première facture
  Mode_Rappro                 char(1) default 'C',               -- Mode de rapprochement bancaire (C=Compte,J=Journal)
  Label_Tarif_1               varchar(20) default 'Tarif 1',     -- Libellé du tarif 1
  Label_Tarif_2               varchar(20) default 'Tarif 2',     -- Libellé du tarif 2
  Label_Tarif_3               varchar(20) default 'Tarif 3',     -- Libellé du tarif 3
  Label_Tarif_4               varchar(20) default 'Tarif 4',     -- Libellé du tarif 4
  Label_Tarif_5               varchar(20) default 'Tarif 5',     -- Libellé du tarif 5
  Def_Mode_Envoi_Facture      char(1) default 'C',               -- Mode d'envoi de la facture par défaut (C=Courrier,F=Fax,M=Mail)
  Def_Periode_Facturation     char(1) default 'I',               -- Période de facturation par défaut (I=Immédiate,M=Fin de mois)
  Def_Mode_Facturation        char(1) default 'E',               -- Mode de facturation par défaut (E=A l'Expédition, C=A la Commande)
  Def_Type_Fact               char(2) default 'CC',              -- Type de facturation par défaut
  Def_Mode_Expedition         int unsigned default null,         -- Mode d'expédition des colis par défaut
  Timeout_Commande            int unsigned default 0,            -- Timeout de commande en jours (0=pas de timeout)
  Def_Etat_Rech_Log           char(2) default 'T',               -- Etat de recherche logistique par défaut
  Def_Etat_Rech_Com           char(1) default 'T',               -- Etat de recherche de commande/affaire par défaut
  Def_Etat_Rech_Com_Four      char(1) default 'T',               -- Etat de recherche de commande fournisseur par défaut
  Mode_Traitement             char(1) default 'C',               -- Mode de traitement par défaut des affaires (C=Commande, A=Affaire)
  Intitule_Ecr_Tiers          tinyint unsigned default 1,        -- Intitulé du compte de tiers sur toutes les lignes de l'écriture comptable (oui/non)
  Transfert_Enc               tinyint unsigned default 0,        -- Transfert des règlements dans des journaux d'encaissement
  Trans_Auto_Enc              tinyint unsigned default 0,        -- Transfert automatique des encaissements
  Trans_Auto_Rem              tinyint unsigned default 0,        -- Transfert automatique des remises en banque
  Trans_Auto_Regul            tinyint unsigned default 0,        -- Transfert automatique des régularisations sur clients
  Trans_Auto_Regul_AC         tinyint unsigned default 0,        -- Transfert automatique des régularisations sur fournisseurs
  Trans_Auto_Remb             tinyint unsigned default 0,        -- Transfert automatique des remboursements clients
  Trans_Auto_Remb_AC          tinyint unsigned default 0,        -- Transfert automatique des remboursements fournisseurs
  Trans_Auto_Reg_AC           tinyint unsigned default 0,        -- Transfert des règlements fournisseurs
  Ecr_Glob_Enc                tinyint unsigned default 1,        -- Ecriture globale d'encaissement
  Ecr_Glob_Rem                tinyint unsigned default 1,        -- Ecriture globale de remise en banque
  Ecr_Glob_Regul              tinyint unsigned default 1,        -- Ecriture globale de régularisation
  Ecr_Glob_Remb               tinyint unsigned default 1,        -- Ecriture globale de remboursement
  Module_Envoi                tinyint unsigned default 0,        -- Utilisation du module d'envoi des factures (0=non,1=oui)
  Format_NC                   int default null,                  -- Format de numérotation du numéro client
  Format_NF                   int default null,                  -- Format de numérotation du numéro fournisseur
  Format_NA                   int default null,                  -- Format de numérotation de la référence article
  Act_Commission              tinyint unsigned default 0,        -- Activation des commissions client
  Banque_Id                   int unsigned default null,         -- Banque par défaut
  Statut_Expe_Prep            tinyint unsigned default 0,        -- Gestion du statut d'expédition préparée (0=non,1=oui)
  Act_Code_Produit            tinyint unsigned default 0,        -- Activation du module de gestion des codes produits (0=non,1=oui)
  Act_Activation_CP           tinyint unsigned default 0,        -- Activation du module de gestion de l'activation des codes produits (0=non,1=oui)
  Act_Outillage               tinyint unsigned default 0,        -- Activation du module de gestion d'outillage (0=non,1=oui)
  Imp_Ex_Fact_Ent             tinyint unsigned default 1,        -- Impression d'un exemplaire de facture pour l'entreprise (0=non,1=oui)
  Email_VCC                   int unsigned default null,         -- Email à envoyer à la validation de commande
  Email_ACC                   int unsigned default null,         -- Email à envoyer à l'annulation de commande
  Email_ECC                   int unsigned default null,         -- Email à envoyer à l'expédition de commande
  Email_PCC                   int unsigned default null,         -- Email à envoyer à la préparation de commande
  Email_VFC                   int unsigned default null,         -- Email à envoyer à la validation de facture
  Email_VAC                   int unsigned default null,         -- Email à envoyer à la validation d'avoir
  Modele_Pdf_FC               char(5) not null,                  -- Modèle de facture pdf
  Modele_Pdf_AC               char(5) not null,                  -- Modèle d'avoir pdf
  Modele_Pdf_CC               char(5) not null,                  -- Modèle de commande client pdf
  Modele_Pdf_FF               char(5) not null,                  -- Modèle de facture fournisseur pdf
  Modele_Pdf_AF               char(5) not null,                  -- Modèle d'avoir fournisseur pdf
  Modele_Pdf_CF               char(5) not null,                  -- Modèle de commande fournisseur pdf
  Modele_Pdf_BL               char(5) not null,                  -- Modèle de bon de livraison pdf
  Modele_Pdf_BP               char(5) not null,                  -- Modèle de bon de préparation pdf
  Modele_Pdf_BR               char(5) not null,                  -- Modèle de bon de réception pdf
  Modele_Pdf_DC               char(5) not null,                  -- Modèle de devis pdf
  Modele_Pdf_RC               char(5) not null,                  -- Modèle de bon de retour client
  Modele_Pdf_RF               char(5) not null,                  -- Modèle de bon de retour fournisseur
  Modele_Pdf_FAC              char(5) not null,                  -- Modèle de facture d'acompte client
  Modele_Pdf_FAF              char(5) not null,                  -- Modèle de facture d'acompte fournisseur
  Alerte_Encours_Client       tinyint unsigned default 0,        -- Alerte sur dépassement encours client (oui/non)
  Rappel_Auto_Saisie          tinyint unsigned default 0,        -- Rappel automatique des écritures en saisie comptable (oui/non)
  Langue_Defaut               int not null,                      -- Langue par défaut du dossier
  Act_Analytique              tinyint unsigned default 0,        -- Activation du module de comptabilité analytique
  index idx_modele_pdf_fc (Modele_Pdf_FC),
  index idx_modele_pdf_ac (Modele_Pdf_AC),
  index idx_modele_pdf_cc (Modele_Pdf_CC),
  index idx_modele_pdf_ff (Modele_Pdf_FF),
  index idx_modele_pdf_af (Modele_Pdf_AF),
  index idx_modele_pdf_cf (Modele_Pdf_CF),
  index idx_modele_pdf_bl (Modele_Pdf_BL),
  index idx_modele_pdf_bp (Modele_Pdf_BP),
  index idx_modele_pdf_br (Modele_Pdf_BR),
  index idx_modele_pdf_dc (Modele_Pdf_DC),
  index idx_modele_pdf_rc (Modele_Pdf_RC),
  index idx_modele_pdf_rf (Modele_Pdf_RF),
  index idx_modele_pdf_fac (Modele_Pdf_FAC),
  index idx_modele_pdf_faf (Modele_Pdf_FAF),
  index idx_email_vcc (Email_VCC),
  index idx_email_acc (Email_ACC),
  index idx_email_ecc (Email_ECC),
  index idx_email_pcc (Email_PCC),
  index idx_email_vfc (Email_VFC),
  index idx_email_vac (Email_VAC),
  index idx_banque_id (Banque_Id),
  index idx_format_nc (Format_NC),
  index idx_format_nf (Format_NF),
  index idx_format_na (Format_NA),
  index idx_def_mode_expedition (Def_Mode_Expedition),
  index idx_code_journal_achat (Code_Journal_Achat),
  index idx_code_journal_vente (Code_Journal_Vente),
  index idx_code_journal_regul (Code_Journal_Regul),
  index idx_code_journal_an (Code_Journal_AN),
  index idx_code_journal_acpte_ac (Code_Journal_Acpte_AC),
  index idx_code_journal_acpte (Code_Journal_Acpte),
  index idx_numero_compte_clients (Numero_Compte_Clients),
  index idx_numero_compte_fournisseurs (Numero_Compte_Fournisseurs),
  index idx_numero_compte_port_ac (Numero_Compte_Port_AC),
  index idx_numero_compte_port_ve (Numero_Compte_Port_VE),
  index idx_numero_compte_escompte_ac (Numero_Compte_Escompte_AC),
  index idx_numero_compte_escompte_ve (Numero_Compte_Escompte_VE),
  index idx_numero_compte_acompte_ac (Numero_Compte_Acompte_AC),
  index idx_numero_compte_acompte_ve (Numero_Compte_Acompte_VE),
  index idx_numero_compte_regul_ac (Numero_Compte_Regul_AC),
  index idx_numero_compte_regul_ve (Numero_Compte_Regul_VE),
  index idx_numero_compte_tva_due_ic (Numero_Compte_Tva_Due_IC),
  index idx_numero_compte_tva_ded_ic (Numero_Compte_Tva_Ded_IC),
  index idx_numero_compte_especes (Numero_Compte_Especes),
  index idx_numero_compte_attente_bq (Numero_Compte_Attente_BQ),
  index idx_modele_etiquette (Modele_Etiquette),
  index idx_langue_defaut (Langue_Defaut),
  constraint cfk_param_dossier_email_vcc foreign key (Email_VCC) references EMAIL (Email_Id),
  constraint cfk_param_dossier_email_acc foreign key (Email_ACC) references EMAIL (Email_Id),
  constraint cfk_param_dossier_email_ecc foreign key (Email_ECC) references EMAIL (Email_Id),
  constraint cfk_param_dossier_email_pcc foreign key (Email_PCC) references EMAIL (Email_Id),
  constraint cfk_param_dossier_email_vfc foreign key (Email_VFC) references EMAIL (Email_Id),
  constraint cfk_param_dossier_email_vac foreign key (Email_VAC) references EMAIL (Email_Id),
  constraint cfk_param_dossier_modele_pdf_fc foreign key (Modele_Pdf_FC) references MODELE_FACTURE_CLIENT (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_ac foreign key (Modele_Pdf_AC) references MODELE_AVOIR_CLIENT (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_cc foreign key (Modele_Pdf_CC) references MODELE_COMMANDE_CLIENT (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_ff foreign key (Modele_Pdf_FF) references MODELE_FACTURE_FOURNISSEUR (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_af foreign key (Modele_Pdf_AF) references MODELE_AVOIR_FOURNISSEUR (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_cf foreign key (Modele_Pdf_CF) references MODELE_COMMANDE_FOURNISSEUR (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_bl foreign key (Modele_Pdf_BL) references MODELE_BON_LIVRAISON (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_bp foreign key (Modele_Pdf_BP) references MODELE_BON_PREPARATION (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_br foreign key (Modele_Pdf_BR) references MODELE_BON_RECEPTION (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_dc foreign key (Modele_Pdf_DC) references MODELE_DEVIS (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_rc foreign key (Modele_Pdf_RC) references MODELE_BON_RETOUR_CLIENT (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_rf foreign key (Modele_Pdf_RF) references MODELE_BON_RETOUR_FOURNISSEUR (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_fac foreign key (Modele_Pdf_FAC) references MODELE_ACOMPTE_CLIENT (Modele_Id),
  constraint cfk_param_dossier_modele_pdf_faf foreign key (Modele_Pdf_FAF) references MODELE_ACOMPTE_FOURNISSEUR (Modele_Id),
  constraint cfk_param_dossier_banque_id foreign key (Banque_Id) references BANQUE (Banque_Id),
  constraint cfk_param_dossier_format_nc foreign key (Format_NC) references FORMAT_NUMEROTATION (Format_Id),
  constraint cfk_param_dossier_format_nf foreign key (Format_NF) references FORMAT_NUMEROTATION (Format_Id),
  constraint cfk_param_dossier_format_na foreign key (Format_NA) references FORMAT_NUMEROTATION (Format_Id),
  constraint cfk_param_dossier_def_mode_expedition foreign key (Def_Mode_Expedition) references MODE_LIVRAISON (Mode_Liv_Id),
  constraint cfk_param_dossier_code_journal_achat foreign key (Code_Journal_Achat) references JOURNAL (Code_Journal),
  constraint cfk_param_dossier_code_journal_vente foreign key (Code_Journal_Vente) references JOURNAL (Code_Journal),
  constraint cfk_param_dossier_code_journal_regul foreign key (Code_Journal_Regul) references JOURNAL (Code_Journal),
  constraint cfk_param_dossier_code_journal_an foreign key (Code_Journal_AN) references JOURNAL (Code_Journal),
  constraint cfk_param_dossier_code_journal_acpte_ac foreign key (Code_Journal_Acpte_AC) references JOURNAL (Code_Journal),
  constraint cfk_param_dossier_code_journal_acpte foreign key (Code_Journal_Acpte) references JOURNAL (Code_Journal),
  constraint cfk_param_dossier_numero_compte_clients foreign key (Numero_Compte_Clients) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_fournisseurs foreign key (Numero_Compte_Fournisseurs) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_port_ac foreign key (Numero_Compte_Port_AC) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_port_ve foreign key (Numero_Compte_Port_VE) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_escompte_ac foreign key (Numero_Compte_Escompte_AC) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_escompte_ve foreign key (Numero_Compte_Escompte_VE) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_acompte_ac foreign key (Numero_Compte_Acompte_AC) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_acompte_ve foreign key (Numero_Compte_Acompte_VE) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_regul_ac foreign key (Numero_Compte_Regul_AC) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_regul_ve foreign key (Numero_Compte_Regul_VE) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_tva_due_ic foreign key (Numero_Compte_Tva_Due_IC) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_tva_ded_ic foreign key (Numero_Compte_Tva_Ded_IC) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_especes foreign key (Numero_Compte_Especes) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_numero_compte_attente_bq foreign key (Numero_Compte_Attente_BQ) references COMPTE (Numero_Compte),
  constraint cfk_param_dossier_modele_etiquette foreign key (Modele_Etiquette) references MODELE_ETIQUETTE (Modele_Id)
) engine=InnoDB;



create table EXERCICE (
  Exercice_Id        int unsigned not null auto_increment,  -- Identifiant de l'exercice
  Num_Exercice       tinyint unsigned default 0,            -- Numéro de l'exercice
  Debut_Exercice     bigint unsigned default 0,             -- Date de début d'exercice
  Fin_Exercice       bigint unsigned default 0,             -- Date de fin d'exercice
  Duree_Exercice     tinyint unsigned default 0,            -- Durée de l'exercice
  Nom_Base           varchar(16) default '',                -- Nom de la base (prefixe+_+Num_Exercice+_+Dossier_Id)
  Cloture            tinyint unsigned default 0,            -- L'exercice est-il clôturé ?
  Verrouille         tinyint unsigned default 0,            -- L'exercice est-il verrouillé ? (temporaire)
  primary key (Exercice_Id)
) engine=InnoDB;



create table SOCIETE (
  Denomination     varchar(50) default '',      -- Dénomination de la société
  Adresse_1        varchar(80) default '',      -- Ligne d'adresse 1
  Adresse_2        varchar(50) default '',      -- Ligne d'adresse 2
  Adresse_3        varchar(50) default '',      -- Ligne d'adresse 3
  Code_Postal      varchar(10) default '',      -- Code postal
  Ville            varchar(50) default '',      -- Ville
  Enseigne         varchar(50) default '',      -- Enseigne
  Monnaie_Tenue    int unsigned not null,       -- Devise de tenue du dossier
  Num_SIRET        varchar(14) default '',      -- Numéro de SIRET
  Code_NAF         varchar(10) default '',      -- Code NAF/APE
  Typologie        varchar(2) default 'AA',     -- Typologie de l'entreprise (AN=Activité de négoce, PS=Production de service, AA=Autre activité)
  Type_Societe     int unsigned not null,       -- Type de société (SARL, SA, EURL...)
  Expert           varchar(40) default '',      -- Expert comptable chargé du dossier
  Date_Creation    bigint unsigned default 0,   -- Date de création de la société
  Duree_Societe    tinyint unsigned default 0,  -- Durée de la société en années (de 1 à 99)
  Montant_Capital  decimal(14,2) default 0,     -- Montant du capital de départ
  Nb_Parts         int unsigned default 0,      -- Nombre de parts ou d'actions
  Email            varchar(64) default '',      -- Email de la société
  Telephone        varchar(20) default '',      -- Numéro de téléphone
  Fax              varchar(20) default '',      -- Numéro de fax
  Regime_Fiscal    char(2) default 'IR',        -- Régime fiscal (IR=Impôt sur le revenu, IS=Impôt sur les sociétés)
  Regime_Groupe    tinyint unsigned default 0,  -- Régime de groupe (1=oui/0=non)
  Centre_Impot     varchar(60) default '',      -- Centre des impôts dont dépend la société
  Tresorerie       varchar(60) default '',      -- Trésorerie dont dépend la société
  Centre_Gestion   varchar(60) default '',      -- Centre de gestion agréé
  Site_Web         varchar(60) default '',      -- Site web de la société
  Num_TVA_Intra    varchar(14) default '',      -- Numéro de TVA intracommunautaire
  Ville_RCS        varchar(50) default '',      -- Ville RCS (immatriculation)
  Code_Plan        int unsigned default 1,      -- Code du plan comptable
  index idx_type_societe (Type_Societe),
  constraint cfk_societe_type_societe foreign key (Type_Societe) references TYPE_SOCIETE (Type_Societe_Id)
) engine=InnoDB;


-- ----------------------------------- Accélérateurs de saisie comptable ---------------------------------------


create table ABONNEMENT_ECRITURE (
  Abt_Ecr_Id         int unsigned not null auto_increment,  -- Identifiant de l'abonnement d'écriture
  Libelle            varchar(50) default '',                -- Libellé de l'abonnement
  Etat               char(1) default 'N',                   -- Etat de l'abonnement (N=Nouveau, T=En cours, A=Annulé, C=Clôturé)
  Periodicite        char(1) default 'M',                   -- Périodicité d'abonnement (J=Journalière, A=Annuelle, M=Mensuelle, S=Semestrielle, T=Trimestrielle, B=Bimestrielle)
  Date_Fin_Mois      tinyint unsigned default 0,            -- Date écriture en fin de mois (oui/non)
  Jour_Ecriture      int unsigned default 0,                -- Jour de l'écriture dans le mois
  Journal            char(3) not null,                      -- Journal de destination
  Debut_Abt           bigint unsigned default 0,            -- Début de la période d'abonnement
  Fin_Abt            bigint unsigned default 0,             -- Fin de la période d'abonnement
  primary key (Abt_Ecr_Id),
  unique (Libelle),
  index idx_journal (Journal),
  constraint cfk_abonnement_ecriture_journal foreign key (Journal) references JOURNAL (Code_Journal)
) engine=InnoDB;


create table LIGNE_ABONNEMENT_ECRITURE (
  Ligne_Id           int unsigned not null auto_increment,  -- Identifiant de la ligne d'abonnement
  Abt_Ecr_Id         int unsigned not null,                 -- Identifiant de l'abonnement
  Numero_Compte      char(8) not null,                      -- Numéro de compte
  Libelle            varchar(70) default '',                -- Libellé de la ligne
  Montant_D          decimal(14,2) unsigned default 0,      -- Montant au débit
  Montant_C          decimal(14,2) unsigned default 0,      -- Montant au crédit
  Mode_Reg_Id        int unsigned default null,             -- Mode de règlement
  Commentaire        varchar(20) default '',                -- Commentaire
  Num_Piece          varchar(20) default '',                -- Numéro de pièce
  Periode_Lib        tinyint unsigned default 0,            -- Intégrer la période en fin de libellé (oui/non)
  primary key (Ligne_Id),
  index idx_numero_compte (Numero_Compte),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_abt_ecr_id (Abt_Ecr_Id),
  constraint cfk_ligne_abonnement_ecriture_abt_ecr_id foreign key (Abt_Ecr_Id) references ABONNEMENT_ECRITURE (Abt_Ecr_Id),
  constraint cfk_ligne_abonnement_ecriture_numero_compte foreign key (Numero_Compte) references COMPTE (Numero_Compte),
  constraint cfk_ligne_abonnement_ecriture_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;


create table ECHEANCE_ABONNEMENT_ECRITURE (
  Echeance_Id        int unsigned not null auto_increment,  -- Identifiant de l'échéance d'abonnement
  Abt_Ecr_Id         int unsigned not null,                 -- Identifiant de l'abonnement
  Statut             char(1) default 'N',                   -- Statut de l'échéance (N=En attente, G=Générée, A=Annulée)
  Date_Echeance      bigint unsigned default 0,             -- Date d'échéance de l'écriture
  primary key (Echeance_Id),
  index idx_abt_ecr_id (Abt_Ecr_Id),
  constraint cfk_echeance_abonnement_ecriture_abt_ecr_id foreign key (Abt_Ecr_Id) references ABONNEMENT_ECRITURE (Abt_Ecr_Id)
) engine=InnoDB;


create table MODELE_ECRITURE (
  Mod_Ecr_Id       int unsigned not null auto_increment,    -- Identifiant du modèle d'écriture
  Libelle          varchar(50) default '',                  -- Libellé du modèle d'écriture
  Raccourci        int unsigned default 0,                  -- N° Raccourci clavier (ctrl+raccourci 1-9)
  Etat             char(1) default 'N',                     -- Etat du modèle (N=Non validé, V=Validé)
  primary key (Mod_Ecr_Id),
  unique (Libelle)
) engine=InnoDB;


create table LIGNE_MODELE_ECRITURE (
  Ligne_Id           int unsigned not null auto_increment,  -- Identifiant de la ligne de modèle
  Mod_Ecr_Id         int unsigned not null,                 -- Identifiant du modèle d'écriture
  Numero_Compte      char(8) not null,                      -- Numéro de compte
  Libelle            varchar(80) default '',                -- Libellé de la ligne
  Montant_D          decimal(14,2) default 0,               -- Montant au débit
  Montant_C          decimal(14,2) default 0,               -- Montant au crédit
  Type_Calcul        char(1) default 'P',                   -- Type de calcul (P=Pourcentage, F=Montant fixe, S=Sans montant)
  Mode_Reg_Id        int unsigned default null,             -- Mode de règlement
  Commentaire        varchar(20) default '',                -- Commentaire
  Num_Piece          varchar(20) default '',                -- Numéro de pièce
  Periode_Lib        tinyint unsigned default 0,            -- Intégrer la période en fin de libellé (oui/non)
  primary key (Ligne_Id),
  index idx_mod_ecr_id (Mod_Ecr_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_numero_compte (Numero_Compte),
  constraint cfk_ligne_modele_ecriture_mod_ecr_id foreign key (Mod_Ecr_Id) references MODELE_ECRITURE (Mod_Ecr_Id),
  constraint cfk_ligne_modele_ecriture_numero_compte foreign key (Numero_Compte) references COMPTE (Numero_Compte),
  constraint cfk_ligne_modele_ecriture_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;




-- --------------------------------- Import d'écritures de banque ----------------------------------------


create table FORMAT_IMPORT_BANQUE (
  Format_Id       int not null auto_increment,           -- Identifiant du format d'import
  Intitule        varchar(20) default '',                -- Intitulé du format d'import
  Col_Date        tinyint unsigned default 0,            -- Numéro de colonne qui contient la date
  Format_Date     varchar(10) default '',                -- Format de la date (ex : dd/MM/yyyy)
  Col_Libelle     tinyint unsigned default 0,            -- Numéro de colonne qui contient le libellé
  Col_Montant_C   tinyint unsigned default 0,            -- Numéro de colonne qui contient le montant au crédit
  Col_Montant_D   tinyint unsigned default 0,            -- Numéro de colonne qui contient le montant au débit
  Col_Mode_Reg    tinyint unsigned default 0,            -- Numéro de colonne qui contient le mode de règlement
  Col_Num_Piece   tinyint unsigned default 0,            -- Numéro de colonne qui contient le numéro de pièce
  Premiere_Ligne  tinyint unsigned default 1,            -- Numéro de la première ligne de données
  Separateur      char(1) default '',                    -- Séparateur de colonnes
  Delimiteur      char(1) default '',                    -- Délimiteur de champ texte
  primary key (Format_Id)
) engine=InnoDB;


create table PARAM_IMPORT_BANQUE (
  Param_Id        int not null auto_increment,            -- Identifiant du paramétrage
  Journal_Banque  char(3) not null,                       -- Journal de banque
  Compte_Banque   char(8) default null,                   -- Compte de banque de contrepartie
  Centralisation  tinyint unsigned default 0,             -- Ecriture centralisée oui/non
  Concat_LSM      tinyint unsigned default 0,             -- Concaténer les lignes sans montant au libellé
  Compte_Com_CB   char(8) default null,                   -- Compte de commission CB 627
  Compte_Attente  char(8) default null,                   -- Compte d'attente d'affectation 472
  primary key (Param_Id),
  unique (Journal_Banque),
  index idx_compte_banque (Compte_Banque),
  index idx_compte_com_cb (Compte_Com_CB),
  index idx_compte_attente (Compte_Attente),
  constraint cfk_param_import_banque_compte_banque foreign key (Compte_Banque) references COMPTE (Numero_Compte),
  constraint cfk_param_import_banque_compte_com_cb foreign key (Compte_Com_CB) references COMPTE (Numero_Compte),
  constraint cfk_param_import_banque_compte_attente foreign key (Compte_Attente) references COMPTE (Numero_Compte),
  constraint cfk_param_import_banque_journal_banque foreign key (Journal_Banque) references JOURNAL (Code_Journal)
) engine=InnoDB;


create table PARAM_COMPTE_IMPORT_BANQUE (
  Param_Id          int not null,                -- Identifiant du paramétrage
  Lib_Rech          varchar(100) default '',     -- Libellé à rechercher
  Lib_Remp          varchar(100) default '',     -- Libellé de remplacement
  Compte_Rec        char(8) not null,            -- Compte de recettes
  Compte_Dep        char(8) not null,            -- Compte de dépenses
  primary key (Param_Id, Lib_Rech),
  constraint cfk_param_compte_import_banque_param_id foreign key (Param_Id) references PARAM_IMPORT_BANQUE (Param_Id),
  constraint cfk_param_compte_import_banque_compte_rec foreign key (Compte_Rec) references COMPTE (Numero_Compte),
  constraint cfk_param_compte_import_banque_compte_dep foreign key (Compte_Dep) references COMPTE (Numero_Compte)
) engine=InnoDB;


create table PARAM_MODE_REG_IMPORT_BANQUE (
  Param_Id          int not null,                -- Identifiant du paramétrage
  Lib_Mode_Reg      varchar(20) default '',      -- Libellé de mode de règlement à rechercher
  Mode_Reg_Id       int unsigned default null,   -- Mode de règlement correspondant
  primary key (Param_Id, Lib_Mode_Reg),
  index idx_mode_reg_id (Mode_Reg_Id),
  constraint cfk_param_mode_reg_import_banque_param_id foreign key (Param_Id) references PARAM_IMPORT_BANQUE (Param_Id),
  constraint cfk_param_mode_reg_import_banque_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id)
) engine=InnoDB;


create table PARAM_NUM_PIECE_IMPORT_BANQUE (
  Param_Id          int not null,                -- Identifiant du paramétrage
  Lib_Num_Piece     varchar(20) default '',      -- Libellé de numéro de pièce
  Nb_Car_Piece      tinyint unsigned default 0,  -- Nombre de caractères à récupérer après le libellé
  primary key (Param_Id, Lib_Num_Piece),
  constraint cfk_param_num_piece_import_banque_param_id foreign key (Param_Id) references PARAM_IMPORT_BANQUE (Param_Id)
) engine=InnoDB;



create table IMPORT_BANQUE (
  Import_Id       int not null auto_increment,           -- Identifiant de l'import d'écritures de banque
  Solde_Debut     decimal(14,2) default 0,               -- Solde de début du relevé
  Solde_Fin       decimal(14,2) default 0,               -- Solde de fin du relevé
  Solde_Calc      decimal(14,2) default 0,               -- Solde calculé du relevé
  Etat            char(1) default 'N',                   -- Etat de l'import (N=En cours, V=Validé)
  Date_M          bigint unsigned default 0,             -- Date de dernière modification
  Param_Id        int default null,                      -- Identifiant du paramétrage utilisé
  Format_Import   int not null,                          -- Format du fichier d'import utilisé
  Coherence       tinyint unsigned default 0,            -- Les écritures générées sont elles cohérentes avec l'import (oui/non)
  primary key (Import_Id),
  index idx_param_id (Param_Id),
  index idx_format_import (Format_Import),
  constraint cfk_import_banque_param_id foreign key (Param_Id) references PARAM_IMPORT_BANQUE (Param_Id),
  constraint cfk_import_banque_format_import foreign key (Format_Import) references FORMAT_IMPORT_BANQUE (Format_Id)
) engine=InnoDB;


create table LIGNE_IMPORT_BANQUE (
  Ligne_Id       int not null auto_increment,           -- Identifiant de la ligne
  Import_Id      int not null,                          -- Identifiant de l'import d'écritures de banque
  Date           bigint unsigned not null default 0,    -- Date
  Libelle        varchar(100) not null default '',      -- Libellé
  Montant_C      decimal(14,2) unsigned default 0,      -- Montant au crédit
  Montant_D      decimal(14,2) unsigned default 0,      -- Montant au débit
  Mode_Reg       varchar(50) not null default '',       -- Mode de règlement
  Num_Piece      varchar(50) not null default '',       -- Numéro de pièce
  primary key (Ligne_Id),
  index idx_import_id (Import_Id),
  constraint cfk_ligne_import_banque_import_id foreign key (Import_Id) references IMPORT_BANQUE (Import_Id)
) engine=InnoDB;


create table ECRITURE_BANQUE (
  Ecriture_Id     int not null auto_increment,           -- Identifiant de l'écriture
  Import_Id       int not null,                          -- Identifiant de l'import d'écritures de banque
  Periode         bigint unsigned default 0,             -- Période d'écriture
  primary key (Ecriture_Id),
  index idx_import_id (Import_Id),
  constraint cfk_ecriture_banque_import_id foreign key (Import_Id) references IMPORT_BANQUE (Import_Id)
) engine=InnoDB;


create table LIGNE_ECRITURE_BANQUE (
  Ligne_Id        int not null auto_increment,           -- Identifiant de la ligne
  Ecriture_Id     int not null,                          -- Identifiant de l'écriture
  Numero_Compte   char(8) not null,                      -- Numéro de compte
  Libelle         varchar(100) default '',               -- Libellé de la ligne
  Date            bigint unsigned default 0,             -- Date
  Montant_D       decimal(14,2) unsigned default 0,      -- Montant au débit
  Montant_C       decimal(14,2) unsigned default 0,      -- Montant au crédit
  Num_Piece       varchar(20) default '',                -- Numéro de pièce
  Mode_Reg_Id     int unsigned default null,             -- Mode de règlement
  primary key (Ligne_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  index idx_numero_compte (Numero_Compte),
  index idx_ecriture_id (Ecriture_Id),
  constraint cfk_ligne_ecriture_banque_mode_reg_id foreign key (Mode_Reg_Id) references MODE_REGLEMENT (Mode_Reg_Id),
  constraint cfk_ligne_ecriture_banque_numero_compte foreign key (Numero_Compte) references COMPTE (Numero_Compte),
  constraint cfk_ligne_ecriture_banque_ecriture_id foreign key (Ecriture_Id) references ECRITURE_BANQUE (Ecriture_Id)
) engine=InnoDB;
