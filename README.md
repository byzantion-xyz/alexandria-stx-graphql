# Alexandria STX GraphQL

## Overview

Alexandria STX GraphQL is a GraphQL layer that sits on top of both the Data Lake and Indexer databases. It has been built using hasura.io and enables you as a developer in the Stacks eco-system to rapidly implement a GraphQL API and start building your own dapps.

## Prerequisites

In order to implement and run this GraphQL layer, the following needs to be in place:

- [Alexandria STX Data Lake](https://github.com/byzantion-xyz/alexandria-stx-datalake)
- [Alexandria STX Indexer](https://github.com/byzantion-xyz/alexandria-stx-indexer)

Please refer to the repositories of these open source projects for all instructions on how to set them up. Once you have configures and installed them, and your database is up, ensure that you have the database connection URLs handy for the setup of the GraphQL layer.

## Implementation

Once you have the Data Lake and Indexer in place, you can start with the implementation of Alexandria STX GraphQL.

### Hasura

The GraphQL layer is built on top of [Hasura](https://hasura.io/). You have a number of options for deploying Hasura, but the primary choice is between going self-deployed or using Hasura Cloud. To read up more on Hasura, refer to the [Hasura Docs](https://hasura.io/docs/latest/index/). Some important things to familiarise yourself with regarding Hasura:

- [Hasura CLI](https://hasura.io/docs/latest/hasura-cli/index/) - You will need this for any local or self-deployment of Hasura.
- [Deploying Hasura GraphQL engine](https://hasura.io/docs/latest/deployment/index/) - This section of the docs explains how to deploy into various environments, as well as how to setup a project in Hasura Cloud.

Note that in this document we will be explaining how to setup your projects on **Hasura Cloud, Free Tier** to get you going.

### Setup

**Step 1: Hasura Cloud Projects** - You will create 2 projects in Hasura Cloud as follows:

1. Go to hasura.io and sign up.
1. In the Projects view, click on **New Project** at the top.
1. Select the **Free Tier** pricing plan - feel free to select Standard Tier if you would like to pay :-).
1. Change the project Name and give it an appropriate Environment Name as desired.

Ensure that you do the above once each for the Data Lake and the Indexer.

**Step 2: Set database environment variable** - In order to connect your project to your database, you will need an environment variable containing the PostgreSQL database URL (as mentioned un the prerequisites section):

- Click on the tabe called **Env vars**
- Click on the button with the plus sign, called **New Env Var**
- Create a key called `DB_CONN_ENV` with your database URL, which will be formatted like this: `postgres://user_name:user_pw@host_ip_or_name/db_name`
- click the Add button to save your new env variable

**Step 3: Fork this repo** - You must fork this repo in order to link your Hasura Cloud projects to github for deployment of the GraphQL Layer.

**Step 4: Deploy from Github** - Once you have your own forked repo, do the following to deploy into your projects from Github:

- Go into your project in Hasura
- Click on the **Git Deploy** tab
- Click on the **Setup Deployment** button on the top right
- Sign in with your GitHub account and connect the appropriate repository
- Select the **Repo** and **Branch**
- Enter the appropriate **Directory** inside the repo. It will be either `alexandria-datalake-graphql` or `alexandria-indexer-graphql`
- Select your desired **Deployment Mode**
- Click on the **Setup Git Deployment** button
- Finally, click on the **Deploy Now** button next to **Latest Commit** to start the deploy
- Once the deploy is complete, you are ready to use your GraphQL API by clicking on the **Launch Console** button
