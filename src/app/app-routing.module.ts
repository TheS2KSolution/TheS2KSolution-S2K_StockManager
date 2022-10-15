import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './auth/login/login.component';
import { RegisterComponent } from './auth/register/register.component';
import { DashbordComponent } from './Components/dashbord/dashbord.component';

const routes: Routes = [
  {path: 'auth/login', component: LoginComponent},
  {path: '', redirectTo: 'auth/login', pathMatch: 'full'},
  {path: 'register', component: RegisterComponent},
  {path: 'dashbord', component: DashbordComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
