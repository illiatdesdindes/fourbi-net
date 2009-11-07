module Countries

  CODE_TO_NAME = {
          'AF' => "Afghanistan",
          'ZA' => "Afrique du Sud",
          'AL' => "Albanie",
          'DZ' => "Algérie",
          'DE' => "Allemagne",
          'AD' => "Andorre",
          'AO' => "Angola",
          'AI' => "Anguilla",
          'AQ' => "Antarctique",
          'AG' => "Antigua-et-Barbuda",
          'AN' => "Antilles Néerlandaises",
          'SA' => "Arabie Saoudite",
          'AR' => "Argentine",
          'AM' => "Arménie",
          'AW' => "Aruba",
          'AU' => "Australie",
          'AT' => "Autriche",
          'AX' => "Îles Åland",
          'AZ' => "Azerbaïdjan",
          'BS' => "Bahamas",
          'BH' => "Bahreïn",
          'BD' => "Bangladesh",
          'BB' => "Barbades",
          'BE' => "Belgique",
          'BZ' => "Belize",
          'BJ' => "Bénin",
          'BM' => "Bermudes",
          'BT' => "Bhoutan",
          'BY' => "Biélorussie",
          'BO' => "Bolivie",
          'BA' => "Bosnie-Herzégovine",
          'BW' => "Botswana",
          'BR' => "Brésil",
          'BN' => "Brunei",
          'BG' => "Bulgarie",
          'BF' => "Burkina Faso",
          'BI' => "Burundi",
          'KH' => "Cambodge",
          'CM' => "Cameroun",
          'CA' => "Canada",
          'CV' => "Cap-Vert",
          'CL' => "Chili",
          'CN' => "Chine",
          'CY' => "Chypre",
          'CO' => "Colombie",
          'MP' => "Commonwealth des Îles Mariannes du Nord",
          'KM' => "Comores",
          'CG' => "Congo",
          'CD' => "Congo, République Démocratique du",
          'KP' => "Corée du Nord",
          'KR' => "Corée du Sud",
          'CR' => "Costa Rica",
          'CI' => "Côte d'Ivoire",
          'HR' => "Croatie",
          'CU' => "Cuba",
          'DK' => "Danemark",
          'DJ' => "Djibouti",
          'DM' => "Dominique",
          'EG' => "Egypte",
          'AE' => "Émirats Arabes Unis",
          'EC' => "Equateur",
          'ER' => "Érythrée",
          'ES' => "Espagne",
          'EE' => "Estonie",
          'US' => "États-Unis",
          'ET' => "Ethiopie",
          'FJ' => "Fidji",
          'FI' => "Finlande",
          'FR' => "France",
          'GA' => "Gabon",
          'GM' => "Gambie",
          'GE' => "Géorgie",
          'GS' => "Géorgie du Sud et les Îles Sandwich du Sud",
          'GH' => "Ghana",
          'GI' => "Gibraltar",
          'GB' => "Grande Bretagne",
          'GR' => "Grèce",
          'GD' => "Grenade",
          'GL' => "Groenland",
          'GP' => "Guadeloupe",
          'GU' => "Guam",
          'GT' => "Guatemala",
          'GG' => "Guernesey",
          'GN' => "Guinée",
          'GQ' => "Guinée Équatoriale",
          'GW' => "Guinée-Bissau",
          'GY' => "Guyana",
          'GF' => "Guyane Française",
          'HT' => "Haïti",
          'HN' => "Honduras",
          'HK' => "Hong Kong",
          'HU' => "Hongrie",
          'BV' => "Île Bouvet",
          'CX' => "Île Christmas",
          'IM' => "Île de Man",
          'HM' => "Île Heard et Îles McDonald",
          'NF' => "Île Norfolk",
          'KY' => "Îles Caïmanes",
          'CC' => "Îles Cocos (Keeling)",
          'CK' => "Iles Cook",
          'FO' => "Iles Féroé",
          'FK' => "Iles Malouines",
          'MH' => "Îles Marshall",
          'UM' => "Îles Mineures Éloignées des États-Unis",
          'SB' => "Îles Salomon",
          'TC' => "Îles Turks et Caïques",
          'VG' => "Îles Vierges Britanniques",
          'VI' => "Îles Vierges Des États-Unis",
          'IN' => "Inde",
          'ID' => "Indonésie",
          'IQ' => "Irak",
          'IR' => "Iran",
          'IE' => "Irlande",
          'IS' => "Islande",
          'IL' => "Israël",
          'IT' => "Italie",
          'JM' => "Jamaïque",
          'JP' => "Japon",
          'JE' => "Jersey",
          'JO' => "Jordanie",
          'KZ' => "Kazakhstan",
          'KE' => "Kenya",
          'KG' => "Kirghizistan",
          'KI' => "Kiribati",
          'KW' => "Koweït",
          'LA' => "Laos",
          'LS' => "Lesotho",
          'LV' => "Lettonie",
          'LB' => "Liban",
          'LR' => "Libéria",
          'LY' => "Libye",
          'LI' => "Liechtenstein",
          'LT' => "Lituanie",
          'LU' => "Luxembourg",
          'MO' => "Macao",
          'MK' => "Macédoine",
          'MG' => "Madagascar",
          'MY' => "Malaisie",
          'MW' => "Malawi",
          'MV' => "Maldives",
          'ML' => "Mali",
          'MT' => "Malte",
          'MA' => "Maroc",
          'MQ' => "Martinique",
          'MU' => "Maurice",
          'MR' => "Mauritanie",
          'YT' => "Mayotte",
          'MX' => "Mexique",
          'FM' => "Micronesie",
          'MD' => "Moldavie",
          'MC' => "Monaco",
          'MN' => "Mongolie",
          'ME' => "Monténégro",
          'MS' => "Montserrat",
          'MZ' => "Mozambique",
          'MM' => "Myanmar",
          'NA' => "Namibie",
          'NR' => "Nauru",
          'NP' => "Népal",
          'NI' => "Nicaragua",
          'NE' => "Niger",
          'NG' => "Nigéria",
          'NU' => "Nioué",
          'NO' => "Norvège",
          'NC' => "Nouvelle-Calédonie",
          'NZ' => "Nouvelle-Zélande",
          'OM' => "Oman",
          'UG' => "Ouganda",
          'UZ' => "Ouzbékistan",
          'PK' => "Pakistan",
          'PW' => "Palaos",
          'PS' => "Palestine",
          'PA' => "Panama",
          'PG' => "Papouasie-Nouvelle-Guinée",
          'PY' => "Paraguay",
          'NL' => "Pays-Bas",
          'PE' => "Pérou",
          'PH' => "Philippines",
          'PN' => "Pitcairn",
          'PL' => "Pologne",
          'PF' => "Polynésie française",
          'PT' => "Portugal",
          'PR' => "Puerto Rico",
          'QA' => "Qatar",
          'CF' => "République Centrafricaine",
          'DO' => "République Dominicaine",
          'RE' => "Réunion",
          'RO' => "Roumanie",
          'UK' => "Royaume-Uni",
          'RU' => "Russie",
          'RW' => "Rwanda",
          'EH' => "Sahara Occidentale",
          'KN' => "Saint-Kitts-et-Nevis",
          'SM' => "Saint-Marin",
          'PM' => "Saint-Pierre-et-Miquelon",
          'VC' => "Saint-Vincent-et-les-Grenadines",
          'SH' => "Sainte-Hélène",
          'LC' => "Sainte-Lucie",
          'SV' => "Salvador",
          'WS' => "Samoa",
          'AS' => "Samoa Americaine",
          'ST' => "Sao Tomé et Principe",
          'SN' => "Sénégal",
          'RS' => "Serbie",
          'CS' => "Serbie et Monténégro",
          'SC' => "Seychelles",
          'SL' => "Sierra Leone",
          'SG' => "Singapour",
          'SK' => "Slovaquie",
          'SI' => "Slovénie",
          'SO' => "Somalie",
          'SD' => "Soudan",
          'LK' => "Sri Lanka",
          'SE' => "Suède",
          'CH' => "Suisse",
          'SR' => "Suriname",
          'SJ' => "Svalbard et Île Jan Mayen",
          'SZ' => "Swaziland",
          'SY' => "Syrie",
          'TJ' => "Tadjikistan",
          'TW' => "Taiwan",
          'TZ' => "Tanzanie",
          'TD' => "Tchad",
          'CZ' => "Tchéquie",
          'TF' => "Terres Australes Françaises",
          'IO' => "Territoire britannique de l'Océan Indien",
          'TH' => "Thaïlande",
          'TL' => "Timor-Oriental",
          'TG' => "Togo",
          'TK' => "Tokelau",
          'TO' => "Tonga",
          'TT' => "Trinité-et-Tobago",
          'TN' => "Tunisie",
          'TM' => "Turkménistan",
          'TR' => "Turquie",
          'TV' => "Tuvalu",
          'UA' => "Ukraine",
          'UY' => "Uruguay",
          'VU' => "Vanuatu",
          'VA' => "Vatican",
          'VE' => "Venezuela",
          'VN' => "Vietnam",
          'WF' => "Wallis-et-Futuna",
          'YE' => "Yémen",
          'ZM' => "Zambie",
          'ZW' => "Zimbabwe"
  }

  NAME_TO_CODE = {
          "Afghanistan" => 'AF',
          "Afrique du Sud" => 'ZA',
          "Albanie" => 'AL',
          "Algérie" => 'DZ',
          "Allemagne" => 'DE',
          "Andorre" => 'AD',
          "Angola" => 'AO',
          "Anguilla" => 'AI',
          "Antarctique" => 'AQ',
          "Antigua-et-Barbuda" => 'AG',
          "Antilles Néerlandaises" => 'AN',
          "Arabie Saoudite" => 'SA',
          "Argentine" => 'AR',
          "Arménie" => 'AM',
          "Aruba" => 'AW',
          "Australie" => 'AU',
          "Autriche" => 'AT',
          "Îles Åland" => 'AX',
          "Azerbaïdjan" => 'AZ',
          "Bahamas" => 'BS',
          "Bahreïn" => 'BH',
          "Bangladesh" => 'BD',
          "Barbades" => 'BB',
          "Belgique" => 'BE',
          "Belize" => 'BZ',
          "Bénin" => 'BJ',
          "Bermudes" => 'BM',
          "Bhoutan" => 'BT',
          "Biélorussie" => 'BY',
          "Bolivie" => 'BO',
          "Bosnie-Herzégovine" => 'BA',
          "Botswana" => 'BW',
          "Brésil" => 'BR',
          "Brunei" => 'BN',
          "Bulgarie" => 'BG',
          "Burkina Faso" => 'BF',
          "Burundi" => 'BI',
          "Cambodge" => 'KH',
          "Cameroun" => 'CM',
          "Canada" => 'CA',
          "Cap-Vert" => 'CV',
          "Chili" => 'CL',
          "Chine" => 'CN',
          "Chypre" => 'CY',
          "Colombie" => 'CO',
          "Commonwealth des Îles Mariannes du Nord" => 'MP',
          "Comores" => 'KM',
          "Congo" => 'CG',
          "Congo, République Démocratique du" => 'CD',
          "Corée du Nord" => 'KP',
          "Corée du Sud" => 'KR',
          "Costa Rica" => 'CR',
          "Côte d'Ivoire" => 'CI',
          "Croatie" => 'HR',
          "Cuba" => 'CU',
          "Danemark" => 'DK',
          "Djibouti" => 'DJ',
          "Dominique" => 'DM',
          "Egypte" => 'EG',
          "Émirats Arabes Unis" => 'AE',
          "Equateur" => 'EC',
          "Érythrée" => 'ER',
          "Espagne" => 'ES',
          "Estonie" => 'EE',
          "États-Unis" => 'US',
          "Ethiopie" => 'ET',
          "Fidji" => 'FJ',
          "Finlande" => 'FI',
          "France" => 'FR',
          "Gabon" => 'GA',
          "Gambie" => 'GM',
          "Géorgie" => 'GE',
          "Géorgie du Sud et les Îles Sandwich du Sud" => 'GS',
          "Ghana" => 'GH',
          "Gibraltar" => 'GI',
          "Grande Bretagne" => 'GB',
          "Grèce" => 'GR',
          "Grenade" => 'GD',
          "Groenland" => 'GL',
          "Guadeloupe" => 'GP',
          "Guam" => 'GU',
          "Guatemala" => 'GT',
          "Guernesey" => 'GG',
          "Guinée" => 'GN',
          "Guinée Équatoriale" => 'GQ',
          "Guinée-Bissau" => 'GW',
          "Guyana" => 'GY',
          "Guyane Française" => 'GF',
          "Haïti" => 'HT',
          "Honduras" => 'HN',
          "Hong Kong" => 'HK',
          "Hongrie" => 'HU',
          "Île Bouvet" => 'BV',
          "Île Christmas" => 'CX',
          "Île de Man" => 'IM',
          "Île Heard et Îles McDonald" => 'HM',
          "Île Norfolk" => 'NF',
          "Îles Caïmanes" => 'KY',
          "Îles Cocos (Keeling)" => 'CC',
          "Iles Cook" => 'CK',
          "Iles Féroé" => 'FO',
          "Iles Malouines" => 'FK',
          "Îles Marshall" => 'MH',
          "Îles Mineures Éloignées des États-Unis" => 'UM',
          "Îles Salomon" => 'SB',
          "Îles Turks et Caïques" => 'TC',
          "Îles Vierges Britanniques" => 'VG',
          "Îles Vierges Des États-Unis" => 'VI',
          "Inde" => 'IN',
          "Indonésie" => 'ID',
          "Irak" => 'IQ',
          "Iran" => 'IR',
          "Irlande" => 'IE',
          "Islande" => 'IS',
          "Israël" => 'IL',
          "Italie" => 'IT',
          "Jamaïque" => 'JM',
          "Japon" => 'JP',
          "Jersey" => 'JE',
          "Jordanie" => 'JO',
          "Kazakhstan" => 'KZ',
          "Kenya" => 'KE',
          "Kirghizistan" => 'KG',
          "Kiribati" => 'KI',
          "Koweït" => 'KW',
          "Laos" => 'LA',
          "Lesotho" => 'LS',
          "Lettonie" => 'LV',
          "Liban" => 'LB',
          "Libéria" => 'LR',
          "Libye" => 'LY',
          "Liechtenstein" => 'LI',
          "Lituanie" => 'LT',
          "Luxembourg" => 'LU',
          "Macao" => 'MO',
          "Macédoine" => 'MK',
          "Madagascar" => 'MG',
          "Malaisie" => 'MY',
          "Malawi" => 'MW',
          "Maldives" => 'MV',
          "Mali" => 'ML',
          "Malte" => 'MT',
          "Maroc" => 'MA',
          "Martinique" => 'MQ',
          "Maurice" => 'MU',
          "Mauritanie" => 'MR',
          "Mayotte" => 'YT',
          "Mexique" => 'MX',
          "Micronesie" => 'FM',
          "Moldavie" => 'MD',
          "Monaco" => 'MC',
          "Mongolie" => 'MN',
          "Monténégro" => 'ME',
          "Montserrat" => 'MS',
          "Mozambique" => 'MZ',
          "Myanmar" => 'MM',
          "Namibie" => 'NA',
          "Nauru" => 'NR',
          "Népal" => 'NP',
          "Nicaragua" => 'NI',
          "Niger" => 'NE',
          "Nigéria" => 'NG',
          "Nioué" => 'NU',
          "Norvège" => 'NO',
          "Nouvelle-Calédonie" => 'NC',
          "Nouvelle-Zélande" => 'NZ',
          "Oman" => 'OM',
          "Ouganda" => 'UG',
          "Ouzbékistan" => 'UZ',
          "Pakistan" => 'PK',
          "Palaos" => 'PW',
          "Palestine" => 'PS',
          "Panama" => 'PA',
          "Papouasie-Nouvelle-Guinée" => 'PG',
          "Paraguay" => 'PY',
          "Pays-Bas" => 'NL',
          "Pérou" => 'PE',
          "Philippines" => 'PH',
          "Pitcairn" => 'PN',
          "Pologne" => 'PL',
          "Polynésie française" => 'PF',
          "Portugal" => 'PT',
          "Puerto Rico" => 'PR',
          "Qatar" => 'QA',
          "République Centrafricaine" => 'CF',
          "République Dominicaine" => 'DO',
          "Réunion" => 'RE',
          "Roumanie" => 'RO',
          "Royaume-Uni" => 'UK',
          "Russie" => 'RU',
          "Rwanda" => 'RW',
          "Sahara Occidentale" => 'EH',
          "Saint-Kitts-et-Nevis" => 'KN',
          "Saint-Marin" => 'SM',
          "Saint-Pierre-et-Miquelon" => 'PM',
          "Saint-Vincent-et-les-Grenadines" => 'VC',
          "Sainte-Hélène" => 'SH',
          "Sainte-Lucie" => 'LC',
          "Salvador" => 'SV',
          "Samoa" => 'WS',
          "Samoa Americaine" => 'AS',
          "Sao Tomé et Principe" => 'ST',
          "Sénégal" => 'SN',
          "Serbie" => 'RS',
          "Serbie et Monténégro" => 'CS',
          "Seychelles" => 'SC',
          "Sierra Leone" => 'SL',
          "Singapour" => 'SG',
          "Slovaquie" => 'SK',
          "Slovénie" => 'SI',
          "Somalie" => 'SO',
          "Soudan" => 'SD',
          "Sri Lanka" => 'LK',
          "Suède" => 'SE',
          "Suisse" => 'CH',
          "Suriname" => 'SR',
          "Svalbard et Île Jan Mayen" => 'SJ',
          "Swaziland" => 'SZ',
          "Syrie" => 'SY',
          "Tadjikistan" => 'TJ',
          "Taiwan" => 'TW',
          "Tanzanie" => 'TZ',
          "Tchad" => 'TD',
          "Tchéquie" => 'CZ',
          "Terres Australes Françaises" => 'TF',
          "Territoire britannique de l'Océan Indien" => 'IO',
          "Thaïlande" => 'TH',
          "Timor-Oriental" => 'TL',
          "Togo" => 'TG',
          "Tokelau" => 'TK',
          "Tonga" => 'TO',
          "Trinité-et-Tobago" => 'TT',
          "Tunisie" => 'TN',
          "Turkménistan" => 'TM',
          "Turquie" => 'TR',
          "Tuvalu" => 'TV',
          "Ukraine" => 'UA',
          "Uruguay" => 'UY',
          "Vanuatu" => 'VU',
          "Vatican" => 'VA',
          "Venezuela" => 'VE',
          "Vietnam" => 'VN',
          "Wallis-et-Futuna" => 'WF',
          "Yémen" => 'YE',
          "Zambie" => 'ZM',
          "Zimbabwe" => 'ZW'}

  NAME_TO_CODE_ARRAY = NAME_TO_CODE.to_a.sort{|x,y| y[0] <=> x[0] }

end