import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CardModule } from 'primeng/card';
import { ButtonModule } from 'primeng/button';
import { InputTextModule  } from 'primeng/inputtext'

@NgModule({
  declarations: [],
  exports: [
    CardModule,
    ButtonModule,
    InputTextModule
  ],
  imports: [
    CommonModule,
  ]
})
export class PrimematerialModule { }
