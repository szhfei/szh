function [ch1AllData_2, ch2AllData_2, ch3AllData_2, bn, sf, btime] = t3w(fileName)
%function t3w(fileName)
% read cv-374b record file(t3w) in WIN32 format,
% convert to ascii format.
%fid=fopen('20120926112000.200.t3w','r','ieee-be');
if nargin<1
  fileName='D:/szh/test/20121001180000.200.t3w';
end

% all binary byte order is Big Endian
fid=fopen(fileName, 'r', 'ieee-be');

% manual Page 11
fseek(fid, 24, 'bof');
instrument_id=fread(fid, 1, 'int16');
%sprintf('instrument_id = %u', instrument_id)
file_size_K=fread(fid, 1, 'int16');
header_size=fread(fid, 1, 'int16');
%sprintf('header_size = %u', header_size)
channel_numbers=fread(fid, 1, 'int16');
%sprintf('channel_number = %u', channel_numbers)
sampling_data=fread(fid, 1, 'uint32');
%sprintf('sampling_data = %u', sampling_data)
data_length=fread(fid, 1, 'int16');
AD_conversion_bit=fread(fid, 1, 'int16');
sampling_time_interval_ms=fread(fid, 1, 'int16');
delay_time=fread(fid, 1, 'int16');
fseek(fid, 52, 'bof');
year=fread(fid, 1, 'int16');
month=fread(fid, 1, 'int16');
day=fread(fid, 1, 'int16');
hour=fread(fid, 1, 'int16');
minute=fread(fid, 1, 'int16');
second=fread(fid, 1, 'int16');
millisecond=fread(fid, 1, 'int16');
%year2=fread(fid, 1, 'int16')
%month2=fread(fid, 1, 'int16')
%day2=fread(fid, 1, 'int16')
%hour2=fread(fid, 1, 'int16')
%minute2=fread(fid, 1, 'int16')
%second2=fread(fid, 1, 'int16')
%millisecond2=fread(fid, 1, 'int16')
%year3=fread(fid, 1, 'int16')
%month3=fread(fid, 1, 'int16')
%day3=fread(fid, 1, 'int16')
%hour3=fread(fid, 1, 'int16')
%minute3=fread(fid, 1, 'int16')
%second3=fread(fid, 1, 'int16')
%millisecond3=fread(fid, 1, 'int16')

% manual Page 12
fseek(fid, 128, 'bof');
channel_numbers2=fread(fid, 1, 'int16');
sampling_frequency=fread(fid, 1, 'int16');
%sprintf('sampling_frequency = %u', sampling_frequency)
%delay_time=fread(fid, 1, 'int16')
%first_channel=fread(fid, 1, 'int16')
%first_level=fread(fid, 1, 'int16')
%second_channel=fread(fid, 1, 'int16')
%second_level=fread(fid, 1, 'int16')
%third_channel=fread(fid, 1, 'int16')
%third_level=fread(fid, 1, 'int16')

%fseek(fid, 224, 'bof');  %
%first_offset=fread(fid, 1, 'uint32')
%second_offset=fread(fid, 1, 'uint32')
%third_offset=fread(fid, 1, 'uint32')

%fseek(fid, 768, 'bof');
%instrumental_seismic_intensity=fread(fid, 1, 'int16') * 10
%tri_axis_sysnthesis_peak_acc=fread(fid, 1, 'int16') * 10
%x_predominant_frequency=fread(fid, 1, 'int16') * 10
%y_predominant_frequency=fread(fid, 1, 'int16') * 10
%z_predominant_frequency=fread(fid, 1, 'int16') * 10


% waveform data   manual Page 14
% item 1-3 are ignored

% 1 block per second(3 channels)
% block content: item 4-6, channel 1-3 block
% channel X block: item 7-13 
% block_number=10 * 60;      % 10 minutes blocks are stored in a file
block_number = sampling_data / sampling_frequency;
%sprintf('block_number = %u', block_number)
%block_number=1;           % debug

% test 1/3 octave, 4 seconds
%block_number=4;
%sampling_data = block_number * sampling_frequency;

% header_size = 1024;
fseek(fid, header_size, 'bof');   % data block start

% allocate memory to store each channel data
ch1AllData=zeros(sampling_data, 1);
ch2AllData=zeros(sampling_data, 1);
ch3AllData=zeros(sampling_data, 1);
ch1_data=zeros(sampling_frequency, 1);
ch2_data=zeros(sampling_frequency, 1);
ch3_data=zeros(sampling_frequency, 1);

for j=1:block_number
  blockStart=ftell(fid);

  % item 1: Format ID, 1 byte, = 0x00
  % item 2: Format version, 1 byte, = 0x00
  % item 3: Backup, 2 bytes, = 0x00

  % item 4: record starting date and time, 8 bytes
  %         = YYYYMMDDhhmmssxx
  if j==1             % skip 4 bytes(item 1-3)
    fseek(fid, blockStart + 4, 'bof');
  end
  %year_1a=dec2hex(fread(fid, 1, 'schar'));
  %year_1b=dec2hex(fread(fid, 1, 'schar'));
  %year=[year_1a year_1b];
  %month_1=
  %date_1=
  %hour_1=
  %minute_1=
  %second_1=

  % item 5: flame time length, 4 bytes, = 0x000A
  % item 6: block length(three channels item 7-13), 4 bytes
  if j==1             % skip 4 bytes(item 1-3)
    fseek(fid, blockStart + 4 + 8, 'bof');
  else
    fseek(fid, blockStart + 8, 'bof');
  end
  flame_time_length=fread(fid, 1, 'uint32') * 10;
  block_length=fread(fid, 1, 'uint32');

  %==============================================================
  % channel 1
  % item 7-8: 1 + 1 bytes, all = 0x00
  % skip itme 7, 8
if 0
  % item 9: inner channel number, 2 bytes, = 0x0000
  if j==1              % skip 4 bytes(item 1-3)
    fseek(fid, blockStart + 4 + 16 + 2, 'bof');
  else
    fseek(fid, blockStart + 16 + 2, 'bof');
  end
  channel_id=fread(fid, 1, 'uint16');
end
  
  % item 10: sample size(bit width of the difference of a data and former data), 4 bits
  if j==1               % skip 4 bytes(item 1-3)
    fseek(fid, blockStart + 4 + 16 + 4, 'bof');
  else
    fseek(fid, blockStart + 16 + 4, 'bof');
  end
  sample_size_and_data=fread(fid, 1, 'uint16');
  sample_size=bitshift(bitand(sample_size_and_data, hex2dec('f000')), -12);
  % item 11: data number in this channel, 12 bits
  data_number=bitand(sample_size_and_data, hex2dec('0fff'));
  %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
  
  % item 12: first data in this channel
  head1_data= fread(fid, 1, 'uint32');

  % item 13: the differences of other data in this channel
  if sample_size == 1         % 8 bits
    ch1_data=fread(fid, data_number - 1, 'int8');
    %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
    %sprintf('%d ', ch1_data)
  elseif sample_size == 2     % 16 bits
    ch1_data=fread(fid, data_number - 1, 'int16');
  elseif sample_size == 4     % 32 bits 
    ch1_data=fread(fid, data_number - 1, 'int32');
  elseif sample_size == 0     % 4 bits
    % data_number=100   data_number2=50   last 4 low bits are zeros
    % data_number=200   data_number2=100   last 4 low bits are zeros
    data_number2=data_number / 2;
    ch1_data2=fread(fid, data_number2, 'uinit8');
    for k=1:data_number2
      % even data are stored in high 4 bits (2, 4, 6, 8, ......)
      ch1_data(2*k-1)=bitshift(bitand(ch1_data2(k), hex2dec('f0')), -4);
      % odd data are stored in low 4 bits (3, 5, 7, 9, ......)
      ch1_data(2*k)=bitand(ch1_data2(k), hex2dec('0f'));
      if (ch1_data(2*k-1) > 7)
        ch1_data(2*k-1) = ch1_data(2*k-1) - 16;  % negative
      end
      if (ch1_data(2*k) > 7)
        ch1_data(2*k) = ch1_data(2*k) - 16;  % negative
      end
    end
    % last data is stored in high 4 bits.
    %ch1_data(data_number-1)=bitshift(bitand(ch1_data2(data_number-1), hex2dec('f0')), -4);
    %if (ch1_data(data_number-1) > 7)
    %  ch1_data(data_number-1) = ch1_data(data_number-1) - 16;  % negative
    %end
    %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
    %sprintf('%d ', ch1_data)
  elseif sample_size == 3      % 24 bits
    data_number2=(data_number - 1) * 3;
    ch1_data2=fread(fid, data_number2, 'uint8');
    for k=1:data_number-1
      ch1_data(k)=bitshift(uint32(ch1_data2(3*k-2)), 16) + bitshift(uint32(ch1_data2(3*k-1)), 8) + uint32(ch1_data2(3*k));
      %if bitand(ch1_data(k), hex2dec('00800000')) == hex2dec('00800000')    % negative
      if ch1_data2(3*k-2) > 127
        ch1_data(k)=ch1_data(k) - 2^24;  % negative
      end 
    end
    %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
    %sprintf('%d ', ch1_data)
  end  % sample_size
  ch1_data(1)=head1_data + ch1_data(1);
  for i=2:data_number-1
    ch1_data(i)=ch1_data(i-1) + ch1_data(i);
  end
  %if sample_size == 3
  %  sprintf('%d ', ch1_data)
  %end
  ch1AllData((j-1)*sampling_frequency+1:j*sampling_frequency, :)=[head1_data; ch1_data(1:data_number-1)];

  %==============================================================
  % channel 2
  % skip itme 7, 8
  fseek(fid, 2, 'cof');
  % item 9
  channel_id=fread(fid, 1, 'uint16');
  % item 10
  sample_size_and_data=fread(fid, 1, 'uint16');
  sample_size=bitshift(bitand(sample_size_and_data, hex2dec('f000')), -12);
  % item 11
  data_number=bitand(sample_size_and_data, hex2dec('0fff'));
  %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
  % item 12
  head2_data=fread(fid, 1, 'uint32');
  % item 13
  if sample_size==1
    ch2_data=fread(fid, data_number-1, 'int8');
    %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
    %sprintf('%d ', ch2_data)
  elseif sample_size==2
    ch2_data=fread(fid, data_number-1, 'int16');
  elseif sample_size==4
    ch2_data=fread(fid, data_number-1, 'int32');
  elseif sample_size==0     % 4 bits
    data_number2=data_number / 2;
    ch2_data2=fread(fid, data_number2, 'uinit8');
    for k=1:data_number2-1
      % even data are stored in high 4 bits (2, 4, 6, 8, ......)
      ch2_data(2*k-1)=bitshift(bitand(ch2_data2(k), hex2dec('f0')), -4);
      % odd data are stored in low 4 bits (3, 5, 7, 9, ......)
      ch2_data(2*k)=bitand(ch2_data2(k), hex2dec('0f'));
      if (ch2_data(2*k-1) > 7)
        ch2_data(2*k-1) = ch2_data(2*k-1) - 16;  % negative
      end
      if (ch2_data(2*k) > 7)
        ch2_data(2*k) = ch2_data(2*k) - 16;  % negative
      end
    end
    %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
    %sprintf('%d ', ch2_data)
  elseif sample_size==3      % 24 bits
    data_number2=(data_number - 1) * 3;
    ch2_data2=fread(fid, data_number2, 'uint8');
    for k=1:data_number-1
      %ch2_data(k)=bitshift(ch2_data2(3*k-2), 16) + bitshift(ch2_data2(3*k-1), 8) + ch2_data2(3*k);
      ch2_data(k)=bitshift(uint32(ch2_data2(3*k-2)), 16) + bitshift(uint32(ch2_data2(3*k-1)), 8) + uint32(ch2_data2(3*k));
      if ch2_data2(3*k-2) > 127
        ch2_data(k)=ch2_data(k) - 2^24;  % negative
      end 
    end
    %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
    %sprintf('%d ', ch2_data)
  end  % sample_size
  ch2_data(1)=head2_data + ch2_data(1);
  for i=2:data_number-1
    ch2_data(i)=ch2_data(i-1) + ch2_data(i);
  end
  ch2AllData((j-1)*sampling_frequency+1:j*sampling_frequency, :)=[head2_data; ch2_data(1:data_number-1)];

  %==============================================================
  % channel 3
  % skip itme 7, 8
  fseek(fid, 2, 'cof');
  % item 9
  channel_id=fread(fid, 1, 'uint16');
  % item 10
  sample_size_and_data=fread(fid, 1, 'uint16');
  sample_size=bitshift(bitand(sample_size_and_data, hex2dec('f000')), -12);
  % item 11
  data_number=bitand(sample_size_and_data, hex2dec('0fff'));
  %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
  % item 12
  head3_data=fread(fid, 1, 'uint32');
  % item 13
  if sample_size==1
    ch3_data=fread(fid, data_number-1, 'int8');
    %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
    %sprintf('%d ', ch3_data)
  elseif sample_size==2
    ch3_data=fread(fid, data_number-1, 'int16');
  elseif sample_size==4
    ch3_data=fread(fid, data_number-1, 'int32');
  elseif sample_size == 0     % 4 bits
    data_number2=data_number / 2;
    ch3_data2=fread(fid, data_number2, 'uinit8');
    for k=1:data_number2-1
      ch3_data(2*k-1)=bitshift(bitand(ch3_data2(k), hex2dec('f0')), -4);
      ch3_data(2*k)=bitand(ch3_data2(k), hex2dec('0f'));
      if (ch1_data(2*k-1) > 7)
        ch1_data(2*k-1) = ch1_data(2*k-1) - 16;  % negative
      end
      if (ch1_data(2*k) > 7)
        ch1_data(2*k) = ch1_data(2*k) - 16;  % negative
      end
    end
    %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
    %sprintf('%d ', ch3_data)
  elseif sample_size == 3      % 24 bits
    data_number2=(data_number - 1) * 3;
    ch3_data2=fread(fid, data_number2, 'uint8');
    for k=1:data_number-1
      %ch3_data(k)=bitshift(ch3_data2(3*k-2), 16) + bitshift(ch3_data2(3*k-1), 8) + ch3_data2(3*k);
      ch3_data(k)=bitshift(uint32(ch3_data2(3*k-2)), 16) + bitshift(uint32(ch3_data2(3*k-1)), 8) + uint32(ch3_data2(3*k));
      if ch3_data2(3*k-2) > 127    % negative
        ch3_data(k)=ch3_data(k) - 2^24;
      end 
    end
    %sprintf('channel = %d, block_number = %d, sample_size = %d, data_number = %d', channel_id, j, sample_size, data_number)
    %sprintf('%d ', ch3_data)
  end  % sample_size
  ch3_data(1)=head3_data + ch3_data(1);
  for i=2:data_number-1
    ch3_data(i)=ch3_data(i-1) + ch3_data(i);
  end
  ch3AllData((j-1)*sampling_frequency+1:j*sampling_frequency, :)=[head3_data; ch3_data(1:data_number-1)];
end    % end for block_number
fclose(fid);

% 24bitA/D����̶��ǡ���?000Gal���?
% 0x7FFFFF�ǡ���2000Gal
% 0x000000�ǡ�0Gal
% 0x800000�ǡ���2048Gal
% ��Gal= 8388608 �� 2048 = 4096
%��8192000 = 2000 Gal
%��8388608 = 2048 Gal�� A/D ����ʱ�� Gal�����Q��Ⱥ�������ͬ��?
%gal_unit = 8388608 / 2048;
gal_unit = 8192000 / 2000;

ch1AllData=ch1AllData ./ gal_unit;
ch2AllData=ch2AllData ./ gal_unit;
ch3AllData=ch3AllData ./ gal_unit;

% if 0
% % pwave32: no zero shift
% figure;
% subplot(3, 1, 1);
% plot(ch1AllData);
% axis tight;
% %axis ([1 200 -0.12 0.12]);
% subplot(3, 1, 2);
% plot(ch2AllData);
% axis tight;
% %axis ([1 200 -0.12 0.12]);
% subplot(3, 1, 3);
% plot(ch3AllData);
% axis tight;
% %axis ([1 200 -0.12 0.12]);
% 
% fid1=fopen('ch1.asc', 'w');
% fprintf(fid1,'%.12f\n', ch1AllData);
% fclose(fid1);
% fid2=fopen('ch2.asc', 'w');
% fprintf(fid2,'%.12f\n', ch2AllData);
% fclose(fid2);
% fid3=fopen('ch3.asc', 'w');
% fprintf(fid3,'%.12f\n', ch3AllData);
% fclose(fid3);
% end % no zero shift

% pwave32: zero shift
% mean1=mean(ch1AllData);
% mean2=mean(ch2AllData);
% mean3=mean(ch3AllData);
ch1AllData_2=ch1AllData - median(ch1AllData);
ch2AllData_2=ch2AllData - median(ch2AllData);
ch3AllData_2=ch3AllData - median(ch3AllData);
% ch1AllData_2=ch1AllData - mean(ch1AllData);
% ch2AllData_2=ch2AllData - mean(ch2AllData);
% ch3AllData_2=ch3AllData - mean(ch3AllData);

% ch1AllData_2=ch1AllData - mean1;
% ch2AllData_2=ch2AllData - mean2;
% ch3AllData_2=ch3AllData - mean3;

%  close all output
if 0 
figure;
subplot(3, 1, 1);
plot(ch1AllData_2);
axis tight;
subplot(3, 1, 2);
plot(ch2AllData_2);
axis tight;
subplot(3, 1, 3);
plot(ch3AllData_2);
axis tight;
 
% fid1=fopen('ch1_zero.asc', 'w');
% fprintf(fid1,'%.12f\n', ch1AllData_2);
% fclose(fid1);
% fid2=fopen('ch2_zero.asc', 'w');
% fprintf(fid2,'%.12f\n', ch2AllData_2);
% fclose(fid2);
% fid3=fopen('ch3_zero.asc', 'w');
% fprintf(fid3,'%.12f\n', ch3AllData_2);
% fclose(fid3);
end

%SpectraFor24H(ch1AllData_2);
%SpectraFor24H(ch2AllData_2);
%SpectraFor24H(ch3AllData_2);

% compare with pwave
% if 0
% pwave32_ch1=load([fileName '.01.asc'], '-ascii');
% pwave32_ch2=load([fileName '.02.asc'], '-ascii');
% pwave32_ch3=load([fileName '.03.asc'], '-ascii');
% if size(pwave32_ch1, 1) ~= sampling_data || ...
%    size(pwave32_ch2, 1) ~= sampling_data || ...
%    size(pwave32_ch3, 1) ~= sampling_data 
%   exit;
% end
% figure;
% subplot(3, 1, 1);
% plot(ch1AllData - pwave32_ch1);
% axis tight;
% subplot(3, 1, 2);
% plot(ch2AllData - pwave32_ch2);
% axis tight;
% subplot(3, 1, 3);
% plot(ch3AllData - pwave32_ch3);
% axis tight;
% 
% pwave32_2_ch1=load([fileName '_zero.01.asc'], '-ascii');
% pwave32_2_ch2=load([fileName '_zero.02.asc'], '-ascii');
% pwave32_2_ch3=load([fileName '_zero.03.asc'], '-ascii');
% if size(pwave32_2_ch1, 1) ~= sampling_data || ...
%    size(pwave32_2_ch2, 1) ~= sampling_data || ...
%    size(pwave32_2_ch3, 1) ~= sampling_data 
%   exit;
% end
% figure;
% subplot(3, 1, 1);
% plot(ch1AllData_2 - pwave32_2_ch1);
% axis tight;
% subplot(3, 1, 2);
% plot(ch2AllData_2 - pwave32_2_ch2);
% axis tight;
% subplot(3, 1, 3);
% plot(ch3AllData_2 - pwave32_2_ch3);
% axis tight;
% end % compare with pwave

% p=2.441406250000000e-004;

bn=block_number;
sf=sampling_frequency;
btime=sprintf('%4d-%02d-%02d %02d:%02d', year, month, day, hour, minute);

% end of function
