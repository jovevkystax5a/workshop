#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

# The private key and address of the bank.
# Swap these into program.json, when running transactions as the first bidder.
# "private_key": "APrivateKey1zkpHtqVWT6fSHgUMNxsuVf7eaR6id2cj7TieKY1Z8CP5rCD",
# "address": "aleo1t0uer3jgtsgmx5tq6x6f9ecu8tr57rzzfnc2dgmcqldceal0ls9qf6st7a"

# The private key and address of the user.
# Swap these into program.json, when running transactions as the second bidder.
# "private_key": "APrivateKey1zkp75cpr5NNQpVWc5mfsD9Uf2wg6XvHknf82iwB636q3rtc"
# "address": "aleo1zeklp6dd8e764spe74xez6f8w27dlua3w7hl4z2uln03re52egpsv46ngg"

# Swap in the private key and address of the bank to program.json.
echo "{
  \"program\": \"basic_bank.aleo\",
  \"version\": \"0.0.0\",
  \"description\": \"\",
  \"development\": {
      \"private_key\": \"APrivateKey1zkpHtqVWT6fSHgUMNxsuVf7eaR6id2cj7TieKY1Z8CP5rCD\",
      \"address\": \"aleo1t0uer3jgtsgmx5tq6x6f9ecu8tr57rzzfnc2dgmcqldceal0ls9qf6st7a\"
  },
  \"license\": \"MIT\"
}" > program.json

# Have the bank issue 100 tokens to the user.
echo "
###############################################################################
########                                                               ########
########     STEP 1: Initialize 100 tokens for aleo1zeklp...v46ngg     ########
########                                                               ########
########           -----------------------------------------           ########
########           |      BANK       | aleo1zeklp...v46ngg |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |  Start Balance  |          0          |           ########
########           -----------------------------------------           ########
########           |        Periods  |          0          |           ########
########           -----------------------------------------           ########
########           |  Interest Rate  |        12.34%       |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Issuing  |         100         |           ########
########           -----------------------------------------           ########
########           |     Depositing  |          0          |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |    Withdrawing  |          0          |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |  Final Balance  |          0          |           ########
########           -----------------------------------------           ########
########                                                               ########
###############################################################################
"
leo run issue aleo1zeklp6dd8e764spe74xez6f8w27dlua3w7hl4z2uln03re52egpsv46ngg 100u64;

# Swap in the private key and address of the user to program.json.
echo "{
  \"program\": \"basic_bank.aleo\",
  \"version\": \"0.0.0\",
  \"description\": \"\",
  \"development\": {
      \"private_key\": \"APrivateKey1zkp75cpr5NNQpVWc5mfsD9Uf2wg6XvHknf82iwB636q3rtc\",
      \"address\": \"aleo1zeklp6dd8e764spe74xez6f8w27dlua3w7hl4z2uln03re52egpsv46ngg\"
  },
  \"license\": \"MIT\"
}" > program.json

# Have the user deposit 50 tokens into the bank.
echo "
###############################################################################
########                                                               ########
########        STEP 2: aleo1zeklp...v46ngg deposits 50 tokens         ########
########                                                               ########
########           -----------------------------------------           ########
########           |      BANK       | aleo1zeklp...v46ngg |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |  Start Balance  |          0          |           ########
########           -----------------------------------------           ########
########           |        Periods  |          0          |           ########
########           -----------------------------------------           ########
########           |  Interest Rate  |        12.34%       |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Issuing  |          0          |           ########
########           -----------------------------------------           ########
########           |     Depositing  |         50          |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |    Withdrawing  |          0          |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |  Final Balance  |          50         |           ########
########           -----------------------------------------           ########
########                                                               ########
###############################################################################
"
leo run deposit "{
    owner: aleo1zeklp6dd8e764spe74xez6f8w27dlua3w7hl4z2uln03re52egpsv46ngg.private,
    gates: 0u64.private,
    amount: 100u64.private,
    _nonce: 4668394794828730542675887906815309351994017139223602571716627453741502624516group.public
}"  50u64

echo "
###############################################################################
########                                                               ########
########                    STEP 3: Wait 15 periods                    ########
########                                                               ########
###############################################################################
"

# Swap in the private key and address of the bank to program.json.
echo "{
  \"program\": \"basic_bank.aleo\",
  \"version\": \"0.0.0\",
  \"description\": \"\",
  \"development\": {
      \"private_key\": \"APrivateKey1zkpHtqVWT6fSHgUMNxsuVf7eaR6id2cj7TieKY1Z8CP5rCD\",
      \"address\": \"aleo1t0uer3jgtsgmx5tq6x6f9ecu8tr57rzzfnc2dgmcqldceal0ls9qf6st7a\"
  },
  \"license\": \"MIT\"
}" > program.json

# Have the bank withdraw all of the user's tokens with compound interest over 15 periods at 12.34%.
echo "
###############################################################################
########                                                               ########
########  STEP 4: Withdraw tokens of aleo1zeklp...v46ngg w/ interest   ########
########                                                               ########
########           -----------------------------------------           ########
########           |      BANK       | aleo1zeklp...v46ngg |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |  Start Balance  |         266         |           ########
########           -----------------------------------------           ########
########           |        Periods  |          15         |           ########
########           -----------------------------------------           ########
########           |  Interest Rate  |        12.34%       |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Issuing  |          0          |           ########
########           -----------------------------------------           ########
########           |     Depositing  |          0          |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |    Withdrawing  |         266         |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |  Final Balance  |          0          |           ########
########           -----------------------------------------           ########
########                                                               ########
###############################################################################
"
leo run withdraw aleo1t0uer3jgtsgmx5tq6x6f9ecu8tr57rzzfnc2dgmcqldceal0ls9qf6st7a 50u64 1234u64 15u64;
