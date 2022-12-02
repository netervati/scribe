# Scribe
*Scribe* is a simple command-line tool for managing your to-do lists. Clone this repository then open the project folder and type this command in your terminal:
```bash
$ ruby app.rb
```

![Project demonstration.](https://github.com/netervati/scribe/blob/main/assets/scribe-demo.gif)

## Commands
- Start a new project
```bash
>> scribe init <project-name>
```
- Check current project
```bash
>> scribe --project
```
- Delete a project
```bash
>> scribe delete <project-name>
```
- Open an existing project
```bash
>> scribe open <project-name>
```
- Add to-do item
```bash
>> scribe add "<description>" 
```
- Check to-do item
```bash
>> scribe check "<item-number>" 
```
- Uncheck to-do item
```bash
>> scribe uncheck "<item-number>" 
```
- Remove to-do item
```bash
>> scribe remove "<item-number>" 
```
- List items in project
```bash
>> scribe --list
```
- Exit CLI
```bash
>> exit
```

## About
This project serves as my playground for exploring [Sorbet](https://sorbet.org/). More features will be added in the future.
