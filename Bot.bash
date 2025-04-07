#!/bin/bash

# VARIÁVEIS
RESOURCE_GROUP="bot-rg"
APP_NAME="botservice-html-$(date +%s)"  # nome único
PLAN_NAME="bot-plan"
LOCATION="francecentral"

# 1. Criar Resource Group
az group create --name $RESOURCE_GROUP --location $LOCATION

# 2. Criar App Service Plan (Linux, Básico)
az appservice plan create \
  --name $PLAN_NAME \
  --resource-group $RESOURCE_GROUP \
  --sku B1 \
  --is-linux

# 3. Criar Web App (stack PHP que serve HTML direto)
az webapp create \
  --resource-group $RESOURCE_GROUP \
  --plan $PLAN_NAME \
  --name $APP_NAME \
  --runtime "PHP|8.0"

# 4. Ligar ao GitHub
az webapp deployment source config \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --repo-url https://github.com/JoseAgostinho/BotServiceTest \
  --branch main \
  --repository-type github

# 5. Mostrar link final
APP_URL="https://$APP_NAME.azurewebsites.net"
echo ""
echo "✅ Deploy iniciado! Verifica em breve:"
echo "$APP_URL/chatbot.html"
