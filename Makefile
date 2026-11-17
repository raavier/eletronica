# Uso:
#   make compile  [SKETCH=nome_da_pasta_em_sketches] [BOARD=uno|s3]
#   make upload   [SKETCH=...] [BOARD=...]
#   make monitor  [BOARD=...]
#
# BOARD escolhe placa, porta e velocidade da serial de uma vez:
#   uno (padrão)  Arduino Uno          /dev/ttyUSB0   9600
#   s3            ESP32-S3-DevKitC-1   /dev/ttyACM0   115200
# Qualquer um pode ser trocado na linha de comando: PORT=..., BAUD=..., FQBN=...
# Veja a porta real com "make boards".

CLI     ?= $(HOME)/.local/bin/arduino-cli
SKETCH  ?= sensor_estacionamento
BOARD   ?= uno

ifeq ($(BOARD),s3)
  FQBN  ?= esp32:esp32:esp32s3
  PORT  ?= /dev/ttyACM0
  BAUD  ?= 115200
else
  # Arduino Uno (clone). Se o upload falhar com "not in sync", teste:
  #   make upload FQBN=arduino:avr:nano:cpu=atmega328old
  FQBN  ?= arduino:avr:uno
  PORT  ?= /dev/ttyUSB0
  BAUD  ?= 9600
endif

ESP32_INDEX = https://espressif.github.io/arduino-esp32/package_esp32_index.json
SKETCH_DIR  = sketches/$(SKETCH)

.PHONY: setup setup-esp32 compile upload monitor boards details run

setup:
	$(CLI) core update-index
	$(CLI) core install arduino:avr

# Suporte ao ESP32 (download grande; rode uma vez).
setup-esp32:
	$(CLI) core update-index --additional-urls $(ESP32_INDEX)
	$(CLI) core install esp32:esp32 --additional-urls $(ESP32_INDEX)

compile:
	$(CLI) compile --fqbn $(FQBN) $(SKETCH_DIR)

# O FT232 clone às vezes perde sincronia no meio da gravação: tenta até 3x.
upload: compile
	@for i in 1 2 3; do \
	  echo ">> upload tentativa $$i"; \
	  $(CLI) upload -p $(PORT) --fqbn $(FQBN) $(SKETCH_DIR) && exit 0; \
	  sleep 1; \
	done; echo "!! upload falhou 3x"; exit 1

monitor:
	$(CLI) monitor -p $(PORT) -c baudrate=$(BAUD)

run: upload monitor

boards:
	$(CLI) board list

# Opções da placa (PSRAM, tamanho da flash, modo USB...).
details:
	$(CLI) board details -b $(FQBN)
