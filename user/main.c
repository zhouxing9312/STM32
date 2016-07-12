#include <stdio.h>
#include "FreeRTOS.h"
#include "task.h"
#include "sys.h"
#include "usart.h" 

static void vTestTask( void *pvParameters )
{
	vTaskDelay(50);
	while(1) {
		vTaskDelay(1000/portTICK_RATE_MS);
		printf("LoveLive---1~\n");
	}
}

static void vTestTask2( void *pvParameters )
{
	while(1) {
		vTaskDelay(1000/portTICK_RATE_MS);
		printf("LoveLive---2~\n");
	}
}

int main(void)
{ 
	Stm32_Clock_Init(336,8,2,7);//…Ë÷√ ±÷”,168Mhz
	uart_init(84,115200);

	printf("---START---\n");
	xTaskCreate( vTestTask, "Test", 256, NULL, 1, NULL );
	xTaskCreate( vTestTask2, "Test2", 256, NULL, 1, NULL );

    vTaskStartScheduler();

	for(;;);
}
