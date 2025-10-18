# Minhas Notas

Um aplicativo moderno e elegante de notas construído com Flutter, apresentando Material Design 3, internacionalização e arquitetura limpa.

> **Nota**: Este é um repositório privado para desenvolvimento do aplicativo Minhas Notas.

## Recursos

- **Gerenciamento de Notas**: Criar, visualizar, editar e excluir notas
- **Organização por Cores**: 6 opções de cores para categorizar suas notas
- **Multi-idioma**: Suporte completo para Português (BR) e Inglês
- **Design Moderno**: Interface Material 3 com modo claro e escuro
- **Animações Suaves**: Transições fluidas e feedback visual
- **Armazenamento Local**: Banco de dados SQLite para persistência offline
- **Segurança**: Variáveis de ambiente protegidas com .env
- **Responsivo**: Interface adaptável a diferentes tamanhos de tela

## Tecnologias

- **Flutter** ^3.6.0 - Framework UI multiplataforma
- **Riverpod** ^3.0.3 - Gerenciamento de estado reativo
- **GoRouter** ^16.2.1 - Navegação type-safe
- **SQLite** ^2.4.0 - Banco de dados local
- **Google Fonts** (Inter) - Tipografia moderna
- **flutter_localizations** - Sistema de internacionalização
- **flutter_dotenv** - Gerenciamento seguro de variáveis

## Estrutura do Projeto

```
lib/
├── core/
│   ├── config/          # Configurações (env, constantes)
│   └── theme/           # Temas e cores do app
├── l10n/                # Arquivos de tradução (pt-BR, en)
├── model/               # Modelos de dados
├── providers/           # Providers Riverpod
├── screens/             # Telas do aplicativo
│   ├── home_screen.dart
│   ├── add_edit_screen.dart
│   └── view_note_screen.dart
├── services/            # Serviços (database, etc)
├── utils/               # Utilitários (formatação de data, etc)
├── widgets/             # Widgets reutilizáveis
└── main.dart            # Ponto de entrada
```

## Pré-requisitos

- Flutter SDK >= 3.3.4
- Dart SDK >= 3.0.0
- Android Studio / VS Code
- Emulador Android ou dispositivo físico

## Desenvolvimento

### Setup do Ambiente

1. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Configure o arquivo .env**
   ```bash
   cp .env.example .env
   ```

   Edite o `.env` com suas configurações:
   ```env
   APP_NAME=My Notes
   APP_VERSION=1.0.0
   ```

4. **Gere os arquivos de localização**
   ```bash
   flutter gen-l10n
   ```

5. **Execute o aplicativo**
   ```bash
   flutter run
   ```

## Comandos Úteis

### Análise de Código
```bash
flutter analyze
```

### Testes
```bash
flutter test
```

### Build para Produção

**Android**
```bash
flutter build apk --release
# ou
flutter build appbundle --release
```

**iOS**
```bash
flutter build ios --release
```

### Gerar Ícones
```bash
dart run flutter_launcher_icons
```

### Gerar Splash Screen
```bash
dart run flutter_native_splash:create
```

## Internacionalização

O app suporta os seguintes idiomas:
- Português (Brasil) - `pt-BR` (padrão)
- Inglês - `en`

### Adicionar um Novo Idioma

1. Crie um novo arquivo ARB em `lib/l10n/`:
   ```
   app_es.arb  # Para espanhol, por exemplo
   ```

2. Copie as strings de `app_pt.arb` e traduza

3. Adicione o locale em `lib/main.dart`:
   ```dart
   supportedLocales: const [
     Locale('pt', 'BR'),
     Locale('en', ''),
     Locale('es', ''),  // Novo idioma
   ],
   ```

4. Regenere os arquivos:
   ```bash
   flutter gen-l10n
   ```

## Arquitetura

O projeto segue os princípios de Clean Architecture:

- **Separação de Responsabilidades**: UI, lógica de negócio e dados são separados
- **Inversão de Dependência**: Uso de providers para injeção de dependências
- **Testabilidade**: Código desacoplado facilita testes unitários
- **Reatividade**: Riverpod para gerenciamento de estado reativo

### Fluxo de Dados

```
UI (Screens/Widgets)
    ↓
Providers (NotesNotifierProvider)
    ↓
Services (DatabaseHelper)
    ↓
SQLite Database
```

## Funcionalidades por Tela

### Home Screen
- Lista de notas em grid com animações
- Pull-to-refresh para atualizar
- Botão flutuante para criar nova nota
- Estado vazio com mensagem amigável

### Add/Edit Screen
- Formulário com validação
- Seletor de cores com 6 opções
- Feedback visual de carregamento
- Salvamento automático de data/hora

### View Screen
- Visualização completa da nota
- Botões para editar e excluir
- Diálogo de confirmação de exclusão
- Texto selecionável

## Configurações do Banco de Dados

### Tabela Notes
```sql
CREATE TABLE notes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  color INTEGER NOT NULL,
  dateTime TEXT NOT NULL
)
```

### Índices
- `idx_dateTime` - Ordenação por data
- `idx_title` - Busca por título

## Personalização

### Alterar Cores do Tema

Edite `lib/core/theme/app_theme.dart`:

```dart
static const Color primaryColor = Color(0xFF10B981); // Verde esmeralda
```

### Alterar Cores das Notas

Edite `lib/core/theme/app_theme.dart`:

```dart
static const List<Color> noteColors = [
  Color(0xFFFCD34D), // Amarelo
  // ... adicione suas cores
];
```

## Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

## Autor

**NFDTech** - 2025

---

## Roadmap de Funcionalidades

Lista de recursos planejados para futuras versões:

- [ ] **Busca Avançada**: Buscar notas por título e conteúdo
- [ ] **Categorias/Tags**: Organizar notas com tags personalizadas
- [ ] **Backup na Nuvem**: Sincronização automática com Google Drive
- [ ] **Widget**: Widget para tela inicial do Android
- [ ] **Nota por Voz**: Criar notas usando reconhecimento de voz
- [ ] **Anexar Imagens**: Adicionar fotos às notas
- [ ] **Exportar**: Exportar notas em PDF e TXT
- [ ] **Temas Personalizados**: Mais opções de cores e temas

## Suporte

Para suporte, entre em contato através de [nfdtechsoftware@gmail.com]
