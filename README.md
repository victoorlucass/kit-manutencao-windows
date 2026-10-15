🛠️ Kit de Manutenção do Windows

- Um utilitário desenvolvido em Batch Script (.bat) para facilitar tarefas de limpeza, manutenção e diagnóstico do Windows 10 e Windows 11.

- O projeto reúne ferramentas nativas do sistema em um menu interativo, ajudando a automatizar tarefas comuns após uma formatação ou durante a manutenção periódica do computador.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


✨ Funcionalidades


🧹 Limpeza e manutenção

- Limpeza dos arquivos temporários do usuário.

- Limpeza dos arquivos temporários do Windows.

- Limpeza opcional dos arquivos baixados pelo Windows Update.

- Otimização de unidades utilizando ferramentas nativas do Windows.

- Desativação opcional da hibernação para liberar espaço em disco.

- Acesso à Limpeza de Disco e às Configurações de Armazenamento.

- Verificação e reparo de arquivos do sistema com DISM e SFC.


💻 Instalação de programas

- Instalação opcional de aplicativos utilizando o Windows Package Manager (winget):

- Google Chrome

- Mozilla Firefox

- 7-Zip

- VLC Media Player

- Visual Studio Code

- Git

- Python 3


🔎 Diagnóstico do computador

- Acesso rápido às ferramentas de diagnóstico do Windows:

- Gerenciador de Tarefas

- Gerenciador de Dispositivos

- Monitor de Recursos

- Monitor de Confiabilidade

- Informações do Sistema

- O programa também permite gerar um relatório com informações do computador, incluindo processador, memória RAM, versão do Windows, unidades e espaço livre.


⚙️ Rotina pós-formatação

- Uma opção reúne a limpeza dos arquivos temporários e a otimização das unidades, facilitando a manutenção inicial após a instalação do Windows.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


🚀 Como utilizar

- Baixe o arquivo Kit_Manutencao_Windows_v2.bat na seção de arquivos deste repositório.

- Salve o arquivo em uma pasta de sua preferência.

- Execute o arquivo e autorize a elevação de privilégios quando necessário.

- Escolha a operação desejada no menu.

- Leia as mensagens e confirmações antes de executar cada tarefa.


Requisitos:

- Windows 10 ou Windows 11.

- Permissão de administrador para as operações que exigem privilégios elevados.

- Conexão com a internet para instalações pelo winget e para determinadas operações de reparo do sistema.

- Windows Package Manager instalado para utilizar o instalador de programas.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


⚠️ Avisos importantes

- Arquivos temporários em uso ou protegidos podem não ser removidos.

- A limpeza dos downloads do Windows Update pode exigir que alguns arquivos sejam baixados novamente. Não execute durante atualizações em andamento.

- A otimização de discos utiliza recursos do Windows, que seleciona operações apropriadas conforme a unidade e sua configuração.

- Desativar a hibernação remove a possibilidade de utilizar esse recurso e pode desativar a Inicialização Rápida.

- A limpeza de Prefetch é opcional e geralmente desnecessária; não é recomendada como rotina de otimização.

- DISM e SFC podem demorar e devem ser utilizados para diagnóstico ou reparo, não como promessa de aumento de desempenho.

- Revise as operações antes de executá-las e mantenha backups dos dados importantes.

- Este projeto não desativa automaticamente serviços essenciais nem promete ganhos de desempenho que não possam ser verificados.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


🧰 Tecnologias utilizadas

- Batch Script (.bat)

- Windows Command Prompt

- PowerShell

- DISM e SFC

- Windows Package Manager (winget)

- Ferramentas nativas de manutenção do Windows


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


🗺️ Roadmap

- [x]Menu interativo de manutenção.

- [x]Limpeza de arquivos temporários.

- [x]Otimização de unidades.

- [x]Instalação opcional de programas pelo winget.

- [x]Relatório básico do computador.

- [ ]Registro detalhado das operações em arquivo de log.

- [ ]Medição mais completa do espaço liberado.

- [ ]Diagnóstico aprimorado de SSDs e HDDs.

- [ ]Instalação de ferramentas de desenvolvimento.

- [ ]Criação opcional de ponto de restauração.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


📌 Objetivo do projeto

- Este projeto foi desenvolvido como iniciativa de aprendizado e prática em automação de tarefas no Windows, organização de scripts e criação de ferramentas úteis para o dia a dia.

- O objetivo é evoluir o utilitário gradualmente, priorizando segurança, facilidade de uso e documentação.
