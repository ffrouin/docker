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

-- Insertion de la liaison devise - pays

insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AF', (select Devise_Id from DEVISE where Code_Alpha='AFN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('ZA', (select Devise_Id from DEVISE where Code_Alpha='ZAR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AL', (select Devise_Id from DEVISE where Code_Alpha='ALL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('DZ', (select Devise_Id from DEVISE where Code_Alpha='DZD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('DE', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AD', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AO', (select Devise_Id from DEVISE where Code_Alpha='AOA'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AI', (select Devise_Id from DEVISE where Code_Alpha='XCD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AG', (select Devise_Id from DEVISE where Code_Alpha='XCD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AN', (select Devise_Id from DEVISE where Code_Alpha='ANG'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SA', (select Devise_Id from DEVISE where Code_Alpha='SAR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AR', (select Devise_Id from DEVISE where Code_Alpha='ARS'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AM', (select Devise_Id from DEVISE where Code_Alpha='AMD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AW', (select Devise_Id from DEVISE where Code_Alpha='AWG'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AU', (select Devise_Id from DEVISE where Code_Alpha='AUD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AT', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AZ', (select Devise_Id from DEVISE where Code_Alpha='AZN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BS', (select Devise_Id from DEVISE where Code_Alpha='BSD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BH', (select Devise_Id from DEVISE where Code_Alpha='BHD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BD', (select Devise_Id from DEVISE where Code_Alpha='BDT'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BB', (select Devise_Id from DEVISE where Code_Alpha='BBD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BY', (select Devise_Id from DEVISE where Code_Alpha='BYR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BE', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BZ', (select Devise_Id from DEVISE where Code_Alpha='BZD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BJ', (select Devise_Id from DEVISE where Code_Alpha='XOF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BM', (select Devise_Id from DEVISE where Code_Alpha='BMD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BT', (select Devise_Id from DEVISE where Code_Alpha='INR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BT', (select Devise_Id from DEVISE where Code_Alpha='BTN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BO', (select Devise_Id from DEVISE where Code_Alpha='BOB'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BO', (select Devise_Id from DEVISE where Code_Alpha='BOV'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BA', (select Devise_Id from DEVISE where Code_Alpha='BAM'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BW', (select Devise_Id from DEVISE where Code_Alpha='BWP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BV', (select Devise_Id from DEVISE where Code_Alpha='NOK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BR', (select Devise_Id from DEVISE where Code_Alpha='BRL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BN', (select Devise_Id from DEVISE where Code_Alpha='BND'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BG', (select Devise_Id from DEVISE where Code_Alpha='BGN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BF', (select Devise_Id from DEVISE where Code_Alpha='XOF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('BI', (select Devise_Id from DEVISE where Code_Alpha='BIF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KY', (select Devise_Id from DEVISE where Code_Alpha='KYD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KH', (select Devise_Id from DEVISE where Code_Alpha='KHR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CM', (select Devise_Id from DEVISE where Code_Alpha='XAF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CA', (select Devise_Id from DEVISE where Code_Alpha='CAD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CV', (select Devise_Id from DEVISE where Code_Alpha='CVE'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CF', (select Devise_Id from DEVISE where Code_Alpha='XAF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CL', (select Devise_Id from DEVISE where Code_Alpha='CLP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CL', (select Devise_Id from DEVISE where Code_Alpha='CLF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CN', (select Devise_Id from DEVISE where Code_Alpha='CNY'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CX', (select Devise_Id from DEVISE where Code_Alpha='AUD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CY', (select Devise_Id from DEVISE where Code_Alpha='CYP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CY', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CC', (select Devise_Id from DEVISE where Code_Alpha='AUD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CO', (select Devise_Id from DEVISE where Code_Alpha='COP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CO', (select Devise_Id from DEVISE where Code_Alpha='COU'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KM', (select Devise_Id from DEVISE where Code_Alpha='KMF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CG', (select Devise_Id from DEVISE where Code_Alpha='XAF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CD', (select Devise_Id from DEVISE where Code_Alpha='CDF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CK', (select Devise_Id from DEVISE where Code_Alpha='NZD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KR', (select Devise_Id from DEVISE where Code_Alpha='KRW'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KP', (select Devise_Id from DEVISE where Code_Alpha='KPW'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CR', (select Devise_Id from DEVISE where Code_Alpha='CRC'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CI', (select Devise_Id from DEVISE where Code_Alpha='XOF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('HR', (select Devise_Id from DEVISE where Code_Alpha='HRK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CU', (select Devise_Id from DEVISE where Code_Alpha='CUP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('DK', (select Devise_Id from DEVISE where Code_Alpha='DKK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('DJ', (select Devise_Id from DEVISE where Code_Alpha='DJF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('DO', (select Devise_Id from DEVISE where Code_Alpha='DOP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('DM', (select Devise_Id from DEVISE where Code_Alpha='XCD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('EG', (select Devise_Id from DEVISE where Code_Alpha='EGP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SV', (select Devise_Id from DEVISE where Code_Alpha='SVC'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SV', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AE', (select Devise_Id from DEVISE where Code_Alpha='AED'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('EC', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('ER', (select Devise_Id from DEVISE where Code_Alpha='ERN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('ES', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('EE', (select Devise_Id from DEVISE where Code_Alpha='EEK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('US', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('US', (select Devise_Id from DEVISE where Code_Alpha='USS'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('US', (select Devise_Id from DEVISE where Code_Alpha='USN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('ET', (select Devise_Id from DEVISE where Code_Alpha='ETB'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('FK', (select Devise_Id from DEVISE where Code_Alpha='FKP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('FO', (select Devise_Id from DEVISE where Code_Alpha='DKK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('FJ', (select Devise_Id from DEVISE where Code_Alpha='FJD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('FI', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('FR', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GA', (select Devise_Id from DEVISE where Code_Alpha='XAF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GM', (select Devise_Id from DEVISE where Code_Alpha='GMD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GE', (select Devise_Id from DEVISE where Code_Alpha='GEL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GH', (select Devise_Id from DEVISE where Code_Alpha='GHS'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GI', (select Devise_Id from DEVISE where Code_Alpha='GIP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GR', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GD', (select Devise_Id from DEVISE where Code_Alpha='XCD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GL', (select Devise_Id from DEVISE where Code_Alpha='DKK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GP', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GU', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GT', (select Devise_Id from DEVISE where Code_Alpha='GTQ'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GN', (select Devise_Id from DEVISE where Code_Alpha='GNF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GW', (select Devise_Id from DEVISE where Code_Alpha='GWP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GW', (select Devise_Id from DEVISE where Code_Alpha='XOF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GQ', (select Devise_Id from DEVISE where Code_Alpha='XAF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GY', (select Devise_Id from DEVISE where Code_Alpha='GYD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GF', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('HT', (select Devise_Id from DEVISE where Code_Alpha='HTG'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('HT', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('HM', (select Devise_Id from DEVISE where Code_Alpha='AUD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('HN', (select Devise_Id from DEVISE where Code_Alpha='HNL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('HK', (select Devise_Id from DEVISE where Code_Alpha='HKD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('HU', (select Devise_Id from DEVISE where Code_Alpha='HUF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('UM', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('VG', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('VI', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('IN', (select Devise_Id from DEVISE where Code_Alpha='INR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('ID', (select Devise_Id from DEVISE where Code_Alpha='IDR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('IR', (select Devise_Id from DEVISE where Code_Alpha='IRR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('IQ', (select Devise_Id from DEVISE where Code_Alpha='IQD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('IE', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('IS', (select Devise_Id from DEVISE where Code_Alpha='ISK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('IL', (select Devise_Id from DEVISE where Code_Alpha='ILS'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('IT', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('JM', (select Devise_Id from DEVISE where Code_Alpha='JMD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('JP', (select Devise_Id from DEVISE where Code_Alpha='JPY'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('JO', (select Devise_Id from DEVISE where Code_Alpha='JOD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KZ', (select Devise_Id from DEVISE where Code_Alpha='KZT'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KE', (select Devise_Id from DEVISE where Code_Alpha='KES'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KG', (select Devise_Id from DEVISE where Code_Alpha='KGS'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KI', (select Devise_Id from DEVISE where Code_Alpha='AUD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KW', (select Devise_Id from DEVISE where Code_Alpha='KWD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LA', (select Devise_Id from DEVISE where Code_Alpha='LAK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LS', (select Devise_Id from DEVISE where Code_Alpha='ZAR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LS', (select Devise_Id from DEVISE where Code_Alpha='LSL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LV', (select Devise_Id from DEVISE where Code_Alpha='LVL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LB', (select Devise_Id from DEVISE where Code_Alpha='LBP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LR', (select Devise_Id from DEVISE where Code_Alpha='LRD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LY', (select Devise_Id from DEVISE where Code_Alpha='LYD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LI', (select Devise_Id from DEVISE where Code_Alpha='CHF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LT', (select Devise_Id from DEVISE where Code_Alpha='LTL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LU', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MO', (select Devise_Id from DEVISE where Code_Alpha='MOP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MK', (select Devise_Id from DEVISE where Code_Alpha='MKD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MG', (select Devise_Id from DEVISE where Code_Alpha='MGA'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MY', (select Devise_Id from DEVISE where Code_Alpha='MYR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MW', (select Devise_Id from DEVISE where Code_Alpha='MWK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MV', (select Devise_Id from DEVISE where Code_Alpha='MVR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('ML', (select Devise_Id from DEVISE where Code_Alpha='XOF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MT', (select Devise_Id from DEVISE where Code_Alpha='MTL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MT', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MP', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MA', (select Devise_Id from DEVISE where Code_Alpha='MAD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MH', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MQ', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MU', (select Devise_Id from DEVISE where Code_Alpha='MUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MR', (select Devise_Id from DEVISE where Code_Alpha='MRO'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('YT', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MX', (select Devise_Id from DEVISE where Code_Alpha='MXN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MX', (select Devise_Id from DEVISE where Code_Alpha='MXV'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('FM', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MD', (select Devise_Id from DEVISE where Code_Alpha='MDL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MC', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MN', (select Devise_Id from DEVISE where Code_Alpha='MNT'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('ME', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MS', (select Devise_Id from DEVISE where Code_Alpha='XCD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MZ', (select Devise_Id from DEVISE where Code_Alpha='MZN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('MM', (select Devise_Id from DEVISE where Code_Alpha='MMK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NA', (select Devise_Id from DEVISE where Code_Alpha='ZAR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NA', (select Devise_Id from DEVISE where Code_Alpha='NAD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NR', (select Devise_Id from DEVISE where Code_Alpha='AUD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NP', (select Devise_Id from DEVISE where Code_Alpha='NPR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NI', (select Devise_Id from DEVISE where Code_Alpha='NIO'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NE', (select Devise_Id from DEVISE where Code_Alpha='XOF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NG', (select Devise_Id from DEVISE where Code_Alpha='NGN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NU', (select Devise_Id from DEVISE where Code_Alpha='NZD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NF', (select Devise_Id from DEVISE where Code_Alpha='AUD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NO', (select Devise_Id from DEVISE where Code_Alpha='NOK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NC', (select Devise_Id from DEVISE where Code_Alpha='XPF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NZ', (select Devise_Id from DEVISE where Code_Alpha='NZD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('IO', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('OM', (select Devise_Id from DEVISE where Code_Alpha='OMR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('UZ', (select Devise_Id from DEVISE where Code_Alpha='UZS'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PK', (select Devise_Id from DEVISE where Code_Alpha='PKR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PW', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PA', (select Devise_Id from DEVISE where Code_Alpha='PAB'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PA', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PG', (select Devise_Id from DEVISE where Code_Alpha='PGK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PY', (select Devise_Id from DEVISE where Code_Alpha='PYG'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('NL', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PE', (select Devise_Id from DEVISE where Code_Alpha='PEN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PH', (select Devise_Id from DEVISE where Code_Alpha='PHP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PN', (select Devise_Id from DEVISE where Code_Alpha='NZD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PL', (select Devise_Id from DEVISE where Code_Alpha='PLN'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PF', (select Devise_Id from DEVISE where Code_Alpha='XPF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PR', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PT', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('QA', (select Devise_Id from DEVISE where Code_Alpha='QAR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('RE', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('RO', (select Devise_Id from DEVISE where Code_Alpha='RON'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('GB', (select Devise_Id from DEVISE where Code_Alpha='GBP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('RU', (select Devise_Id from DEVISE where Code_Alpha='RUB'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('RW', (select Devise_Id from DEVISE where Code_Alpha='RWF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('EH', (select Devise_Id from DEVISE where Code_Alpha='MAD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SH', (select Devise_Id from DEVISE where Code_Alpha='SHP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('KN', (select Devise_Id from DEVISE where Code_Alpha='XCD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LC', (select Devise_Id from DEVISE where Code_Alpha='XCD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SM', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('PM', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('VC', (select Devise_Id from DEVISE where Code_Alpha='XCD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SB', (select Devise_Id from DEVISE where Code_Alpha='SBD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('WS', (select Devise_Id from DEVISE where Code_Alpha='WST'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('AS', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('ST', (select Devise_Id from DEVISE where Code_Alpha='STD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SN', (select Devise_Id from DEVISE where Code_Alpha='XOF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('RS', (select Devise_Id from DEVISE where Code_Alpha='RSD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SC', (select Devise_Id from DEVISE where Code_Alpha='SCR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SL', (select Devise_Id from DEVISE where Code_Alpha='SLL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SG', (select Devise_Id from DEVISE where Code_Alpha='SGD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SK', (select Devise_Id from DEVISE where Code_Alpha='SKK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SI', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SO', (select Devise_Id from DEVISE where Code_Alpha='SOS'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SD', (select Devise_Id from DEVISE where Code_Alpha='SDG'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('LK', (select Devise_Id from DEVISE where Code_Alpha='LKR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SE', (select Devise_Id from DEVISE where Code_Alpha='SEK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SR', (select Devise_Id from DEVISE where Code_Alpha='SRD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SJ', (select Devise_Id from DEVISE where Code_Alpha='NOK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CH', (select Devise_Id from DEVISE where Code_Alpha='CHF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CH', (select Devise_Id from DEVISE where Code_Alpha='CHW'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CH', (select Devise_Id from DEVISE where Code_Alpha='CHE'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SZ', (select Devise_Id from DEVISE where Code_Alpha='SZL'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('SY', (select Devise_Id from DEVISE where Code_Alpha='SYP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TJ', (select Devise_Id from DEVISE where Code_Alpha='TJS'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TW', (select Devise_Id from DEVISE where Code_Alpha='TWD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TZ', (select Devise_Id from DEVISE where Code_Alpha='TZS'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TF', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TD', (select Devise_Id from DEVISE where Code_Alpha='XAF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('CZ', (select Devise_Id from DEVISE where Code_Alpha='CZK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TH', (select Devise_Id from DEVISE where Code_Alpha='THB'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TL', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TG', (select Devise_Id from DEVISE where Code_Alpha='XOF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TK', (select Devise_Id from DEVISE where Code_Alpha='NZD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TO', (select Devise_Id from DEVISE where Code_Alpha='TOP'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TT', (select Devise_Id from DEVISE where Code_Alpha='TTD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TN', (select Devise_Id from DEVISE where Code_Alpha='TND'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TM', (select Devise_Id from DEVISE where Code_Alpha='TMM'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TC', (select Devise_Id from DEVISE where Code_Alpha='USD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TR', (select Devise_Id from DEVISE where Code_Alpha='TRY'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('TV', (select Devise_Id from DEVISE where Code_Alpha='AUD'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('UG', (select Devise_Id from DEVISE where Code_Alpha='UGX'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('UA', (select Devise_Id from DEVISE where Code_Alpha='UAH'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('UY', (select Devise_Id from DEVISE where Code_Alpha='UYU'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('UY', (select Devise_Id from DEVISE where Code_Alpha='UYI'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('VU', (select Devise_Id from DEVISE where Code_Alpha='VUV'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('VA', (select Devise_Id from DEVISE where Code_Alpha='EUR'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('VE', (select Devise_Id from DEVISE where Code_Alpha='VEF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('VN', (select Devise_Id from DEVISE where Code_Alpha='VND'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('WF', (select Devise_Id from DEVISE where Code_Alpha='XPF'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('YE', (select Devise_Id from DEVISE where Code_Alpha='YER'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('ZM', (select Devise_Id from DEVISE where Code_Alpha='ZMK'));
insert into DEVISE_PAYS (Code_Pays, Devise_Id) values ('ZW', (select Devise_Id from DEVISE where Code_Alpha='ZWD'));