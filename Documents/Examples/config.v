`timescale 1ns / 1ps

//закомментировать для синхронного сброса
`define ASYNC_RESET	,posedge rst	// ассинхронный сброс
// `define ASYNC_RESET	// синхронный сброс

//Закоментировать, если используется 100Мбит
`define GBASE 

//Длинный пакет размером 8192Байта
//`define LONGPACKET