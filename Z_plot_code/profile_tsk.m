function []=profile_tsk(M)

% profile_tsk.m 8/25/2014 Parker MacCready
%
% plots the results of a mooring extraction, as profiles,
% just of T, s, and AKs

td = M.td;
ys = datestr(td(1),'yyyy');
yn = str2num(ys);
td0 = td - datenum(yn,1,1,0,0,0);

z = M.z_rho; eta = M.zeta; zb = M.z_w(1,:);
u = M.u; v = M.v;
t = M.temp; s = M.salt;
% extrapolate to top and bottom
zz = [zb; z; eta];
uu = [0*zb; u; u(end,:)];
vv = [0*zb; v; v(end,:)];
tt = [t(1,:); t; t(end,:)];
ss = [s(1,:); s; s(end,:)];
[NR,NC] = size(ss);

td00 = td0;
td0 = repmat(td0,NR,1);
td1 = repmat(td00,NR-1,1);

figure; set(gcf,'position',[20 20 2000 1500]); Z_fig(18);

subplot(311)
pcolor(td0,zz,tt)
shading interp
caxis([4 20]);
colorbar('eastoutside')
ylabel('Z (m)')
axis([td0(1) td0(end) zz(1,1) 5]);
set(gca,'xticklabel',[]);
[xt,yt] = Z_lab('ll');
text(xt,yt,'Temperature (\circC) ','color','w')

title([strrep(M.basename,'_',' '),' ',M.mloc],'fontweight','bold')


subplot(312)
pcolor(td0,zz,ss)
shading interp
caxis([28 33]);
colorbar('eastoutside')
hold on
%contour(td0,zz,ss,[0:.2:36],'-k');
ylabel('Z (m)')
axis([td0(1) td0(end) zz(1,1) 5]);
[xt,yt] = Z_lab('ll');
text(xt,yt,'Salinity ','color','w')
xlabel(['Yearday ',ys])

subplot(313)
size(td1)
pcolor(td1,M.z_w,log10(M.AKs))
shading interp
caxis([-5 -1]);
colorbar('eastoutside')
hold on
%contour(td0,zz,ss,[0:.2:36],'-k');
ylabel('Z (m)')
axis([td0(1) td0(end) zz(1,1) 5]);
[xt,yt] = Z_lab('ll');
text(xt,yt,'log_{10}[AKs (m^{2} s^{-1}] ','color','k')
xlabel(['Yearday ',ys])




