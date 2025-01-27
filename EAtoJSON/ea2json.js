#!/usr/bin/env ts-node

/*
 * NodeJS application to extract data from EA to JSON
 * EA is the only source of truth for ESPD EDM and we need to
 * export this data for:
 * ESPD releases
 * ESPD Demo site
 * ESPD Service implementers 
 *
 * Data will be structured in the same way as in epo-tools see https://github.com/OP-TED/epo-tools
 */

import chalk from "chalk"
import pkgcc from "@caporal/core"
import fs from "fs"
import path from 'path'
import MDBReader from 'mdb-reader'
import { dbToJson } from './db-to-json.js'

const { program } = pkgcc
const log = console.log;

program
    .version("1.0.0")
    .name("ea2json")
    .description("Tool to handle EA file")

    .command("extract", "Extract data from EA to JSON")
    .argument("<eafile>", "EA .eapx file to be processed")
    .action(({ logger, args, options }) => {
        // Open the database
        try {
            if (!args.eafile || !fs.existsSync(args.eafile)) {
                console.error("Missing filename");
                process.exit(1);
            } else {
                log(chalk.bold(chalk.blueBright(`Processing ${path.resolve(args.eafile)}`)), "\n");

                const buffer = fs.readFileSync(path.resolve(args.eafile));
                const reader = new MDBReader(buffer)
                const objects = reader.getTable('t_object').getData()
                const objectProperties = reader.getTable('t_objectproperties').getData()
                const attributes = reader.getTable('t_attribute').getData()
                const connectors = reader.getTable('t_connector').getData()


                console.log(JSON.stringify(dbToJson({objects, objectProperties, attributes, connectors}), null, 2) )

            }


        } catch (error) {
            console.error(error.message);
        }


    })

// launch the main loop
program.run();
