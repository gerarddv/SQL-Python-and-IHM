import sqlite3
from sqlite3 import IntegrityError

import pandas

def read_excel_file_V0(data:sqlite3.Connection, file):
    # Lecture de l'onglet du fichier excel LesSportifsEQ, en interprétant toutes les colonnes comme des strings
    # pour construire uniformement la requête
    df_sportifs = pandas.read_excel(file, sheet_name='LesSportifsEQ', dtype=str)
    df_sportifs = df_sportifs.where(pandas.notnull(df_sportifs), 'null')

    cursor = data.cursor()
    for ix, row in df_sportifs.iterrows():
        try:
            query = "insert into V0_LesSportifsEQ values ({},'{}','{}','{}','{}','{}',{})".format(
                row['numSp'], row['nomSp'], row['prenomSp'], row['pays'], row['categorieSp'], row['dateNaisSp'], row['numEq'])
            # On affiche la requête pour comprendre la construction. A enlever une fois compris.
            print(query)
            cursor.execute(query)
        except IntegrityError as err:
            print(err)

    # Lecture de l'onglet LesEpreuves du fichier excel, en interprétant toutes les colonnes comme des string
    # pour construire uniformement la requête
    df_epreuves = pandas.read_excel(file, sheet_name='LesEpreuves', dtype=str)
    df_epreuves = df_epreuves.where(pandas.notnull(df_epreuves), 'null')

    cursor = data.cursor()
    for ix, row in df_epreuves.iterrows():
        try:
            query = "insert into V0_LesEpreuves values ({},'{}','{}','{}','{}',{},".format(
                row['numEp'], row['nomEp'], row['formeEp'], row['nomDi'], row['categorieEp'], row['nbSportifsEp'])

            if (row['dateEp'] != 'null'):
                query = query + "'{}')".format(row['dateEp'])
            else:
                query = query + "null)"
            # On affiche la requête pour comprendre la construction. A enlever une fois compris.
            print(query)
            cursor.execute(query)
        except IntegrityError as err:
            print(f"{err} : \n{row}")

#TODO 1.3a : modifier la lecture du fichier Excel pour lire l'ensemble des données et les intégrer dans le schéma de la BD V1
def read_excel_file_V1(data:sqlite3.Connection, file):
    # Lecture de l'onglet du fichier excel LesSportifsEQ, en interprétant toutes les colonnes comme des strings
    # pour construire uniformement la requête
    df_sportifs = pandas.read_excel(file, sheet_name='LesSportifsEQ', dtype=str)
    df_sportifs = df_sportifs.where(pandas.notnull(df_sportifs), 'null')
    cursor = data.cursor()
    for ix, row in df_sportifs.iterrows():
        try:
            query = "insert into LesSportifs values ({},'{}','{}','{}','{}','{}')".format(
                row['numSp'], row['nomSp'], row['prenomSp'], row['pays'], row['categorieSp'], row['dateNaisSp'])
            # On affiche la requête pour comprendre la construction. A enlever une fois compris.
            print(query)
            cursor.execute(query)
            if (row['numEq'] != 'null'):
                query = "insert into LesEquipiers values ({},{})".format(row['numEq'], row['numSp'])
                print(query)
                cursor.execute(query)
        except IntegrityError as err:
            print(err)
    # Lecture de l'onglet du fichier excel LesEpreuves, en interprétant toutes les colonnes comme des string
    # pour construire uniformement la requête

    df_epreuves = pandas.read_excel(file, sheet_name='LesEpreuves', dtype=str)
    df_epreuves = df_epreuves.where(pandas.notnull(df_epreuves), 'null')
    cursor = data.cursor()
    for ix, row in df_epreuves.iterrows():
        try:
            query = "insert into LesEpreuves values ({},'{}','{}','{}','{}',{},".format(
                row['numEp'], row['nomEp'], row['formeEp'], row['nomDi'], row['categorieEp'], row['nbSportifsEp'])

            if (row['dateEp'] != 'null'):
                query = query + "'{}')".format(row['dateEp'])
            else:
                query = query + "null)"
            # On affiche la requête pour comprendre la construction. A enlever une fois compris.
            print(query)
            cursor.execute(query)
        except IntegrityError as err:
            print(f"{err} : \n{row}")
    # Lecture de l'onglet du fichier excel LesSportifsEQ, en interprétant toutes les colonnes comme des strings
    # pour construire uniformement la requête

    df_resultats = pandas.read_excel(file, sheet_name='LesResultats', dtype=str)
    df_resultats = df_resultats.where(pandas.notnull(df_resultats), 'null')
    cursor = data.cursor()
    for ix, row in df_resultats.iterrows():
        try:
            query = "insert into LesResultats values ({}, {}, {}, {})".format(
                row['numEp'], row['gold'], row['silver'], row['bronze'])
            # On affiche la requête pour comprendre la construction. A enlever une fois compris.
            print(query)
            cursor.execute(query)
        except IntegrityError as err:
            print(err)

        # Lecture de l'onglet du fichier excel LesEquipes, en interprétant toutes les colonnes comme des strings
        # pour construire uniformement la requête
    df_equipes = pandas.read_excel(file, sheet_name='LesSportifsEQ', dtype=str)
    df_equipes = df_equipes.where(pandas.notnull(df_equipes), 'null')
    cursor = data.cursor()
    for ix, row in df_equipes.iterrows():
        try:
            query = "insert into LesEquipes values ({},'{}')".format(
                row['numEq'], row['pays'])
            # On affiche la requête pour comprendre la construction. A enlever une fois compris.
            print(query)
            cursor.execute(query)
        except IntegrityError as err:
            print(err)
    # Lecture de l'onglet du fichier excel LesEquipiers, en interprétant toutes les colonnes comme des string
    # pour construire uniformement la requête
    df_equipiers = pandas.read_excel(file, sheet_name='LesSportifsEQ', dtype=str)
    df_equipiers = df_equipiers.where(pandas.notnull(df_equipiers), 'null')
    cursor = data.cursor()
    for ix, row in df_equipiers.iterrows():
        try:
            query = "insert into LesEquipiers values ({},{})".format(
                row['numEq'], row['numSp'])
            # On affiche la requête pour comprendre la construction. A enlever une fois compris.
            print(query)
            cursor.execute(query)
        except IntegrityError as err:
            print(err)

    df_participants = pandas.read_excel(file, sheet_name='LesInscriptions', dtype=str)
    df_participants = df_participants.where(pandas.notnull(df_participants), 'null')
    cursor = data.cursor()
    for ix, row in df_participants.iterrows():
        try:
            query = "update LesParticipants set numEp = {} WHERE numP = {}".format(
                row['numEp'], row['numIn'])
            # On affiche la requête pour comprendre la construction. A enlever une fois compris.
            print(query)
            cursor.execute(query)
        except IntegrityError as err:
            print(err)
