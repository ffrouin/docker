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

-- SCHEMA BASE DE DONN�ES OPENSI COMPTA << EXERCICE >>


create table SOLDE_COMPTE (
  Numero_Compte    char(8) not null,                       -- Num�ro de compte
  Lettre           varchar(3) default '',                  -- Derni�re lettre utilis�e pour le lettrage
  Solde            decimal(16,2) default 0,                -- Solde du compte
  Total_Credit     decimal(16,2) default 0,                -- Solde total au cr�dit
  Total_Debit      decimal(16,2) default 0,                -- Solde total au d�bit
  primary key(Numero_Compte)
) engine=InnoDB;


create table NB_OP_JOURNAUX (
  Code_Journal     char(3) not null,                       -- Code d'identification du journal
  Periode          bigint unsigned not null default 0,     -- Mois de l'�criture (date au 1er jour du mois)
  Nb_Op            int unsigned default 0,                 -- Nombre d'op�rations du journal dans la p�riode
  primary key(Code_Journal, Periode)
) engine=InnoDB;


create table PERIODE_EXERCICE (
  Periode_Id       int unsigned not null auto_increment,   -- Identifiant de la p�riode
  Periode          bigint unsigned default 0,              -- P�riode
  Cloture          tinyint unsigned default 0,             -- Clotur�e (oui/non)
  Date_Cloture     bigint unsigned default 0,              -- Date de cl�ture
  primary key(Periode_Id)
) engine=InnoDB;


create table ECRITURE (
  Ecriture_Id      int unsigned not null auto_increment,   -- Identifiant unique de l'�criture comptable
  Code_Journal     char(3) not null,                       -- Code du journal rattach� � l'�criture
  Date_Ecriture    bigint unsigned default 0,              -- Mois de l'�criture (date au 1er jour du mois)
  Numero           int unsigned default 0,                 -- Num�ro de l'�criture en liaison avec le code journal
  Etat             char(1) default 'B',                    -- Etat de l'�criture (B=Brouillard, V=Valid�e, T=Temporairement bloqu�e)
  primary key(Ecriture_Id),
  index idx_code_journal (Code_Journal)
) engine=InnoDB;


create table OPERATION (
  Op_Id            int unsigned not null auto_increment,   -- Identifiant unique de l'op�ration
  Num_Ligne        int unsigned not null,                  -- Num�ro d'ordre au sein de l'�criture
  Ecriture_Id      int unsigned not null,                  -- Identifiant de l'�criture comptable
  Numero_Compte    char(8) not null,                       -- Num�ro de compte
  Montant_D        decimal(14,2) unsigned default 0,       -- Montant de l'op�ration si d�bit sinon 0
  Montant_C        decimal(14,2) unsigned default 0,       -- Montant de l'op�ration si cr�dit sinon 0
  Libelle          varchar(100) default '',                -- Libell� de l'op�ration
  Num_Piece        varchar(20) default '',                 -- Num�ro de pi�ce
  Contrepartie     char(8) default null,                   -- Num�ro de compte de contrepartie
  Lettre           varchar(3) default '',                  -- Lettre pour lettrage
  Date_Op          bigint unsigned default 0,              -- Date de l'op�ration
  Date_Echeance    bigint unsigned default 0,              -- Date d'�ch�ance
  Mode_Reg_Id      int unsigned default null,              -- Mode de r�glement
  Pointage         tinyint unsigned default 0,             -- Pointage de l'op�ration (oui/non)
  Commentaire      varchar(20) default '',                 -- Commentaire libre sur l'op�ration
  Date_Lettrage    bigint unsigned default 0,              -- Date de lettrage
  Date_C           bigint unsigned default 0,              -- Date de cr�ation
  Date_M           bigint unsigned default 0,              -- Date de derni�re modification
  Util_C           int not null,                           -- Utilisateur cr�ateur de l'op�ration
  Util_M           int not null,                           -- Utilisateur ayant fait la derni�re modification
  primary key(Op_Id),
  index idx_numero_compte (Numero_Compte),
  index idx_ecriture_id (Ecriture_Id),
  index idx_mode_reg_id (Mode_Reg_Id),
  constraint cfk_operation_numero_compte foreign key (Numero_Compte) references SOLDE_COMPTE (Numero_Compte),
  constraint cfk_operation_ecriture_id foreign key (Ecriture_Id) references ECRITURE (Ecriture_Id)
) engine=InnoDB;


-- create table ECHEANCE_OPERATION (
--   Echeance_Id      int unsigned not null auto_increment,   -- Identifiant de l'�ch�ance
--   Date_Echeance    bigint unsigned default 0,              -- Date d'�ch�ance
--   Mode_Reg_Id      int unsigned default null,              -- Identifiant du mode de r�glement
--   Montant          decimal(14,2) unsigned default 0,       -- Montant de l'�ch�ance
--   primary key(Echeance_Id)
-- ) engine=InnoDB;


