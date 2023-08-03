local isPanelVisible = false -- Indica se o painel está visível (true) ou oculto (false)
local panelScale = 0 -- Guarda a escala atual do painel para controlar a animação de abertura/fechamento
local isPanelScale = 0 -- Representa a escala desejada do painel

-- Função para alternar a visibilidade do painel
function togglePanel()
    isPanelVisible = not isPanelVisible
    showCursor(isPanelVisible)

    if isPanelVisible then
        isPanelScale = 1 -- Configura a escala desejada para 1 (painel totalmente aberto)
        addEventHandler('onClientRender', root, renderPanel) -- Adiciona a função renderPanel para ser chamada continuamente
    else
        isPanelScale = 0 -- Configura a escala desejada para 0 (painel totalmente fechado)
    end
end

-- Função para renderizar o painel na tela
function renderPanel()
    local scaleDelta = isPanelScale - panelScale -- Calcula a diferença entre a escala desejada e a escala atual
    panelScale = panelScale + global['velocityOpen'] * scaleDelta -- Atualiza a escala atual para se aproximar da escala desejada usando a velocidade definida em global['velocityOpen']

    local panelX, panelY = (1366 - 280 * panelScale) / 2, (768 - 570 * panelScale) / 2 -- Calcula as coordenadas X e Y do painel com base na escala atual

    dxDrawRectangle(panelX + 0 * panelScale, panelY + 15 * panelScale, 400 * panelScale, 400 * panelScale) -- Desenha um retângulo na tela com dimensões ajustadas pela escala atual

    -- Verifica se o painel não está mais visível e se a diferença entre a escala desejada e a escala atual é menor ou igual à velocidade de fechamento definida em global['velocityClose']
    if not isPanelVisible and math.abs(scaleDelta) <= global['velocityClose'] then
        removeEventHandler('onClientRender', root, renderPanel) -- Remove a função renderPanel dos eventos de renderização para parar de renderizar o painel
    end
end

-- Vincula a função togglePanel à tecla 'k', para que o painel seja aberto/fechado ao pressionar a tecla 'k'
bindKey('k', 'down', togglePanel)
