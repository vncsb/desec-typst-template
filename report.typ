#import "settings.typ": *
#import "table-headers.typ": h-header, v-header
#include "cover.typ"
#pagebreak()

#set text(font: "Arial", size: 12pt)
#set page(
  paper: "us-letter",
  margin: (top: 3cm, left: 2cm, right: 2cm, bottom: 2cm),
  header: [
    #align(left)[
      #image("images/header.png", width: 3.16cm, height: 0.99cm)
    ]
  ],
  footer: [
    #set text(size: 9pt)
    #align(center)[
      #grid(
        columns: (1fr, 1fr),
        rows: 1,
        align: (left, right),
        stroke: (top: 0.5pt),
        inset: 5pt,
        [PENETRATION TESTING REPORT | BUSINESS CORP], [_CONFIDENCIAL_],
      )
      #image("images/footer.png", width: 2.58cm, height: 0.80cm)
    ]
  ],
  footer-descent: 0%,
)

#show heading: set text(fill: highlight-fill-color, size: 14pt)

= Controle de Versões
\

#h-header(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    [DATA], [VERSÃO], [AUTOR], [ALTERAÇÕES],
    [zc], [zxcv], [zxcv], [zcvv],
    [xcv], [zxcv],
  ),
)

\
\
#h-header(
  table(
    columns: 1fr,
    table.header([_CONFIDENCIAL_]),
    [
      _Este documento contém informações proprietárias e confidenciais e todos os dados encontrados durante os testes e presentes neste documento foram tratados de forma a garantir a privacidade e o sigilo dos mesmos. A duplicação, redistribuição ou uso no todo ou em parte de qualquer forma requer o consentimento da *BusinessCorp*_.
    ]
  ),
)
#pagebreak()

= Aviso Legal
\
O Pentest foi realizado durante o período de *01/05/2020* até *15/05/2020*. As constatações e recomendações refletem as informações coletadas durante a avaliação e estado do ambiente naquele momento e não quaisquer alterações realizadas posteriormente fora deste período. \

O trabalho desenvolvido pela DESEC SECURITY *NÃO* tem como objetivo corrigir as possíveis vulnerabilidades, nem proteger a CONTRATANTE contra ataques internos e externos, nosso objetivo é fazer um levantamento dos riscos e recomendar formas para minimizá-los. \

As recomendações sugeridas neste relatório devem ser testadas e validadas pela equipe técnica da empresa CONTRATANTE antes de serem implementadas no ambiente em produção. A DESEC SECURITY *não se responsabiliza* por essa implementação e possíveis impactos que possam vir a ocorrer em outras aplicações ou serviços.
\
\
= Informações de Contato
\
#h-header(
  table(
    columns: (1fr, 1fr, 1.5fr),
    [NOME], [CARGO], [INFORMAÇÕES],
    table.cell(
      fill: highlight-fill-color,
      align: center + horizon,
      colspan: 3,
      text(fill: white)[*BUSINESS CORP*],
    ),
    [José dos Santos], [Diretor de Segurança da Informação], [
      *Telefone*: (00) 0 1234-4321 \
      *Email*: jsantos\@grupobusinesscorp.com
    ],
    table.cell(
      fill: highlight-fill-color,
      align: center + horizon,
      colspan: 3,
      text(fill: white)[*CORPO TÉCNICO | DESEC SECURITY*],
    ),
    [Ricardo Longatto], [Penetration Tester], [
      *Telefone*: (00) 0 1234-4321 \
      *Email*: \@desecsecurity.com
    ],
  ),
)
#pagebreak()

#let critical = table.cell(
  fill: critical-color,
  text(fill: white)[Crítico],
)
#let high = table.cell(
  fill: high-color,
  text(fill: white)[Alto],
)
#let medium = table.cell(
  fill: medium-color,
  text(fill: white)[Médio],
)
#let low = table.cell(
  fill: low-color,
  text(fill: white)[Baixo],
)

= Sumário Executivo
\
A Desec Security avaliou a postura de segurança da Business Corp através de um Pentest Externo pelo período de 01 de maio de 2020 até 15 de maio de 2020. Os resultados das avaliações efetuadas no ambiente a partir da internet demonstram que a empresa possui sérios riscos cibernéticos com a presença de vulnerabilidades de nível *CRÍTICO* que *comprometem a integridade, disponibilidade e o sigilo de informações sensíveis*.
\
#figure(
  image("images/graph.png", width: 100%),
)
#h-header(
  table(
    columns: (auto, 1fr),
    [RISCO], [VULNERABILIDADE],
    critical,
    [A falha no webmin permite obter arquivos sensíveis do servidor *(CVE-2006-3392)*],

    high,
    [Foi possível acessar contas válidas do webmail através de credenciais obtidas na internet],
  ),
)
\
É altamente recomendável que a Business Corp resolva as vulnerabilidades classificadas como risco crítico com *alta prioridade* para que não haja um impacto negativo para os negócios, visto a criticidade das vulnerabilidades encontradas e passíveis de serem exploradas através da internet.
#pagebreak()

A tabela abaixo resume as principais vulnerabilidades e riscos encontrados durante os testes realizados e ao final deste relatório são propostas as recomendações para mitigação dos problemas encontrados.
#text(size: 10pt)[
  #v-header(
    table(
      columns: (auto, 1fr),
      align: left + horizon,
      [Descrição],
      [A falha no webmin permite obter arquivos sensíveis do servidor (CVE-2006-3392)],

      [Risco], critical,
      [Impacto],
      [Explorando a vulnerabilidade é possível obter arquivos sensíveis do servidor e posteriormente descobrir as credenciais de acesso ao SSH.],

      [Sistema], [http://intranet.businesscorp.com.br:10000],
      [Recomendação],
      [Atualizar a versão do webmin e melhorar a política de senhas],
    ),
  )
]

#pagebreak()
= Introdução
\
A Desec Security foi contratada para conduzir uma avaliação de segurança _(Penetration Testing)_ no ambiente digital da Business Corp.

A avaliação foi conduzida de maneira a simular um ciberataque à partir da internet com o objetivo de determinar o impacto que possíveis vulnerabilidades de segurança possam ter no que diz respeito à *integridade, disponibilidade e confidencialidade* das informações da empresa contratante.

Os testes foram realizados entre os dias 01 de maio de 2020 e 15 de maio de 2020 e este documento contém todos os resultados.

O método utilizado para a execução do serviço proposto segue rigorosamente as melhores práticas de mercado, garantindo a adequação às normas internacionais de segurança da informação, e os relatórios gerados apontam evidências quanto à segurança do ambiente definido no escopo.

= Escopo

#h-header(
  table(
    columns: (1fr, 1fr),
    [TIPO DE AVALIAÇÃO], [DETALHES],
    [Pentest Black Box Externo], [37.59.174.226],
    [Pentest Black Box Externo], [37.59.174.228],
    [Pentest Black Box Externo], [37.59.174.229],
  ),
)

De acordo com o combinado e acordado entre as partes, a avaliação escolhida foi do tipo *Black Box (sem conhecimento de informações)*, ou seja, a única informação oferecida pela CONTRATANTE foi uma URL.

#pagebreak()
#set list(
  indent: 15pt,
  marker: align(center + horizon)[
    #square(
      width: 5pt,
      fill: highlight-fill-color,
      stroke: highlight-fill-color,
    )
  ],
)

= Limitações do Escopo
\
As *limitações* impostas pela CONTRATANTE foram:

- Os testes devem encerrar caso seja possível comprometer algum host na rede interna
- Ataques DoS e DDoS (Negação de Serviço)
- Ataques de Engenharia Social

= Metodologia
\
Para execução destes trabalhos, a Desec Security adotou a metodologia própria mesclada com padrões existentes e solidamente reconhecidos, tais como PTES (Penetration Testing Execution Standard) e OWASP Top Ten nas quais foram executados nas seguintes fases:

- Coleta de Informações
- Varredura
- Enumeração
- Exploração
- Pós Exploração
- Documentação

A fase de coleta de informações tem como objetivo mapear a superfície de ataque, identificando informações sobre blocos de ip, subdomínios e ambientes digitais de propriedade da Business Corp.

A fase de varredura consiste em identificar portas abertas, serviços ativos e possíveis mecanismos de defesa.

A fase de enumeração permite identificar detalhes sobre os serviços ativos, identificando possíveis versões, fornecedores, usuários e informações que possam ser uteis para o sucesso de um ataque.

A fase de exploração tem como objetivo explorar as possíveis vulnerabilidades identificadas nos serviços e sistemas identificados nas fases anteriores e obter acesso ao sistema.

A fase de pós exploração tem como objetivo aprofundar o ataque obtendo mais privilégios e aumentando o nível de acesso, se deslocando para outros sistemas afim de controlar ou extrair dados mais sensíveis.

A fase de documentação consiste em relatar todos os resultados obtidos nas fases anteriores.
#pagebreak()

#align(center)[
  #heading()[Narrativa da Análise Técnica]
]
\
Os testes iniciaram no dia 01/05/2020 de posse apenas dos endereços informados pelo cliente.
\
#align(center)[
  #heading()[HOST 37.59.174.226]
]
\

#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)


= _Coleta de Informações_
\
Durante a fase de coleta de informações identificamos que o bloco de IP registrado para *Business Corp*.
#align(center)[
  #h-header(
    table(columns: auto,
      [BLOCO DE IP],
      [37.59.174.224 - 37.59.174.239]),
  )
]
\
#figure(
  image("images/ip-block.png", width: 80%),
)
Realizamos uma pesquisa de IP reverso e identificamos dois subdomínios.

#figure(
  image("images/subdomains.png", width: 80%),
)
\
Após, um scan TCP com a ferramente nmap encontramos as portas abertas:
#align(center)[
  ```
  $ sudo nmap -Pn ns2.businesscorp.com.br
  Starting Nmap 7.92 ( https://nmap.org ) at 2022-05-03 11:41 -03
  Nmap scan report for ns2.businesscorp.com.br (37.59.174.226)
  Host is up (0.17s latency).
  rDNS record for 37.59.174.226: ip226.ip-37-59-174.eu
  Not shown: 995 closed tcp ports (reset)
  PORT    STATE    SERVICE
  19/tcp  filtered chargen
  22/tcp  open     ssh
  25/tcp  filtered smtp
  53/tcp  open     domain
  111/tcp open     rpcbind
  Nmap done: 1 IP address (1 host up) scanned in 6.64 seconds
  ```
]

#set enum(numbering: "1)")

#align(center)[= Vulnerabilidades e Recomendações]
\
#v-header(
  table(
    columns: (0.2fr, 1fr),
    [HOST], [37.59.174.228],
  ),
)

#v-header(
  table(
    columns: (0.2fr, 1fr),
    [Descrição],
    [A versão do webmin em produção no servidor possuí uma vulnerabilidade crítica que contém exploit público disponível.],

    [Risco], critical,
    [Impacto],
    [A falha permite um atacante obter arquivos sensíveis no servidor e posteriormente descobrir as credenciais de acessos do SSH.],

    [Sistema], [http://intranet.businesscorp.com.br:10000],
    [Referências],
    [https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3392],
  ),
)
\
= Problemas
\
+ Versão do software em produção desatualizada e vulnerável
+ Este host possui um controle contra portscan ineficiente, ou seja, mesmo com o controle ativo é possível fazer uma varredura de portas e descobrir os serviços ativos. 
+ Politica de senha fraca pois a senha utilizada no hash do user (business) foi descoberta por conta de fazer parte de wordlists conhecidas.

= Recomendações
\
+ *Atualizar* a versão do webmin para a mais recente no site do fabricante
+ Ajustar o controle contra *portscan* para bloquear acessos ao tentar se comunicar com pelo menos 1 porta inválida
+ Usar senhar fortes geradas por cofres de senha

#pagebreak()

= Considerações Finais
\
A realização deste teste de segurança permitiu identificar vulnerabilidades e problemas de segurança que *poderiam causar um impacto negativo* aos negócios do cliente. Com isso podemos concluir que o teste atingiu o objetivo proposto. 

Podemos concluir que a avaliação de segurança como o *teste de invasão* apresentado neste relatório é fundamental para identificar vulnerabilidades, testar e melhorar controles e mecanismos de defesa afim de garantir um bom grau de segurança da informação em seu ambiente digital.

Após a CONTRATANTE aplicar todas as correções sugeridas faremos um reteste nas vulnerabilidades apresentadas para comprovar que os problemas foram devidamente resolvidos.

Desde já agradecemos a Business Corp pela oportunidade em oferecer nossos serviços de segurança ofensiva.

