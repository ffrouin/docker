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

-- SCHEMA BASE DE DONNÉES OPENSI COMPTA << EXERCICE >>


create table SOLDE_COMPTE (
  Numero_Compte    char(8) not null,                       -- Numéro de compte
  Lettre           varchar(3) default '',                  -- Dernière lettre utilisée pour le lettrage
  Solde            decimal(16,2) default 0,                -- Solde du compte
  Total_Credit     decimal(16,2) default 0,                -- Solde total au crédit
  Total_Debit      decimal(16,2) default 0,                -- Solde total au débit
  primary key(Numero_Compte)
) engine=InnoDB;


create table NB_OP_JOURNAUX (
  Code_Journal     char(3) not null,                       -- Code d'identification du journal
  Periode          bigint unsigned not null default 0,     -- Mois de l'écriture (date au 1er jour du mois)
  Nb_Op            int unsigned default 0,                 -- Nombre d'opérations du journal dans la période
  primary key(Code_Journal, Periode)
) engine=InnoDB;


create table PERIODE_EXERCICE (
  Periode_Id       int unsigned not null auto_increment,   -- Identifiant de la période
  Periode          bigint unsigned default 0,              -- Période
  Cloture          tinyint unsigned default 0,             -- Cloturée (oui/non)
  Date_Cloture     bigint unsigned default 0,              -- Date de clôture
  primary key(Periode_Id)
) engine=InnoDB;


create table ECRITURE (
  Ecriture_Id      int unsigned not null auto_increment,   -- Identifiant unique de l'écriture comptable
  Code_Journal     char(3) not null,                       -- Code du journal rattaché à l'écriture
  Date_Ecriture    bigint unsigned default 0,              -- Mois de l'écriture (date au 1er jour du mois)
  Numero           int unsigned default 0,                 -- Numéro de l'écriture en liaison avec le code journal
  Etat             char(1) default 'B',                    -- Etat de l'écriture (B=Brouillard, V=Validée, T=Temporairement bloquée)
  primary key(Ecriture_Id),
  index idx_code_journal (Code_Journal)
) engine=InnoDB;


create table OPERATION (
  Op_Id            int unsigned not null auto_increment,   -- Identifiant unique de l'opération
  Num_Ligne        int unsigned not null,                  -- Numéro d'ordre au sein de l'écriture
  Ecriture_Id      int unsigned not null,                  -- Identifiant de l'écriture comptable
  Numero_Compte    char(8) not null,                       -- Numéro de compte
  Montant_D        decimal(14,2) unsigned default 0,       -- Montant de l'opération si débit sinon 0
  Montant_C        decimal(14,2) unsigned default 0,       -- Montant de l'opération si crédit sinon 0
  Libelle          varchar(100) default '',                -- Libellé de l'opération
  Num_Piece        varchar(20) default '',                 -- Numéro de pièce
  Contrepartie     char(8) default null,                   -- Numéro de compte de contrepartie
  Lettre           varchar(3) default '',                  -- Lettre pour lettrage
  Date_Op          bigint unsigned default 0,              -- Date de l'opération
  Date_Echeance    bigint unsigned default 0,              -- Date d'échéance
  Mode_Reg_Id      int unsigned default null,              -- Mode de règlement
  Pointage         tinyint unsigned default 0,             -- Pointage de l'opération (oui/non)
  Commentaire      varchar(20) default '',                 -- Commentaire libre sur l'opération
  Date_Lettrage    bigint unsigned default 0,              -- Date de lettrage
  Date_C           bigint unsigned default 0,              -- Date de création
  Date_M           bigint unsigned default 0,              -- Date de dernière modification
  Util_C           int not null,                           -- Utilisateur créateur de l'opération
  Util_M           int not null,                           -- Utilisateur ayant fait la dernière modification
  primary key(Op_Id),
  index idx_numero_compte (Numero_Compte),
  index idx_ecriture_id (Ecriture_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  constraint cfk_operation_numero_compte foreign key (Numero_Compte) references SOLDE_COMPTE (Numero_Compte),
  constraint cfk_operation_ecriture_id foreign key (Ecriture_Id) references ECRITURE (Ecriture_Id)
) engine=InnoDB;


-- create table ECHEANCE_OPERATION (
--   Echeance_Id      int unsigned not null auto_increment,   -- Identifiant de l'échéance
--   Date_Echeance    bigint unsigned default 0,              -- Date d'échéance
--   Mode_Reg_Id      int unsigned default null,              -- Identifiant du mode de règlement
--   Montant          decimal(14,2) unsigned default 0,       -- Montant de l'échéance
--   primary key(Echeance_Id)
-- ) engine=InnoDB;


