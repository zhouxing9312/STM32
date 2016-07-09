#ifndef __USART_H
#define __USART_H 
//////////////////////////////////////////////////////////////////////////////////	   
//������ֻ��ѧϰʹ�ã�δ��������ɣ��������������κ���;
//ALIENTEK STM32F407������
//����1��ʼ�� 
//����ԭ��@ALIENTEK
//������̳:www.openedv.com
//�޸�����:2014/5/2
//�汾��V1.1
//��Ȩ���У�����ؾ���
//Copyright(C) ������������ӿƼ����޹�˾ 2014-2024
//All rights reserved
//********************************************************************************
//�޸�˵��
//V1.1 20150411
//�޸�OS_CRITICAL_METHOD���ж�Ϊ��SYSTEM_SUPPORT_OS
////////////////////////////////////////////////////////////////////////////////// 

#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h> /* for FILE */
#include <stdio.h>
#include <string.h>
#include "sys.h"

#define USART_REC_LEN  			200  	//�����������ֽ��� 200
#define EN_USART1_RX 			1		//ʹ�ܣ�1��/��ֹ��0������1����
	  	
extern u8  USART_RX_BUF[USART_REC_LEN]; //���ջ���,���USART_REC_LEN���ֽ�.ĩ�ֽ�Ϊ���з� 
extern u16 USART_RX_STA;         		//����״̬���	

#define PUTCHAR_PROTOTYPE int __io_putchar(int ch)
#define GETCHAR_PROTOTYPE int __io_getchar(void)
PUTCHAR_PROTOTYPE;
GETCHAR_PROTOTYPE;

void uart_init(u32 pclk2,u32 bound); 
void Uart_send(char *str);

#if defined (__CC_ARM)
int fputc(int ch, FILE *f);
#endif

#ifdef __cplusplus
}
#endif
#endif	   
















