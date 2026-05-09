-- ========================================
-- FLY HACK BÁSICO PARA GAME GUARDIAN
-- by @Txchris123 (Exemplo Educacional)
-- ========================================

-- Configurações
local SEARCH_RANGE = "100~10000"
local FLY_HEIGHT = 9999
local ALTITUDE_TYPE = gg.TYPE_FLOAT

-- Cores e mensagens
local function toast(msg)
    gg.toast(msg)
end

local function alert(msg)
    gg.alert(msg)
end

-- FUNÇÃO PRINCIPAL
function flyHack()
    gg.setVisible(false)
    
    -- Passo 1: Instruções
    alert("📋 INSTRUÇÕES:\n1. Abra o jogo\n2. Coloque seu personagem em modo de voo\n3. Pressione OK para começar")
    toast("🔍 Procurando valor de altura...")
    
    -- Passo 2: Primeira busca
    gg.searchNumber(SEARCH_RANGE, ALTITUDE_TYPE)
    local firstResults = gg.getResultsCount()
    toast("✅ Encontrados: " .. firstResults .. " valores")
    
    if firstResults == 0 then
        alert("❌ Nenhum valor encontrado! Tente outro intervalo.")
        return
    end
    
    -- Passo 3: Refinamento
    alert("🎮 Agora SUBA ou DESÇA com o personagem no jogo!\nDepois pressione OK")
    toast("🔄 Refinando resultados...")
    
    gg.refineNumber(SEARCH_RANGE, ALTITUDE_TYPE)
    local refinedResults = gg.getResultsCount()
    toast("✅ Refinado para: " .. refinedResults .. " valores")
    
    if refinedResults == 0 then
        alert("❌ Refinamento falhou! Tente novamente.")
        return
    end
    
    -- Passo 4: Aplicar hack
    alert("✈️ Você está pronto?\nPressione OK para VOAR!")
    
    gg.getResults(math.min(50, refinedResults)) -- Pega até 50 resultados
    gg.editAll(FLY_HEIGHT, ALTITUDE_TYPE)
    
    gg.setVisible(true)
    alert("🚀 SUCESSO!\n✈️ Você está voando!\n\nPara desativar, feche e reabra o jogo.")
    gg.setVisible(false)
end

-- FUNÇÃO DE BUSCA AVANÇADA
function advancedFlyHack()
    gg.setVisible(false)
    
    alert("⚙️ MODO AVANÇADO:\n1. Insira valor de altura atual\n2. Digite novo valor de altura")
    
    local currentHeight = gg.prompt({"Digite altura atual:"}, {100}, {"number"})
    if not currentHeight then return end
    
    toast("🔍 Buscando: " .. currentHeight[1])
    gg.searchNumber(currentHeight[1], ALTITUDE_TYPE)
    
    if gg.getResultsCount() == 0 then
        alert("❌ Valor não encontrado!")
        return
    end
    
    alert("⬆️ Mude a altura do personagem no jogo")
    
    local newHeight = gg.prompt({"Digite nova altura:"}, {9999}, {"number"})
    if not newHeight then return end
    
    gg.refineNumber(newHeight[1], ALTITUDE_TYPE)
    local results = gg.getResultsCount()
    
    if results > 0 then
        gg.getResults(math.min(50, results))
        gg.editAll(newHeight[1], ALTITUDE_TYPE)
        gg.setVisible(true)
        alert("✈️ VOANDO!\nValor modificado para: " .. newHeight[1])
        gg.setVisible(false)
    else
        alert("❌ Nenhum resultado encontrado após refinamento!")
    end
end

-- MENU PRINCIPAL
function showMenu()
    local menu = gg.choice(
        {"🚀 Fly Hack Básico", 
         "⚙️ Fly Hack Avançado", 
         "❌ Sair"},
        nil,
        "✈️ GAME GUARDIAN FLY HACK by @Txchris123"
    )
    
    if menu == 1 then
        flyHack()
    elseif menu == 2 then
        advancedFlyHack()
    elseif menu == 3 then
        gg.setVisible(true)
        return
    end
    
    showMenu() -- Loop do menu
end

-- ========================================
-- EXECUTAR
-- ========================================
showMenu()
