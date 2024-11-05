
out/kernel.elf:     file format elf64-x86-64


Disassembly of section .text:

ffffffff80100000 <begin>:
ffffffff80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%rax),%dh
ffffffff80100006:	01 00                	add    %eax,(%rax)
ffffffff80100008:	fe 4f 51             	decb   0x51(%rdi)
ffffffff8010000b:	e4 00                	in     $0x0,%al
ffffffff8010000d:	00 10                	add    %dl,(%rax)
ffffffff8010000f:	00 00                	add    %al,(%rax)
ffffffff80100011:	00 10                	add    %dl,(%rax)
ffffffff80100013:	00 00                	add    %al,(%rax)
ffffffff80100015:	c0 10 00             	rclb   $0x0,(%rax)
ffffffff80100018:	00 50 11             	add    %dl,0x11(%rax)
ffffffff8010001b:	00 20                	add    %ah,(%rax)
ffffffff8010001d:	00 10                	add    %dl,(%rax)
	...

ffffffff80100020 <mboot_entry>:
  .long mboot_entry_addr

mboot_entry:

# zero 4 pages for our bootstrap page tables
  xor %eax, %eax
ffffffff80100020:	31 c0                	xor    %eax,%eax
  mov $0x1000, %edi
ffffffff80100022:	bf 00 10 00 00       	mov    $0x1000,%edi
  mov $0x5000, %ecx
ffffffff80100027:	b9 00 50 00 00       	mov    $0x5000,%ecx
  rep stosb
ffffffff8010002c:	f3 aa                	rep stos %al,%es:(%rdi)

# P4ML[0] -> 0x2000 (PDPT-A)
  mov $(0x2000 | 3), %eax
ffffffff8010002e:	b8 03 20 00 00       	mov    $0x2003,%eax
  mov %eax, 0x1000
ffffffff80100033:	a3 00 10 00 00 b8 03 	movabs %eax,0x3003b800001000
ffffffff8010003a:	30 00 

# P4ML[511] -> 0x3000 (PDPT-B)
  mov $(0x3000 | 3), %eax
ffffffff8010003c:	00 a3 f8 1f 00 00    	add    %ah,0x1ff8(%rbx)
  mov %eax, 0x1FF8

# PDPT-A[0] -> 0x4000 (PD)
  mov $(0x4000 | 3), %eax
ffffffff80100042:	b8 03 40 00 00       	mov    $0x4003,%eax
  mov %eax, 0x2000
ffffffff80100047:	a3 00 20 00 00 b8 03 	movabs %eax,0x4003b800002000
ffffffff8010004e:	40 00 

# PDPT-B[510] -> 0x4000 (PD)
  mov $(0x4000 | 3), %eax
ffffffff80100050:	00 a3 f0 3f 00 00    	add    %ah,0x3ff0(%rbx)
  mov %eax, 0x3FF0

# PD[0..511] -> 0..1022MB
  mov $0x83, %eax
ffffffff80100056:	b8 83 00 00 00       	mov    $0x83,%eax
  mov $0x4000, %ebx
ffffffff8010005b:	bb 00 40 00 00       	mov    $0x4000,%ebx
  mov $512, %ecx
ffffffff80100060:	b9 00 02 00 00       	mov    $0x200,%ecx

ffffffff80100065 <ptbl_loop>:
ptbl_loop:
  mov %eax, (%ebx)
ffffffff80100065:	89 03                	mov    %eax,(%rbx)
  add $0x200000, %eax
ffffffff80100067:	05 00 00 20 00       	add    $0x200000,%eax
  add $0x8, %ebx
ffffffff8010006c:	83 c3 08             	add    $0x8,%ebx
  dec %ecx
ffffffff8010006f:	49 75 f3             	rex.WB jne ffffffff80100065 <ptbl_loop>

# Clear ebx for initial processor boot.
# When secondary processors boot, they'll call through
# entry32mp (from entryother), but with a nonzero ebx.
# We'll reuse these bootstrap pagetables and GDT.
  xor %ebx, %ebx
ffffffff80100072:	31 db                	xor    %ebx,%ebx

ffffffff80100074 <entry32mp>:

.global entry32mp
entry32mp:
# CR3 -> 0x1000 (P4ML)
  mov $0x1000, %eax
ffffffff80100074:	b8 00 10 00 00       	mov    $0x1000,%eax
  mov %eax, %cr3
ffffffff80100079:	0f 22 d8             	mov    %rax,%cr3

  lgdt (gdtr64 - mboot_header + mboot_load_addr)
ffffffff8010007c:	0f 01 15 b0 00 10 00 	lgdt   0x1000b0(%rip)        # ffffffff80200133 <end+0xeb133>

# Enable PAE - CR4.PAE=1
  mov %cr4, %eax
ffffffff80100083:	0f 20 e0             	mov    %cr4,%rax
  bts $5, %eax
ffffffff80100086:	0f ba e8 05          	bts    $0x5,%eax
  mov %eax, %cr4
ffffffff8010008a:	0f 22 e0             	mov    %rax,%cr4

# enable long mode - EFER.LME=1
  mov $0xc0000080, %ecx
ffffffff8010008d:	b9 80 00 00 c0       	mov    $0xc0000080,%ecx
  rdmsr
ffffffff80100092:	0f 32                	rdmsr
  bts $8, %eax
ffffffff80100094:	0f ba e8 08          	bts    $0x8,%eax
  wrmsr
ffffffff80100098:	0f 30                	wrmsr

# enable paging
  mov %cr0, %eax
ffffffff8010009a:	0f 20 c0             	mov    %cr0,%rax
  bts $31, %eax
ffffffff8010009d:	0f ba e8 1f          	bts    $0x1f,%eax
  mov %eax, %cr0
ffffffff801000a1:	0f 22 c0             	mov    %rax,%cr0

# shift to 64bit segment
  ljmp $8,$(entry64low - mboot_header + mboot_load_addr)
ffffffff801000a4:	ea                   	(bad)
ffffffff801000a5:	e0 00                	loopne ffffffff801000a7 <entry32mp+0x33>
ffffffff801000a7:	10 00                	adc    %al,(%rax)
ffffffff801000a9:	08 00                	or     %al,(%rax)
ffffffff801000ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

ffffffff801000b0 <gdtr64>:
ffffffff801000b0:	17                   	(bad)
ffffffff801000b1:	00 c0                	add    %al,%al
ffffffff801000b3:	00 10                	add    %dl,(%rax)
ffffffff801000b5:	00 00                	add    %al,(%rax)
ffffffff801000b7:	00 00                	add    %al,(%rax)
ffffffff801000b9:	00 66 0f             	add    %ah,0xf(%rsi)
ffffffff801000bc:	1f                   	(bad)
ffffffff801000bd:	44 00 00             	add    %r8b,(%rax)

ffffffff801000c0 <gdt64_begin>:
	...
ffffffff801000cc:	00 98 20 00 00 00    	add    %bl,0x20(%rax)
ffffffff801000d2:	00 00                	add    %al,(%rax)
ffffffff801000d4:	00                   	.byte 0x0
ffffffff801000d5:	90                   	nop
	...

ffffffff801000d8 <gdt64_end>:
ffffffff801000d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
ffffffff801000df:	00 

ffffffff801000e0 <entry64low>:
gdt64_end:

.align 16
.code64
entry64low:
  movq $entry64high, %rax
ffffffff801000e0:	48 c7 c0 e9 00 10 80 	mov    $0xffffffff801000e9,%rax
  jmp *%rax
ffffffff801000e7:	ff e0                	jmp    *%rax

ffffffff801000e9 <_start>:
.global _start
_start:
entry64high:

# ensure data segment registers are sane
  xor %rax, %rax
ffffffff801000e9:	48 31 c0             	xor    %rax,%rax
  mov %ax, %ss
ffffffff801000ec:	8e d0                	mov    %eax,%ss
  mov %ax, %ds
ffffffff801000ee:	8e d8                	mov    %eax,%ds
  mov %ax, %es
ffffffff801000f0:	8e c0                	mov    %eax,%es
  mov %ax, %fs
ffffffff801000f2:	8e e0                	mov    %eax,%fs
  mov %ax, %gs
ffffffff801000f4:	8e e8                	mov    %eax,%gs

# check to see if we're booting a secondary core
  test %ebx, %ebx
ffffffff801000f6:	85 db                	test   %ebx,%ebx
  jnz entry64mp
ffffffff801000f8:	75 11                	jne    ffffffff8010010b <entry64mp>

# setup initial stack
  mov $0xFFFFFFFF80010000, %rax
ffffffff801000fa:	48 c7 c0 00 00 01 80 	mov    $0xffffffff80010000,%rax
  mov %rax, %rsp
ffffffff80100101:	48 89 c4             	mov    %rax,%rsp

# enter main()
  jmp main
ffffffff80100104:	e9 5e 3b 00 00       	jmp    ffffffff80103c67 <main>

ffffffff80100109 <__deadloop>:

.global __deadloop
__deadloop:
# we should never return here...
  jmp .
ffffffff80100109:	eb fe                	jmp    ffffffff80100109 <__deadloop>

ffffffff8010010b <entry64mp>:

entry64mp:
# obtain kstack from data block before entryother
  mov $0x7000, %rax
ffffffff8010010b:	48 c7 c0 00 70 00 00 	mov    $0x7000,%rax
  mov -16(%rax), %rsp
ffffffff80100112:	48 8b 60 f0          	mov    -0x10(%rax),%rsp
  jmp mpenter
ffffffff80100116:	e9 0c 3c 00 00       	jmp    ffffffff80103d27 <mpenter>

ffffffff8010011b <wrmsr>:

.global wrmsr
wrmsr:
  mov %rdi, %rcx     # arg0 -> msrnum
ffffffff8010011b:	48 89 f9             	mov    %rdi,%rcx
  mov %rsi, %rax     # val.low -> eax
ffffffff8010011e:	48 89 f0             	mov    %rsi,%rax
  shr $32, %rsi
ffffffff80100121:	48 c1 ee 20          	shr    $0x20,%rsi
  mov %rsi, %rdx     # val.high -> edx
ffffffff80100125:	48 89 f2             	mov    %rsi,%rdx
  wrmsr
ffffffff80100128:	0f 30                	wrmsr
  retq
ffffffff8010012a:	c3                   	ret

ffffffff8010012b <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
ffffffff8010012b:	55                   	push   %rbp
ffffffff8010012c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010012f:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
ffffffff80100133:	48 c7 c6 d8 9b 10 80 	mov    $0xffffffff80109bd8,%rsi
ffffffff8010013a:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff80100141:	e8 68 5a 00 00       	call   ffffffff80105bae <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
ffffffff80100146:	48 c7 05 b7 d4 00 00 	movq   $0xffffffff8010d5f8,0xd4b7(%rip)        # ffffffff8010d608 <bcache+0x1608>
ffffffff8010014d:	f8 d5 10 80 
  bcache.head.next = &bcache.head;
ffffffff80100151:	48 c7 05 b4 d4 00 00 	movq   $0xffffffff8010d5f8,0xd4b4(%rip)        # ffffffff8010d610 <bcache+0x1610>
ffffffff80100158:	f8 d5 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffffffff8010015c:	48 c7 45 f8 68 c0 10 	movq   $0xffffffff8010c068,-0x8(%rbp)
ffffffff80100163:	80 
ffffffff80100164:	eb 48                	jmp    ffffffff801001ae <binit+0x83>
    b->next = bcache.head.next;
ffffffff80100166:	48 8b 15 a3 d4 00 00 	mov    0xd4a3(%rip),%rdx        # ffffffff8010d610 <bcache+0x1610>
ffffffff8010016d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100171:	48 89 50 18          	mov    %rdx,0x18(%rax)
    b->prev = &bcache.head;
ffffffff80100175:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100179:	48 c7 40 10 f8 d5 10 	movq   $0xffffffff8010d5f8,0x10(%rax)
ffffffff80100180:	80 
    b->dev = -1;
ffffffff80100181:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100185:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%rax)
    bcache.head.next->prev = b;
ffffffff8010018c:	48 8b 05 7d d4 00 00 	mov    0xd47d(%rip),%rax        # ffffffff8010d610 <bcache+0x1610>
ffffffff80100193:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80100197:	48 89 50 10          	mov    %rdx,0x10(%rax)
    bcache.head.next = b;
ffffffff8010019b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010019f:	48 89 05 6a d4 00 00 	mov    %rax,0xd46a(%rip)        # ffffffff8010d610 <bcache+0x1610>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffffffff801001a6:	48 81 45 f8 28 02 00 	addq   $0x228,-0x8(%rbp)
ffffffff801001ad:	00 
ffffffff801001ae:	48 c7 c0 f8 d5 10 80 	mov    $0xffffffff8010d5f8,%rax
ffffffff801001b5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff801001b9:	72 ab                	jb     ffffffff80100166 <binit+0x3b>
  }
}
ffffffff801001bb:	90                   	nop
ffffffff801001bc:	90                   	nop
ffffffff801001bd:	c9                   	leave
ffffffff801001be:	c3                   	ret

ffffffff801001bf <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
ffffffff801001bf:	55                   	push   %rbp
ffffffff801001c0:	48 89 e5             	mov    %rsp,%rbp
ffffffff801001c3:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801001c7:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff801001ca:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *b;

  acquire(&bcache.lock);
ffffffff801001cd:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff801001d4:	e8 0a 5a 00 00       	call   ffffffff80105be3 <acquire>

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffffffff801001d9:	48 8b 05 30 d4 00 00 	mov    0xd430(%rip),%rax        # ffffffff8010d610 <bcache+0x1610>
ffffffff801001e0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801001e4:	eb 6c                	jmp    ffffffff80100252 <bget+0x93>
    if(b->dev == dev && b->sector == sector){
ffffffff801001e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801001ea:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801001ed:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffffffff801001f0:	75 54                	jne    ffffffff80100246 <bget+0x87>
ffffffff801001f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801001f6:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff801001f9:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffffffff801001fc:	75 48                	jne    ffffffff80100246 <bget+0x87>
      if(!(b->flags & B_BUSY)){
ffffffff801001fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100202:	8b 00                	mov    (%rax),%eax
ffffffff80100204:	83 e0 01             	and    $0x1,%eax
ffffffff80100207:	85 c0                	test   %eax,%eax
ffffffff80100209:	75 26                	jne    ffffffff80100231 <bget+0x72>
        b->flags |= B_BUSY;
ffffffff8010020b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010020f:	8b 00                	mov    (%rax),%eax
ffffffff80100211:	83 c8 01             	or     $0x1,%eax
ffffffff80100214:	89 c2                	mov    %eax,%edx
ffffffff80100216:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010021a:	89 10                	mov    %edx,(%rax)
        release(&bcache.lock);
ffffffff8010021c:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff80100223:	e8 92 5a 00 00       	call   ffffffff80105cba <release>
        return b;
ffffffff80100228:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010022c:	e9 a4 00 00 00       	jmp    ffffffff801002d5 <bget+0x116>
      }
      sleep(b, &bcache.lock);
ffffffff80100231:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100235:	48 c7 c6 00 c0 10 80 	mov    $0xffffffff8010c000,%rsi
ffffffff8010023c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010023f:	e8 1b 56 00 00       	call   ffffffff8010585f <sleep>
      goto loop;
ffffffff80100244:	eb 93                	jmp    ffffffff801001d9 <bget+0x1a>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffffffff80100246:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010024a:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff8010024e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80100252:	48 81 7d f8 f8 d5 10 	cmpq   $0xffffffff8010d5f8,-0x8(%rbp)
ffffffff80100259:	80 
ffffffff8010025a:	75 8a                	jne    ffffffff801001e6 <bget+0x27>
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffffffff8010025c:	48 8b 05 a5 d3 00 00 	mov    0xd3a5(%rip),%rax        # ffffffff8010d608 <bcache+0x1608>
ffffffff80100263:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80100267:	eb 56                	jmp    ffffffff801002bf <bget+0x100>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
ffffffff80100269:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010026d:	8b 00                	mov    (%rax),%eax
ffffffff8010026f:	83 e0 01             	and    $0x1,%eax
ffffffff80100272:	85 c0                	test   %eax,%eax
ffffffff80100274:	75 3d                	jne    ffffffff801002b3 <bget+0xf4>
ffffffff80100276:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010027a:	8b 00                	mov    (%rax),%eax
ffffffff8010027c:	83 e0 04             	and    $0x4,%eax
ffffffff8010027f:	85 c0                	test   %eax,%eax
ffffffff80100281:	75 30                	jne    ffffffff801002b3 <bget+0xf4>
      b->dev = dev;
ffffffff80100283:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100287:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff8010028a:	89 50 04             	mov    %edx,0x4(%rax)
      b->sector = sector;
ffffffff8010028d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100291:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff80100294:	89 50 08             	mov    %edx,0x8(%rax)
      b->flags = B_BUSY;
ffffffff80100297:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010029b:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
      release(&bcache.lock);
ffffffff801002a1:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff801002a8:	e8 0d 5a 00 00       	call   ffffffff80105cba <release>
      return b;
ffffffff801002ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801002b1:	eb 22                	jmp    ffffffff801002d5 <bget+0x116>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffffffff801002b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801002b7:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff801002bb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801002bf:	48 81 7d f8 f8 d5 10 	cmpq   $0xffffffff8010d5f8,-0x8(%rbp)
ffffffff801002c6:	80 
ffffffff801002c7:	75 a0                	jne    ffffffff80100269 <bget+0xaa>
    }
  }
  panic("bget: no buffers");
ffffffff801002c9:	48 c7 c7 df 9b 10 80 	mov    $0xffffffff80109bdf,%rdi
ffffffff801002d0:	e8 5a 06 00 00       	call   ffffffff8010092f <panic>
}
ffffffff801002d5:	c9                   	leave
ffffffff801002d6:	c3                   	ret

ffffffff801002d7 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
ffffffff801002d7:	55                   	push   %rbp
ffffffff801002d8:	48 89 e5             	mov    %rsp,%rbp
ffffffff801002db:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801002df:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff801002e2:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *b;

  b = bget(dev, sector);
ffffffff801002e5:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff801002e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801002eb:	89 d6                	mov    %edx,%esi
ffffffff801002ed:	89 c7                	mov    %eax,%edi
ffffffff801002ef:	e8 cb fe ff ff       	call   ffffffff801001bf <bget>
ffffffff801002f4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(!(b->flags & B_VALID))
ffffffff801002f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801002fc:	8b 00                	mov    (%rax),%eax
ffffffff801002fe:	83 e0 02             	and    $0x2,%eax
ffffffff80100301:	85 c0                	test   %eax,%eax
ffffffff80100303:	75 0c                	jne    ffffffff80100311 <bread+0x3a>
    iderw(b);
ffffffff80100305:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100309:	48 89 c7             	mov    %rax,%rdi
ffffffff8010030c:	e8 f6 2b 00 00       	call   ffffffff80102f07 <iderw>
  return b;
ffffffff80100311:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80100315:	c9                   	leave
ffffffff80100316:	c3                   	ret

ffffffff80100317 <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
ffffffff80100317:	55                   	push   %rbp
ffffffff80100318:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010031b:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010031f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if((b->flags & B_BUSY) == 0)
ffffffff80100323:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100327:	8b 00                	mov    (%rax),%eax
ffffffff80100329:	83 e0 01             	and    $0x1,%eax
ffffffff8010032c:	85 c0                	test   %eax,%eax
ffffffff8010032e:	75 0c                	jne    ffffffff8010033c <bwrite+0x25>
    panic("bwrite");
ffffffff80100330:	48 c7 c7 f0 9b 10 80 	mov    $0xffffffff80109bf0,%rdi
ffffffff80100337:	e8 f3 05 00 00       	call   ffffffff8010092f <panic>
  b->flags |= B_DIRTY;
ffffffff8010033c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100340:	8b 00                	mov    (%rax),%eax
ffffffff80100342:	83 c8 04             	or     $0x4,%eax
ffffffff80100345:	89 c2                	mov    %eax,%edx
ffffffff80100347:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010034b:	89 10                	mov    %edx,(%rax)
  iderw(b);
ffffffff8010034d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100351:	48 89 c7             	mov    %rax,%rdi
ffffffff80100354:	e8 ae 2b 00 00       	call   ffffffff80102f07 <iderw>
}
ffffffff80100359:	90                   	nop
ffffffff8010035a:	c9                   	leave
ffffffff8010035b:	c3                   	ret

ffffffff8010035c <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
ffffffff8010035c:	55                   	push   %rbp
ffffffff8010035d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100360:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80100364:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if((b->flags & B_BUSY) == 0)
ffffffff80100368:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010036c:	8b 00                	mov    (%rax),%eax
ffffffff8010036e:	83 e0 01             	and    $0x1,%eax
ffffffff80100371:	85 c0                	test   %eax,%eax
ffffffff80100373:	75 0c                	jne    ffffffff80100381 <brelse+0x25>
    panic("brelse");
ffffffff80100375:	48 c7 c7 f7 9b 10 80 	mov    $0xffffffff80109bf7,%rdi
ffffffff8010037c:	e8 ae 05 00 00       	call   ffffffff8010092f <panic>

  acquire(&bcache.lock);
ffffffff80100381:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff80100388:	e8 56 58 00 00       	call   ffffffff80105be3 <acquire>

  b->next->prev = b->prev;
ffffffff8010038d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80100391:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80100395:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80100399:	48 8b 52 10          	mov    0x10(%rdx),%rdx
ffffffff8010039d:	48 89 50 10          	mov    %rdx,0x10(%rax)
  b->prev->next = b->next;
ffffffff801003a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003a5:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff801003a9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801003ad:	48 8b 52 18          	mov    0x18(%rdx),%rdx
ffffffff801003b1:	48 89 50 18          	mov    %rdx,0x18(%rax)
  b->next = bcache.head.next;
ffffffff801003b5:	48 8b 15 54 d2 00 00 	mov    0xd254(%rip),%rdx        # ffffffff8010d610 <bcache+0x1610>
ffffffff801003bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003c0:	48 89 50 18          	mov    %rdx,0x18(%rax)
  b->prev = &bcache.head;
ffffffff801003c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003c8:	48 c7 40 10 f8 d5 10 	movq   $0xffffffff8010d5f8,0x10(%rax)
ffffffff801003cf:	80 
  bcache.head.next->prev = b;
ffffffff801003d0:	48 8b 05 39 d2 00 00 	mov    0xd239(%rip),%rax        # ffffffff8010d610 <bcache+0x1610>
ffffffff801003d7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801003db:	48 89 50 10          	mov    %rdx,0x10(%rax)
  bcache.head.next = b;
ffffffff801003df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003e3:	48 89 05 26 d2 00 00 	mov    %rax,0xd226(%rip)        # ffffffff8010d610 <bcache+0x1610>

  b->flags &= ~B_BUSY;
ffffffff801003ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003ee:	8b 00                	mov    (%rax),%eax
ffffffff801003f0:	83 e0 fe             	and    $0xfffffffe,%eax
ffffffff801003f3:	89 c2                	mov    %eax,%edx
ffffffff801003f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003f9:	89 10                	mov    %edx,(%rax)
  wakeup(b);
ffffffff801003fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801003ff:	48 89 c7             	mov    %rax,%rdi
ffffffff80100402:	e8 6c 55 00 00       	call   ffffffff80105973 <wakeup>

  release(&bcache.lock);
ffffffff80100407:	48 c7 c7 00 c0 10 80 	mov    $0xffffffff8010c000,%rdi
ffffffff8010040e:	e8 a7 58 00 00       	call   ffffffff80105cba <release>
}
ffffffff80100413:	90                   	nop
ffffffff80100414:	c9                   	leave
ffffffff80100415:	c3                   	ret

ffffffff80100416 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
ffffffff80100416:	55                   	push   %rbp
ffffffff80100417:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010041a:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff8010041e:	89 f8                	mov    %edi,%eax
ffffffff80100420:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffffffff80100424:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffffffff80100428:	89 c2                	mov    %eax,%edx
ffffffff8010042a:	ec                   	in     (%dx),%al
ffffffff8010042b:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffffffff8010042e:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffffffff80100432:	c9                   	leave
ffffffff80100433:	c3                   	ret

ffffffff80100434 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
ffffffff80100434:	55                   	push   %rbp
ffffffff80100435:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100438:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff8010043c:	89 fa                	mov    %edi,%edx
ffffffff8010043e:	89 f0                	mov    %esi,%eax
ffffffff80100440:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff80100444:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff80100447:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff8010044b:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff8010044f:	ee                   	out    %al,(%dx)
}
ffffffff80100450:	90                   	nop
ffffffff80100451:	c9                   	leave
ffffffff80100452:	c3                   	ret

ffffffff80100453 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
ffffffff80100453:	55                   	push   %rbp
ffffffff80100454:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100457:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff8010045b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff8010045f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  volatile ushort pd[5];

  pd[0] = size-1;
ffffffff80100462:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80100465:	83 e8 01             	sub    $0x1,%eax
ffffffff80100468:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  pd[1] = (uintp)p;
ffffffff8010046c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100470:	66 89 45 f8          	mov    %ax,-0x8(%rbp)
  pd[2] = (uintp)p >> 16;
ffffffff80100474:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100478:	48 c1 e8 10          	shr    $0x10,%rax
ffffffff8010047c:	66 89 45 fa          	mov    %ax,-0x6(%rbp)
#if X64
  pd[3] = (uintp)p >> 32;
ffffffff80100480:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100484:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff80100488:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  pd[4] = (uintp)p >> 48;
ffffffff8010048c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100490:	48 c1 e8 30          	shr    $0x30,%rax
ffffffff80100494:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
#endif
  asm volatile("lidt (%0)" : : "r" (pd));
ffffffff80100498:	48 8d 45 f6          	lea    -0xa(%rbp),%rax
ffffffff8010049c:	0f 01 18             	lidt   (%rax)
}
ffffffff8010049f:	90                   	nop
ffffffff801004a0:	c9                   	leave
ffffffff801004a1:	c3                   	ret

ffffffff801004a2 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
ffffffff801004a2:	55                   	push   %rbp
ffffffff801004a3:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("cli");
ffffffff801004a6:	fa                   	cli
}
ffffffff801004a7:	90                   	nop
ffffffff801004a8:	5d                   	pop    %rbp
ffffffff801004a9:	c3                   	ret

ffffffff801004aa <printptr>:
} cons;

static char digits[] = "0123456789abcdef";

static void
printptr(uintp x) {
ffffffff801004aa:	55                   	push   %rbp
ffffffff801004ab:	48 89 e5             	mov    %rsp,%rbp
ffffffff801004ae:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801004b2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uintp) * 2); i++, x <<= 4)
ffffffff801004b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801004bd:	eb 22                	jmp    ffffffff801004e1 <printptr+0x37>
    consputc(digits[x >> (sizeof(uintp) * 8 - 4)]);
ffffffff801004bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801004c3:	48 c1 e8 3c          	shr    $0x3c,%rax
ffffffff801004c7:	0f b6 80 00 b0 10 80 	movzbl -0x7fef5000(%rax),%eax
ffffffff801004ce:	0f be c0             	movsbl %al,%eax
ffffffff801004d1:	89 c7                	mov    %eax,%edi
ffffffff801004d3:	e8 8e 06 00 00       	call   ffffffff80100b66 <consputc>
  for (i = 0; i < (sizeof(uintp) * 2); i++, x <<= 4)
ffffffff801004d8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801004dc:	48 c1 65 e8 04       	shlq   $0x4,-0x18(%rbp)
ffffffff801004e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801004e4:	83 f8 0f             	cmp    $0xf,%eax
ffffffff801004e7:	76 d6                	jbe    ffffffff801004bf <printptr+0x15>
}
ffffffff801004e9:	90                   	nop
ffffffff801004ea:	90                   	nop
ffffffff801004eb:	c9                   	leave
ffffffff801004ec:	c3                   	ret

ffffffff801004ed <printint>:

static void
printint(int xx, int base, int sign)
{
ffffffff801004ed:	55                   	push   %rbp
ffffffff801004ee:	48 89 e5             	mov    %rsp,%rbp
ffffffff801004f1:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff801004f5:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffffffff801004f8:	89 75 d8             	mov    %esi,-0x28(%rbp)
ffffffff801004fb:	89 55 d4             	mov    %edx,-0x2c(%rbp)
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
ffffffff801004fe:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
ffffffff80100502:	74 1c                	je     ffffffff80100520 <printint+0x33>
ffffffff80100504:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100507:	c1 e8 1f             	shr    $0x1f,%eax
ffffffff8010050a:	0f b6 c0             	movzbl %al,%eax
ffffffff8010050d:	89 45 d4             	mov    %eax,-0x2c(%rbp)
ffffffff80100510:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
ffffffff80100514:	74 0a                	je     ffffffff80100520 <printint+0x33>
    x = -xx;
ffffffff80100516:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100519:	f7 d8                	neg    %eax
ffffffff8010051b:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffffffff8010051e:	eb 06                	jmp    ffffffff80100526 <printint+0x39>
  else
    x = xx;
ffffffff80100520:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100523:	89 45 f8             	mov    %eax,-0x8(%rbp)

  i = 0;
ffffffff80100526:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
ffffffff8010052d:	8b 4d d8             	mov    -0x28(%rbp),%ecx
ffffffff80100530:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80100533:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80100538:	f7 f1                	div    %ecx
ffffffff8010053a:	89 d1                	mov    %edx,%ecx
ffffffff8010053c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010053f:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80100542:	89 55 fc             	mov    %edx,-0x4(%rbp)
ffffffff80100545:	89 ca                	mov    %ecx,%edx
ffffffff80100547:	0f b6 92 00 b0 10 80 	movzbl -0x7fef5000(%rdx),%edx
ffffffff8010054e:	48 98                	cltq
ffffffff80100550:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
ffffffff80100554:	8b 75 d8             	mov    -0x28(%rbp),%esi
ffffffff80100557:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff8010055a:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff8010055f:	f7 f6                	div    %esi
ffffffff80100561:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffffffff80100564:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffffffff80100568:	75 c3                	jne    ffffffff8010052d <printint+0x40>

  if(sign)
ffffffff8010056a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
ffffffff8010056e:	74 26                	je     ffffffff80100596 <printint+0xa9>
    buf[i++] = '-';
ffffffff80100570:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100573:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80100576:	89 55 fc             	mov    %edx,-0x4(%rbp)
ffffffff80100579:	48 98                	cltq
ffffffff8010057b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
ffffffff80100580:	eb 14                	jmp    ffffffff80100596 <printint+0xa9>
    consputc(buf[i]);
ffffffff80100582:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100585:	48 98                	cltq
ffffffff80100587:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
ffffffff8010058c:	0f be c0             	movsbl %al,%eax
ffffffff8010058f:	89 c7                	mov    %eax,%edi
ffffffff80100591:	e8 d0 05 00 00       	call   ffffffff80100b66 <consputc>
  while(--i >= 0)
ffffffff80100596:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
ffffffff8010059a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff8010059e:	79 e2                	jns    ffffffff80100582 <printint+0x95>
}
ffffffff801005a0:	90                   	nop
ffffffff801005a1:	90                   	nop
ffffffff801005a2:	c9                   	leave
ffffffff801005a3:	c3                   	ret

ffffffff801005a4 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
ffffffff801005a4:	55                   	push   %rbp
ffffffff801005a5:	48 89 e5             	mov    %rsp,%rbp
ffffffff801005a8:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
ffffffff801005af:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
ffffffff801005b6:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
ffffffff801005bd:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
ffffffff801005c4:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
ffffffff801005cb:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
ffffffff801005d2:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
ffffffff801005d9:	84 c0                	test   %al,%al
ffffffff801005db:	74 20                	je     ffffffff801005fd <cprintf+0x59>
ffffffff801005dd:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
ffffffff801005e1:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
ffffffff801005e5:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
ffffffff801005e9:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
ffffffff801005ed:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
ffffffff801005f1:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
ffffffff801005f5:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
ffffffff801005f9:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c, locking;
  char *s;

  va_start(ap, fmt);
ffffffff801005fd:	c7 85 20 ff ff ff 08 	movl   $0x8,-0xe0(%rbp)
ffffffff80100604:	00 00 00 
ffffffff80100607:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
ffffffff8010060e:	00 00 00 
ffffffff80100611:	48 8d 45 10          	lea    0x10(%rbp),%rax
ffffffff80100615:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
ffffffff8010061c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
ffffffff80100623:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  locking = cons.locking;
ffffffff8010062a:	8b 05 58 d3 00 00    	mov    0xd358(%rip),%eax        # ffffffff8010d988 <cons+0x68>
ffffffff80100630:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
  if(locking)
ffffffff80100636:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffffffff8010063d:	74 0c                	je     ffffffff8010064b <cprintf+0xa7>
    acquire(&cons.lock);
ffffffff8010063f:	48 c7 c7 20 d9 10 80 	mov    $0xffffffff8010d920,%rdi
ffffffff80100646:	e8 98 55 00 00       	call   ffffffff80105be3 <acquire>

  if (fmt == 0)
ffffffff8010064b:	48 83 bd 18 ff ff ff 	cmpq   $0x0,-0xe8(%rbp)
ffffffff80100652:	00 
ffffffff80100653:	75 0c                	jne    ffffffff80100661 <cprintf+0xbd>
    panic("null fmt");
ffffffff80100655:	48 c7 c7 fe 9b 10 80 	mov    $0xffffffff80109bfe,%rdi
ffffffff8010065c:	e8 ce 02 00 00       	call   ffffffff8010092f <panic>

  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
ffffffff80100661:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
ffffffff80100668:	00 00 00 
ffffffff8010066b:	e9 73 02 00 00       	jmp    ffffffff801008e3 <cprintf+0x33f>
    if(c != '%'){
ffffffff80100670:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffffffff80100677:	74 12                	je     ffffffff8010068b <cprintf+0xe7>
      consputc(c);
ffffffff80100679:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffffffff8010067f:	89 c7                	mov    %eax,%edi
ffffffff80100681:	e8 e0 04 00 00       	call   ffffffff80100b66 <consputc>
      continue;
ffffffff80100686:	e9 51 02 00 00       	jmp    ffffffff801008dc <cprintf+0x338>
    }
    c = fmt[++i] & 0xff;
ffffffff8010068b:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffffffff80100692:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffffffff80100698:	48 63 d0             	movslq %eax,%rdx
ffffffff8010069b:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffffffff801006a2:	48 01 d0             	add    %rdx,%rax
ffffffff801006a5:	0f b6 00             	movzbl (%rax),%eax
ffffffff801006a8:	0f be c0             	movsbl %al,%eax
ffffffff801006ab:	25 ff 00 00 00       	and    $0xff,%eax
ffffffff801006b0:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
    if(c == 0)
ffffffff801006b6:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffffffff801006bd:	0f 84 53 02 00 00    	je     ffffffff80100916 <cprintf+0x372>
      break;
    switch(c){
ffffffff801006c3:	83 bd 38 ff ff ff 78 	cmpl   $0x78,-0xc8(%rbp)
ffffffff801006ca:	0f 84 b3 00 00 00    	je     ffffffff80100783 <cprintf+0x1df>
ffffffff801006d0:	83 bd 38 ff ff ff 78 	cmpl   $0x78,-0xc8(%rbp)
ffffffff801006d7:	0f 8f e7 01 00 00    	jg     ffffffff801008c4 <cprintf+0x320>
ffffffff801006dd:	83 bd 38 ff ff ff 73 	cmpl   $0x73,-0xc8(%rbp)
ffffffff801006e4:	0f 84 41 01 00 00    	je     ffffffff8010082b <cprintf+0x287>
ffffffff801006ea:	83 bd 38 ff ff ff 73 	cmpl   $0x73,-0xc8(%rbp)
ffffffff801006f1:	0f 8f cd 01 00 00    	jg     ffffffff801008c4 <cprintf+0x320>
ffffffff801006f7:	83 bd 38 ff ff ff 70 	cmpl   $0x70,-0xc8(%rbp)
ffffffff801006fe:	0f 84 d7 00 00 00    	je     ffffffff801007db <cprintf+0x237>
ffffffff80100704:	83 bd 38 ff ff ff 70 	cmpl   $0x70,-0xc8(%rbp)
ffffffff8010070b:	0f 8f b3 01 00 00    	jg     ffffffff801008c4 <cprintf+0x320>
ffffffff80100711:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffffffff80100718:	0f 84 9a 01 00 00    	je     ffffffff801008b8 <cprintf+0x314>
ffffffff8010071e:	83 bd 38 ff ff ff 64 	cmpl   $0x64,-0xc8(%rbp)
ffffffff80100725:	0f 85 99 01 00 00    	jne    ffffffff801008c4 <cprintf+0x320>
    case 'd':
      printint(va_arg(ap, int), 10, 1);
ffffffff8010072b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffffffff80100731:	83 f8 2f             	cmp    $0x2f,%eax
ffffffff80100734:	77 23                	ja     ffffffff80100759 <cprintf+0x1b5>
ffffffff80100736:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffffffff8010073d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff80100743:	89 d2                	mov    %edx,%edx
ffffffff80100745:	48 01 d0             	add    %rdx,%rax
ffffffff80100748:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff8010074e:	83 c2 08             	add    $0x8,%edx
ffffffff80100751:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffffffff80100757:	eb 12                	jmp    ffffffff8010076b <cprintf+0x1c7>
ffffffff80100759:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffffffff80100760:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffffffff80100764:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffffffff8010076b:	8b 00                	mov    (%rax),%eax
ffffffff8010076d:	ba 01 00 00 00       	mov    $0x1,%edx
ffffffff80100772:	be 0a 00 00 00       	mov    $0xa,%esi
ffffffff80100777:	89 c7                	mov    %eax,%edi
ffffffff80100779:	e8 6f fd ff ff       	call   ffffffff801004ed <printint>
      break;
ffffffff8010077e:	e9 59 01 00 00       	jmp    ffffffff801008dc <cprintf+0x338>
    case 'x':
      printint(va_arg(ap, int), 16, 0);
ffffffff80100783:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffffffff80100789:	83 f8 2f             	cmp    $0x2f,%eax
ffffffff8010078c:	77 23                	ja     ffffffff801007b1 <cprintf+0x20d>
ffffffff8010078e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffffffff80100795:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff8010079b:	89 d2                	mov    %edx,%edx
ffffffff8010079d:	48 01 d0             	add    %rdx,%rax
ffffffff801007a0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff801007a6:	83 c2 08             	add    $0x8,%edx
ffffffff801007a9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffffffff801007af:	eb 12                	jmp    ffffffff801007c3 <cprintf+0x21f>
ffffffff801007b1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffffffff801007b8:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffffffff801007bc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffffffff801007c3:	8b 00                	mov    (%rax),%eax
ffffffff801007c5:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff801007ca:	be 10 00 00 00       	mov    $0x10,%esi
ffffffff801007cf:	89 c7                	mov    %eax,%edi
ffffffff801007d1:	e8 17 fd ff ff       	call   ffffffff801004ed <printint>
      break;
ffffffff801007d6:	e9 01 01 00 00       	jmp    ffffffff801008dc <cprintf+0x338>
    case 'p':
      printptr(va_arg(ap, uintp));
ffffffff801007db:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffffffff801007e1:	83 f8 2f             	cmp    $0x2f,%eax
ffffffff801007e4:	77 23                	ja     ffffffff80100809 <cprintf+0x265>
ffffffff801007e6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffffffff801007ed:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff801007f3:	89 d2                	mov    %edx,%edx
ffffffff801007f5:	48 01 d0             	add    %rdx,%rax
ffffffff801007f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff801007fe:	83 c2 08             	add    $0x8,%edx
ffffffff80100801:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffffffff80100807:	eb 12                	jmp    ffffffff8010081b <cprintf+0x277>
ffffffff80100809:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffffffff80100810:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffffffff80100814:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffffffff8010081b:	48 8b 00             	mov    (%rax),%rax
ffffffff8010081e:	48 89 c7             	mov    %rax,%rdi
ffffffff80100821:	e8 84 fc ff ff       	call   ffffffff801004aa <printptr>
      break;
ffffffff80100826:	e9 b1 00 00 00       	jmp    ffffffff801008dc <cprintf+0x338>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
ffffffff8010082b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffffffff80100831:	83 f8 2f             	cmp    $0x2f,%eax
ffffffff80100834:	77 23                	ja     ffffffff80100859 <cprintf+0x2b5>
ffffffff80100836:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffffffff8010083d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff80100843:	89 d2                	mov    %edx,%edx
ffffffff80100845:	48 01 d0             	add    %rdx,%rax
ffffffff80100848:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffffffff8010084e:	83 c2 08             	add    $0x8,%edx
ffffffff80100851:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffffffff80100857:	eb 12                	jmp    ffffffff8010086b <cprintf+0x2c7>
ffffffff80100859:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffffffff80100860:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffffffff80100864:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffffffff8010086b:	48 8b 00             	mov    (%rax),%rax
ffffffff8010086e:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
ffffffff80100875:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
ffffffff8010087c:	00 
ffffffff8010087d:	75 29                	jne    ffffffff801008a8 <cprintf+0x304>
        s = "(null)";
ffffffff8010087f:	48 c7 85 40 ff ff ff 	movq   $0xffffffff80109c07,-0xc0(%rbp)
ffffffff80100886:	07 9c 10 80 
      for(; *s; s++)
ffffffff8010088a:	eb 1c                	jmp    ffffffff801008a8 <cprintf+0x304>
        consputc(*s);
ffffffff8010088c:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffffffff80100893:	0f b6 00             	movzbl (%rax),%eax
ffffffff80100896:	0f be c0             	movsbl %al,%eax
ffffffff80100899:	89 c7                	mov    %eax,%edi
ffffffff8010089b:	e8 c6 02 00 00       	call   ffffffff80100b66 <consputc>
      for(; *s; s++)
ffffffff801008a0:	48 83 85 40 ff ff ff 	addq   $0x1,-0xc0(%rbp)
ffffffff801008a7:	01 
ffffffff801008a8:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffffffff801008af:	0f b6 00             	movzbl (%rax),%eax
ffffffff801008b2:	84 c0                	test   %al,%al
ffffffff801008b4:	75 d6                	jne    ffffffff8010088c <cprintf+0x2e8>
      break;
ffffffff801008b6:	eb 24                	jmp    ffffffff801008dc <cprintf+0x338>
    case '%':
      consputc('%');
ffffffff801008b8:	bf 25 00 00 00       	mov    $0x25,%edi
ffffffff801008bd:	e8 a4 02 00 00       	call   ffffffff80100b66 <consputc>
      break;
ffffffff801008c2:	eb 18                	jmp    ffffffff801008dc <cprintf+0x338>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
ffffffff801008c4:	bf 25 00 00 00       	mov    $0x25,%edi
ffffffff801008c9:	e8 98 02 00 00       	call   ffffffff80100b66 <consputc>
      consputc(c);
ffffffff801008ce:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffffffff801008d4:	89 c7                	mov    %eax,%edi
ffffffff801008d6:	e8 8b 02 00 00       	call   ffffffff80100b66 <consputc>
      break;
ffffffff801008db:	90                   	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
ffffffff801008dc:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffffffff801008e3:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffffffff801008e9:	48 63 d0             	movslq %eax,%rdx
ffffffff801008ec:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffffffff801008f3:	48 01 d0             	add    %rdx,%rax
ffffffff801008f6:	0f b6 00             	movzbl (%rax),%eax
ffffffff801008f9:	0f be c0             	movsbl %al,%eax
ffffffff801008fc:	25 ff 00 00 00       	and    $0xff,%eax
ffffffff80100901:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
ffffffff80100907:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffffffff8010090e:	0f 85 5c fd ff ff    	jne    ffffffff80100670 <cprintf+0xcc>
ffffffff80100914:	eb 01                	jmp    ffffffff80100917 <cprintf+0x373>
      break;
ffffffff80100916:	90                   	nop
    }
  }

  if(locking)
ffffffff80100917:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffffffff8010091e:	74 0c                	je     ffffffff8010092c <cprintf+0x388>
    release(&cons.lock);
ffffffff80100920:	48 c7 c7 20 d9 10 80 	mov    $0xffffffff8010d920,%rdi
ffffffff80100927:	e8 8e 53 00 00       	call   ffffffff80105cba <release>
}
ffffffff8010092c:	90                   	nop
ffffffff8010092d:	c9                   	leave
ffffffff8010092e:	c3                   	ret

ffffffff8010092f <panic>:

void
panic(char *s)
{
ffffffff8010092f:	55                   	push   %rbp
ffffffff80100930:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100933:	48 83 ec 70          	sub    $0x70,%rsp
ffffffff80100937:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
  int i;
  uintp pcs[10];
  
  cli();
ffffffff8010093b:	e8 62 fb ff ff       	call   ffffffff801004a2 <cli>
  cons.locking = 0;
ffffffff80100940:	c7 05 3e d0 00 00 00 	movl   $0x0,0xd03e(%rip)        # ffffffff8010d988 <cons+0x68>
ffffffff80100947:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
ffffffff8010094a:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80100951:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80100955:	0f b6 00             	movzbl (%rax),%eax
ffffffff80100958:	0f b6 c0             	movzbl %al,%eax
ffffffff8010095b:	89 c6                	mov    %eax,%esi
ffffffff8010095d:	48 c7 c7 0e 9c 10 80 	mov    $0xffffffff80109c0e,%rdi
ffffffff80100964:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80100969:	e8 36 fc ff ff       	call   ffffffff801005a4 <cprintf>
  cprintf(s);
ffffffff8010096e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffffffff80100972:	48 89 c7             	mov    %rax,%rdi
ffffffff80100975:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010097a:	e8 25 fc ff ff       	call   ffffffff801005a4 <cprintf>
  cprintf("\n");
ffffffff8010097f:	48 c7 c7 1d 9c 10 80 	mov    $0xffffffff80109c1d,%rdi
ffffffff80100986:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010098b:	e8 14 fc ff ff       	call   ffffffff801005a4 <cprintf>
  getcallerpcs(&s, pcs);
ffffffff80100990:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
ffffffff80100994:	48 8d 45 98          	lea    -0x68(%rbp),%rax
ffffffff80100998:	48 89 d6             	mov    %rdx,%rsi
ffffffff8010099b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010099e:	e8 70 53 00 00       	call   ffffffff80105d13 <getcallerpcs>
  for(i=0; i<10; i++)
ffffffff801009a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801009aa:	eb 22                	jmp    ffffffff801009ce <panic+0x9f>
    cprintf(" %p", pcs[i]);
ffffffff801009ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801009af:	48 98                	cltq
ffffffff801009b1:	48 8b 44 c5 a0       	mov    -0x60(%rbp,%rax,8),%rax
ffffffff801009b6:	48 89 c6             	mov    %rax,%rsi
ffffffff801009b9:	48 c7 c7 1f 9c 10 80 	mov    $0xffffffff80109c1f,%rdi
ffffffff801009c0:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801009c5:	e8 da fb ff ff       	call   ffffffff801005a4 <cprintf>
  for(i=0; i<10; i++)
ffffffff801009ca:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801009ce:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffffffff801009d2:	7e d8                	jle    ffffffff801009ac <panic+0x7d>
  panicked = 1; // freeze other CPU
ffffffff801009d4:	c7 05 3a cf 00 00 01 	movl   $0x1,0xcf3a(%rip)        # ffffffff8010d918 <panicked>
ffffffff801009db:	00 00 00 
  for(;;)
ffffffff801009de:	90                   	nop
ffffffff801009df:	eb fd                	jmp    ffffffff801009de <panic+0xaf>

ffffffff801009e1 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
ffffffff801009e1:	55                   	push   %rbp
ffffffff801009e2:	48 89 e5             	mov    %rsp,%rbp
ffffffff801009e5:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801009e9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
ffffffff801009ec:	be 0e 00 00 00       	mov    $0xe,%esi
ffffffff801009f1:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffffffff801009f6:	e8 39 fa ff ff       	call   ffffffff80100434 <outb>
  pos = inb(CRTPORT+1) << 8;
ffffffff801009fb:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffffffff80100a00:	e8 11 fa ff ff       	call   ffffffff80100416 <inb>
ffffffff80100a05:	0f b6 c0             	movzbl %al,%eax
ffffffff80100a08:	c1 e0 08             	shl    $0x8,%eax
ffffffff80100a0b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  outb(CRTPORT, 15);
ffffffff80100a0e:	be 0f 00 00 00       	mov    $0xf,%esi
ffffffff80100a13:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffffffff80100a18:	e8 17 fa ff ff       	call   ffffffff80100434 <outb>
  pos |= inb(CRTPORT+1);
ffffffff80100a1d:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffffffff80100a22:	e8 ef f9 ff ff       	call   ffffffff80100416 <inb>
ffffffff80100a27:	0f b6 c0             	movzbl %al,%eax
ffffffff80100a2a:	09 45 fc             	or     %eax,-0x4(%rbp)

  if(c == '\n')
ffffffff80100a2d:	83 7d ec 0a          	cmpl   $0xa,-0x14(%rbp)
ffffffff80100a31:	75 37                	jne    ffffffff80100a6a <cgaputc+0x89>
    pos += 80 - pos%80;
ffffffff80100a33:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffffffff80100a36:	48 63 c1             	movslq %ecx,%rax
ffffffff80100a39:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
ffffffff80100a40:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff80100a44:	89 c2                	mov    %eax,%edx
ffffffff80100a46:	c1 fa 05             	sar    $0x5,%edx
ffffffff80100a49:	89 c8                	mov    %ecx,%eax
ffffffff80100a4b:	c1 f8 1f             	sar    $0x1f,%eax
ffffffff80100a4e:	29 c2                	sub    %eax,%edx
ffffffff80100a50:	89 d0                	mov    %edx,%eax
ffffffff80100a52:	c1 e0 02             	shl    $0x2,%eax
ffffffff80100a55:	01 d0                	add    %edx,%eax
ffffffff80100a57:	c1 e0 04             	shl    $0x4,%eax
ffffffff80100a5a:	29 c1                	sub    %eax,%ecx
ffffffff80100a5c:	89 ca                	mov    %ecx,%edx
ffffffff80100a5e:	b8 50 00 00 00       	mov    $0x50,%eax
ffffffff80100a63:	29 d0                	sub    %edx,%eax
ffffffff80100a65:	01 45 fc             	add    %eax,-0x4(%rbp)
ffffffff80100a68:	eb 3d                	jmp    ffffffff80100aa7 <cgaputc+0xc6>
  else if(c == BACKSPACE){
ffffffff80100a6a:	81 7d ec 00 01 00 00 	cmpl   $0x100,-0x14(%rbp)
ffffffff80100a71:	75 0c                	jne    ffffffff80100a7f <cgaputc+0x9e>
    if(pos > 0) --pos;
ffffffff80100a73:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80100a77:	7e 2e                	jle    ffffffff80100aa7 <cgaputc+0xc6>
ffffffff80100a79:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
ffffffff80100a7d:	eb 28                	jmp    ffffffff80100aa7 <cgaputc+0xc6>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
ffffffff80100a7f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80100a82:	0f b6 c0             	movzbl %al,%eax
ffffffff80100a85:	80 cc 07             	or     $0x7,%ah
ffffffff80100a88:	89 c6                	mov    %eax,%esi
ffffffff80100a8a:	48 8b 0d 87 a5 00 00 	mov    0xa587(%rip),%rcx        # ffffffff8010b018 <crt>
ffffffff80100a91:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100a94:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80100a97:	89 55 fc             	mov    %edx,-0x4(%rbp)
ffffffff80100a9a:	48 98                	cltq
ffffffff80100a9c:	48 01 c0             	add    %rax,%rax
ffffffff80100a9f:	48 01 c8             	add    %rcx,%rax
ffffffff80100aa2:	89 f2                	mov    %esi,%edx
ffffffff80100aa4:	66 89 10             	mov    %dx,(%rax)
  
  if((pos/80) >= 24){  // Scroll up.
ffffffff80100aa7:	81 7d fc 7f 07 00 00 	cmpl   $0x77f,-0x4(%rbp)
ffffffff80100aae:	7e 56                	jle    ffffffff80100b06 <cgaputc+0x125>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
ffffffff80100ab0:	48 8b 05 61 a5 00 00 	mov    0xa561(%rip),%rax        # ffffffff8010b018 <crt>
ffffffff80100ab7:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffffffff80100abe:	48 8b 05 53 a5 00 00 	mov    0xa553(%rip),%rax        # ffffffff8010b018 <crt>
ffffffff80100ac5:	ba 60 0e 00 00       	mov    $0xe60,%edx
ffffffff80100aca:	48 89 ce             	mov    %rcx,%rsi
ffffffff80100acd:	48 89 c7             	mov    %rax,%rdi
ffffffff80100ad0:	e8 6d 55 00 00       	call   ffffffff80106042 <memmove>
    pos -= 80;
ffffffff80100ad5:	83 6d fc 50          	subl   $0x50,-0x4(%rbp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
ffffffff80100ad9:	b8 80 07 00 00       	mov    $0x780,%eax
ffffffff80100ade:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffffffff80100ae1:	48 98                	cltq
ffffffff80100ae3:	8d 14 00             	lea    (%rax,%rax,1),%edx
ffffffff80100ae6:	48 8b 05 2b a5 00 00 	mov    0xa52b(%rip),%rax        # ffffffff8010b018 <crt>
ffffffff80100aed:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffffffff80100af0:	48 63 c9             	movslq %ecx,%rcx
ffffffff80100af3:	48 01 c9             	add    %rcx,%rcx
ffffffff80100af6:	48 01 c8             	add    %rcx,%rax
ffffffff80100af9:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80100afe:	48 89 c7             	mov    %rax,%rdi
ffffffff80100b01:	e8 4d 54 00 00       	call   ffffffff80105f53 <memset>
  }
  
  outb(CRTPORT, 14);
ffffffff80100b06:	be 0e 00 00 00       	mov    $0xe,%esi
ffffffff80100b0b:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffffffff80100b10:	e8 1f f9 ff ff       	call   ffffffff80100434 <outb>
  outb(CRTPORT+1, pos>>8);
ffffffff80100b15:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100b18:	c1 f8 08             	sar    $0x8,%eax
ffffffff80100b1b:	0f b6 c0             	movzbl %al,%eax
ffffffff80100b1e:	89 c6                	mov    %eax,%esi
ffffffff80100b20:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffffffff80100b25:	e8 0a f9 ff ff       	call   ffffffff80100434 <outb>
  outb(CRTPORT, 15);
ffffffff80100b2a:	be 0f 00 00 00       	mov    $0xf,%esi
ffffffff80100b2f:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffffffff80100b34:	e8 fb f8 ff ff       	call   ffffffff80100434 <outb>
  outb(CRTPORT+1, pos);
ffffffff80100b39:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100b3c:	0f b6 c0             	movzbl %al,%eax
ffffffff80100b3f:	89 c6                	mov    %eax,%esi
ffffffff80100b41:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffffffff80100b46:	e8 e9 f8 ff ff       	call   ffffffff80100434 <outb>
  crt[pos] = ' ' | 0x0700;
ffffffff80100b4b:	48 8b 05 c6 a4 00 00 	mov    0xa4c6(%rip),%rax        # ffffffff8010b018 <crt>
ffffffff80100b52:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80100b55:	48 63 d2             	movslq %edx,%rdx
ffffffff80100b58:	48 01 d2             	add    %rdx,%rdx
ffffffff80100b5b:	48 01 d0             	add    %rdx,%rax
ffffffff80100b5e:	66 c7 00 20 07       	movw   $0x720,(%rax)
}
ffffffff80100b63:	90                   	nop
ffffffff80100b64:	c9                   	leave
ffffffff80100b65:	c3                   	ret

ffffffff80100b66 <consputc>:

void
consputc(int c)
{
ffffffff80100b66:	55                   	push   %rbp
ffffffff80100b67:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100b6a:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80100b6e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  if(panicked){
ffffffff80100b71:	8b 05 a1 cd 00 00    	mov    0xcda1(%rip),%eax        # ffffffff8010d918 <panicked>
ffffffff80100b77:	85 c0                	test   %eax,%eax
ffffffff80100b79:	74 08                	je     ffffffff80100b83 <consputc+0x1d>
    cli();
ffffffff80100b7b:	e8 22 f9 ff ff       	call   ffffffff801004a2 <cli>
    for(;;)
ffffffff80100b80:	90                   	nop
ffffffff80100b81:	eb fd                	jmp    ffffffff80100b80 <consputc+0x1a>
      ;
  }

  if(c == BACKSPACE){
ffffffff80100b83:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
ffffffff80100b8a:	75 20                	jne    ffffffff80100bac <consputc+0x46>
    uartputc('\b'); uartputc(' '); uartputc('\b');
ffffffff80100b8c:	bf 08 00 00 00       	mov    $0x8,%edi
ffffffff80100b91:	e8 4c 72 00 00       	call   ffffffff80107de2 <uartputc>
ffffffff80100b96:	bf 20 00 00 00       	mov    $0x20,%edi
ffffffff80100b9b:	e8 42 72 00 00       	call   ffffffff80107de2 <uartputc>
ffffffff80100ba0:	bf 08 00 00 00       	mov    $0x8,%edi
ffffffff80100ba5:	e8 38 72 00 00       	call   ffffffff80107de2 <uartputc>
ffffffff80100baa:	eb 0a                	jmp    ffffffff80100bb6 <consputc+0x50>
  } else
    uartputc(c);
ffffffff80100bac:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100baf:	89 c7                	mov    %eax,%edi
ffffffff80100bb1:	e8 2c 72 00 00       	call   ffffffff80107de2 <uartputc>
  cgaputc(c);
ffffffff80100bb6:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100bb9:	89 c7                	mov    %eax,%edi
ffffffff80100bbb:	e8 21 fe ff ff       	call   ffffffff801009e1 <cgaputc>
}
ffffffff80100bc0:	90                   	nop
ffffffff80100bc1:	c9                   	leave
ffffffff80100bc2:	c3                   	ret

ffffffff80100bc3 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
ffffffff80100bc3:	55                   	push   %rbp
ffffffff80100bc4:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100bc7:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80100bcb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int c;

  acquire(&input.lock);
ffffffff80100bcf:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100bd6:	e8 08 50 00 00       	call   ffffffff80105be3 <acquire>
  while((c = getc()) >= 0){
ffffffff80100bdb:	e9 7b 01 00 00       	jmp    ffffffff80100d5b <consoleintr+0x198>
    switch(c){
ffffffff80100be0:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffffffff80100be4:	0f 84 a4 00 00 00    	je     ffffffff80100c8e <consoleintr+0xcb>
ffffffff80100bea:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffffffff80100bee:	0f 8f cc 00 00 00    	jg     ffffffff80100cc0 <consoleintr+0xfd>
ffffffff80100bf4:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffffffff80100bf8:	74 2b                	je     ffffffff80100c25 <consoleintr+0x62>
ffffffff80100bfa:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffffffff80100bfe:	0f 8f bc 00 00 00    	jg     ffffffff80100cc0 <consoleintr+0xfd>
ffffffff80100c04:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffffffff80100c08:	74 52                	je     ffffffff80100c5c <consoleintr+0x99>
ffffffff80100c0a:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffffffff80100c0e:	0f 8f ac 00 00 00    	jg     ffffffff80100cc0 <consoleintr+0xfd>
ffffffff80100c14:	83 7d fc 08          	cmpl   $0x8,-0x4(%rbp)
ffffffff80100c18:	74 74                	je     ffffffff80100c8e <consoleintr+0xcb>
ffffffff80100c1a:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
ffffffff80100c1e:	74 19                	je     ffffffff80100c39 <consoleintr+0x76>
ffffffff80100c20:	e9 9b 00 00 00       	jmp    ffffffff80100cc0 <consoleintr+0xfd>
    case C('Z'): // reboot
      lidt(0,0);
ffffffff80100c25:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80100c2a:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80100c2f:	e8 1f f8 ff ff       	call   ffffffff80100453 <lidt>
      break;
ffffffff80100c34:	e9 22 01 00 00       	jmp    ffffffff80100d5b <consoleintr+0x198>
    case C('P'):  // Process listing.
      procdump();
ffffffff80100c39:	e8 ef 4d 00 00       	call   ffffffff80105a2d <procdump>
      break;
ffffffff80100c3e:	e9 18 01 00 00       	jmp    ffffffff80100d5b <consoleintr+0x198>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
ffffffff80100c43:	8b 05 c7 cc 00 00    	mov    0xccc7(%rip),%eax        # ffffffff8010d910 <input+0xf0>
ffffffff80100c49:	83 e8 01             	sub    $0x1,%eax
ffffffff80100c4c:	89 05 be cc 00 00    	mov    %eax,0xccbe(%rip)        # ffffffff8010d910 <input+0xf0>
        consputc(BACKSPACE);
ffffffff80100c52:	bf 00 01 00 00       	mov    $0x100,%edi
ffffffff80100c57:	e8 0a ff ff ff       	call   ffffffff80100b66 <consputc>
      while(input.e != input.w &&
ffffffff80100c5c:	8b 15 ae cc 00 00    	mov    0xccae(%rip),%edx        # ffffffff8010d910 <input+0xf0>
ffffffff80100c62:	8b 05 a4 cc 00 00    	mov    0xcca4(%rip),%eax        # ffffffff8010d90c <input+0xec>
ffffffff80100c68:	39 c2                	cmp    %eax,%edx
ffffffff80100c6a:	0f 84 e4 00 00 00    	je     ffffffff80100d54 <consoleintr+0x191>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
ffffffff80100c70:	8b 05 9a cc 00 00    	mov    0xcc9a(%rip),%eax        # ffffffff8010d910 <input+0xf0>
ffffffff80100c76:	83 e8 01             	sub    $0x1,%eax
ffffffff80100c79:	83 e0 7f             	and    $0x7f,%eax
ffffffff80100c7c:	89 c0                	mov    %eax,%eax
ffffffff80100c7e:	0f b6 80 88 d8 10 80 	movzbl -0x7fef2778(%rax),%eax
      while(input.e != input.w &&
ffffffff80100c85:	3c 0a                	cmp    $0xa,%al
ffffffff80100c87:	75 ba                	jne    ffffffff80100c43 <consoleintr+0x80>
      }
      break;
ffffffff80100c89:	e9 c6 00 00 00       	jmp    ffffffff80100d54 <consoleintr+0x191>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
ffffffff80100c8e:	8b 15 7c cc 00 00    	mov    0xcc7c(%rip),%edx        # ffffffff8010d910 <input+0xf0>
ffffffff80100c94:	8b 05 72 cc 00 00    	mov    0xcc72(%rip),%eax        # ffffffff8010d90c <input+0xec>
ffffffff80100c9a:	39 c2                	cmp    %eax,%edx
ffffffff80100c9c:	0f 84 b5 00 00 00    	je     ffffffff80100d57 <consoleintr+0x194>
        input.e--;
ffffffff80100ca2:	8b 05 68 cc 00 00    	mov    0xcc68(%rip),%eax        # ffffffff8010d910 <input+0xf0>
ffffffff80100ca8:	83 e8 01             	sub    $0x1,%eax
ffffffff80100cab:	89 05 5f cc 00 00    	mov    %eax,0xcc5f(%rip)        # ffffffff8010d910 <input+0xf0>
        consputc(BACKSPACE);
ffffffff80100cb1:	bf 00 01 00 00       	mov    $0x100,%edi
ffffffff80100cb6:	e8 ab fe ff ff       	call   ffffffff80100b66 <consputc>
      }
      break;
ffffffff80100cbb:	e9 97 00 00 00       	jmp    ffffffff80100d57 <consoleintr+0x194>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
ffffffff80100cc0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80100cc4:	0f 84 90 00 00 00    	je     ffffffff80100d5a <consoleintr+0x197>
ffffffff80100cca:	8b 15 40 cc 00 00    	mov    0xcc40(%rip),%edx        # ffffffff8010d910 <input+0xf0>
ffffffff80100cd0:	8b 05 32 cc 00 00    	mov    0xcc32(%rip),%eax        # ffffffff8010d908 <input+0xe8>
ffffffff80100cd6:	29 c2                	sub    %eax,%edx
ffffffff80100cd8:	83 fa 7f             	cmp    $0x7f,%edx
ffffffff80100cdb:	77 7d                	ja     ffffffff80100d5a <consoleintr+0x197>
        c = (c == '\r') ? '\n' : c;
ffffffff80100cdd:	83 7d fc 0d          	cmpl   $0xd,-0x4(%rbp)
ffffffff80100ce1:	74 05                	je     ffffffff80100ce8 <consoleintr+0x125>
ffffffff80100ce3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100ce6:	eb 05                	jmp    ffffffff80100ced <consoleintr+0x12a>
ffffffff80100ce8:	b8 0a 00 00 00       	mov    $0xa,%eax
ffffffff80100ced:	89 45 fc             	mov    %eax,-0x4(%rbp)
        input.buf[input.e++ % INPUT_BUF] = c;
ffffffff80100cf0:	8b 05 1a cc 00 00    	mov    0xcc1a(%rip),%eax        # ffffffff8010d910 <input+0xf0>
ffffffff80100cf6:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80100cf9:	89 15 11 cc 00 00    	mov    %edx,0xcc11(%rip)        # ffffffff8010d910 <input+0xf0>
ffffffff80100cff:	83 e0 7f             	and    $0x7f,%eax
ffffffff80100d02:	89 c1                	mov    %eax,%ecx
ffffffff80100d04:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100d07:	89 c2                	mov    %eax,%edx
ffffffff80100d09:	89 c8                	mov    %ecx,%eax
ffffffff80100d0b:	88 90 88 d8 10 80    	mov    %dl,-0x7fef2778(%rax)
        consputc(c);
ffffffff80100d11:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100d14:	89 c7                	mov    %eax,%edi
ffffffff80100d16:	e8 4b fe ff ff       	call   ffffffff80100b66 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
ffffffff80100d1b:	83 7d fc 0a          	cmpl   $0xa,-0x4(%rbp)
ffffffff80100d1f:	74 19                	je     ffffffff80100d3a <consoleintr+0x177>
ffffffff80100d21:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffffffff80100d25:	74 13                	je     ffffffff80100d3a <consoleintr+0x177>
ffffffff80100d27:	8b 15 e3 cb 00 00    	mov    0xcbe3(%rip),%edx        # ffffffff8010d910 <input+0xf0>
ffffffff80100d2d:	8b 05 d5 cb 00 00    	mov    0xcbd5(%rip),%eax        # ffffffff8010d908 <input+0xe8>
ffffffff80100d33:	83 e8 80             	sub    $0xffffff80,%eax
ffffffff80100d36:	39 c2                	cmp    %eax,%edx
ffffffff80100d38:	75 20                	jne    ffffffff80100d5a <consoleintr+0x197>
          input.w = input.e;
ffffffff80100d3a:	8b 05 d0 cb 00 00    	mov    0xcbd0(%rip),%eax        # ffffffff8010d910 <input+0xf0>
ffffffff80100d40:	89 05 c6 cb 00 00    	mov    %eax,0xcbc6(%rip)        # ffffffff8010d90c <input+0xec>
          wakeup(&input.r);
ffffffff80100d46:	48 c7 c7 08 d9 10 80 	mov    $0xffffffff8010d908,%rdi
ffffffff80100d4d:	e8 21 4c 00 00       	call   ffffffff80105973 <wakeup>
        }
      }
      break;
ffffffff80100d52:	eb 06                	jmp    ffffffff80100d5a <consoleintr+0x197>
      break;
ffffffff80100d54:	90                   	nop
ffffffff80100d55:	eb 04                	jmp    ffffffff80100d5b <consoleintr+0x198>
      break;
ffffffff80100d57:	90                   	nop
ffffffff80100d58:	eb 01                	jmp    ffffffff80100d5b <consoleintr+0x198>
      break;
ffffffff80100d5a:	90                   	nop
  while((c = getc()) >= 0){
ffffffff80100d5b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100d5f:	ff d0                	call   *%rax
ffffffff80100d61:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80100d64:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80100d68:	0f 89 72 fe ff ff    	jns    ffffffff80100be0 <consoleintr+0x1d>
    }
  }
  release(&input.lock);
ffffffff80100d6e:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100d75:	e8 40 4f 00 00       	call   ffffffff80105cba <release>
}
ffffffff80100d7a:	90                   	nop
ffffffff80100d7b:	c9                   	leave
ffffffff80100d7c:	c3                   	ret

ffffffff80100d7d <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
ffffffff80100d7d:	55                   	push   %rbp
ffffffff80100d7e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100d81:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80100d85:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80100d89:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80100d8d:	89 55 dc             	mov    %edx,-0x24(%rbp)
  uint target;
  int c;

  iunlock(ip);
ffffffff80100d90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100d94:	48 89 c7             	mov    %rax,%rdi
ffffffff80100d97:	e8 6d 12 00 00       	call   ffffffff80102009 <iunlock>
  target = n;
ffffffff80100d9c:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100d9f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  acquire(&input.lock);
ffffffff80100da2:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100da9:	e8 35 4e 00 00       	call   ffffffff80105be3 <acquire>
  while(n > 0){
ffffffff80100dae:	e9 b2 00 00 00       	jmp    ffffffff80100e65 <consoleread+0xe8>
    while(input.r == input.w){
      if(proc->killed){
ffffffff80100db3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80100dba:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80100dbe:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80100dc1:	85 c0                	test   %eax,%eax
ffffffff80100dc3:	74 22                	je     ffffffff80100de7 <consoleread+0x6a>
        release(&input.lock);
ffffffff80100dc5:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100dcc:	e8 e9 4e 00 00       	call   ffffffff80105cba <release>
        ilock(ip);
ffffffff80100dd1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100dd5:	48 89 c7             	mov    %rax,%rdi
ffffffff80100dd8:	e8 bb 10 00 00       	call   ffffffff80101e98 <ilock>
        return -1;
ffffffff80100ddd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80100de2:	e9 ac 00 00 00       	jmp    ffffffff80100e93 <consoleread+0x116>
      }
      sleep(&input.r, &input.lock);
ffffffff80100de7:	48 c7 c6 20 d8 10 80 	mov    $0xffffffff8010d820,%rsi
ffffffff80100dee:	48 c7 c7 08 d9 10 80 	mov    $0xffffffff8010d908,%rdi
ffffffff80100df5:	e8 65 4a 00 00       	call   ffffffff8010585f <sleep>
    while(input.r == input.w){
ffffffff80100dfa:	8b 15 08 cb 00 00    	mov    0xcb08(%rip),%edx        # ffffffff8010d908 <input+0xe8>
ffffffff80100e00:	8b 05 06 cb 00 00    	mov    0xcb06(%rip),%eax        # ffffffff8010d90c <input+0xec>
ffffffff80100e06:	39 c2                	cmp    %eax,%edx
ffffffff80100e08:	74 a9                	je     ffffffff80100db3 <consoleread+0x36>
    }
    c = input.buf[input.r++ % INPUT_BUF];
ffffffff80100e0a:	8b 05 f8 ca 00 00    	mov    0xcaf8(%rip),%eax        # ffffffff8010d908 <input+0xe8>
ffffffff80100e10:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80100e13:	89 15 ef ca 00 00    	mov    %edx,0xcaef(%rip)        # ffffffff8010d908 <input+0xe8>
ffffffff80100e19:	83 e0 7f             	and    $0x7f,%eax
ffffffff80100e1c:	89 c0                	mov    %eax,%eax
ffffffff80100e1e:	0f b6 80 88 d8 10 80 	movzbl -0x7fef2778(%rax),%eax
ffffffff80100e25:	0f be c0             	movsbl %al,%eax
ffffffff80100e28:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(c == C('D')){  // EOF
ffffffff80100e2b:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
ffffffff80100e2f:	75 19                	jne    ffffffff80100e4a <consoleread+0xcd>
      if(n < target){
ffffffff80100e31:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100e34:	3b 45 fc             	cmp    -0x4(%rbp),%eax
ffffffff80100e37:	73 34                	jae    ffffffff80100e6d <consoleread+0xf0>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
ffffffff80100e39:	8b 05 c9 ca 00 00    	mov    0xcac9(%rip),%eax        # ffffffff8010d908 <input+0xe8>
ffffffff80100e3f:	83 e8 01             	sub    $0x1,%eax
ffffffff80100e42:	89 05 c0 ca 00 00    	mov    %eax,0xcac0(%rip)        # ffffffff8010d908 <input+0xe8>
      }
      break;
ffffffff80100e48:	eb 23                	jmp    ffffffff80100e6d <consoleread+0xf0>
    }
    *dst++ = c;
ffffffff80100e4a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80100e4e:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffffffff80100e52:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
ffffffff80100e56:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffffffff80100e59:	88 10                	mov    %dl,(%rax)
    --n;
ffffffff80100e5b:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
    if(c == '\n')
ffffffff80100e5f:	83 7d f8 0a          	cmpl   $0xa,-0x8(%rbp)
ffffffff80100e63:	74 0b                	je     ffffffff80100e70 <consoleread+0xf3>
  while(n > 0){
ffffffff80100e65:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffffffff80100e69:	7f 8f                	jg     ffffffff80100dfa <consoleread+0x7d>
ffffffff80100e6b:	eb 04                	jmp    ffffffff80100e71 <consoleread+0xf4>
      break;
ffffffff80100e6d:	90                   	nop
ffffffff80100e6e:	eb 01                	jmp    ffffffff80100e71 <consoleread+0xf4>
      break;
ffffffff80100e70:	90                   	nop
  }
  release(&input.lock);
ffffffff80100e71:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100e78:	e8 3d 4e 00 00       	call   ffffffff80105cba <release>
  ilock(ip);
ffffffff80100e7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100e81:	48 89 c7             	mov    %rax,%rdi
ffffffff80100e84:	e8 0f 10 00 00       	call   ffffffff80101e98 <ilock>

  return target - n;
ffffffff80100e89:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80100e8c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80100e8f:	29 c2                	sub    %eax,%edx
ffffffff80100e91:	89 d0                	mov    %edx,%eax
}
ffffffff80100e93:	c9                   	leave
ffffffff80100e94:	c3                   	ret

ffffffff80100e95 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
ffffffff80100e95:	55                   	push   %rbp
ffffffff80100e96:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100e99:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80100e9d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80100ea1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80100ea5:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  iunlock(ip);
ffffffff80100ea8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100eac:	48 89 c7             	mov    %rax,%rdi
ffffffff80100eaf:	e8 55 11 00 00       	call   ffffffff80102009 <iunlock>
  acquire(&cons.lock);
ffffffff80100eb4:	48 c7 c7 20 d9 10 80 	mov    $0xffffffff8010d920,%rdi
ffffffff80100ebb:	e8 23 4d 00 00       	call   ffffffff80105be3 <acquire>
  for(i = 0; i < n; i++)
ffffffff80100ec0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80100ec7:	eb 21                	jmp    ffffffff80100eea <consolewrite+0x55>
    consputc(buf[i] & 0xff);
ffffffff80100ec9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100ecc:	48 63 d0             	movslq %eax,%rdx
ffffffff80100ecf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80100ed3:	48 01 d0             	add    %rdx,%rax
ffffffff80100ed6:	0f b6 00             	movzbl (%rax),%eax
ffffffff80100ed9:	0f be c0             	movsbl %al,%eax
ffffffff80100edc:	0f b6 c0             	movzbl %al,%eax
ffffffff80100edf:	89 c7                	mov    %eax,%edi
ffffffff80100ee1:	e8 80 fc ff ff       	call   ffffffff80100b66 <consputc>
  for(i = 0; i < n; i++)
ffffffff80100ee6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80100eea:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80100eed:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff80100ef0:	7c d7                	jl     ffffffff80100ec9 <consolewrite+0x34>
  release(&cons.lock);
ffffffff80100ef2:	48 c7 c7 20 d9 10 80 	mov    $0xffffffff8010d920,%rdi
ffffffff80100ef9:	e8 bc 4d 00 00       	call   ffffffff80105cba <release>
  ilock(ip);
ffffffff80100efe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80100f02:	48 89 c7             	mov    %rax,%rdi
ffffffff80100f05:	e8 8e 0f 00 00       	call   ffffffff80101e98 <ilock>

  return n;
ffffffff80100f0a:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffffffff80100f0d:	c9                   	leave
ffffffff80100f0e:	c3                   	ret

ffffffff80100f0f <consoleinit>:

void
consoleinit(void)
{
ffffffff80100f0f:	55                   	push   %rbp
ffffffff80100f10:	48 89 e5             	mov    %rsp,%rbp
  initlock(&cons.lock, "console");
ffffffff80100f13:	48 c7 c6 23 9c 10 80 	mov    $0xffffffff80109c23,%rsi
ffffffff80100f1a:	48 c7 c7 20 d9 10 80 	mov    $0xffffffff8010d920,%rdi
ffffffff80100f21:	e8 88 4c 00 00       	call   ffffffff80105bae <initlock>
  initlock(&input.lock, "input");
ffffffff80100f26:	48 c7 c6 2b 9c 10 80 	mov    $0xffffffff80109c2b,%rsi
ffffffff80100f2d:	48 c7 c7 20 d8 10 80 	mov    $0xffffffff8010d820,%rdi
ffffffff80100f34:	e8 75 4c 00 00       	call   ffffffff80105bae <initlock>

  devsw[CONSOLE].write = consolewrite;
ffffffff80100f39:	48 c7 05 74 ca 00 00 	movq   $0xffffffff80100e95,0xca74(%rip)        # ffffffff8010d9b8 <devsw+0x18>
ffffffff80100f40:	95 0e 10 80 
  devsw[CONSOLE].read = consoleread;
ffffffff80100f44:	48 c7 05 61 ca 00 00 	movq   $0xffffffff80100d7d,0xca61(%rip)        # ffffffff8010d9b0 <devsw+0x10>
ffffffff80100f4b:	7d 0d 10 80 
  cons.locking = 1;
ffffffff80100f4f:	c7 05 2f ca 00 00 01 	movl   $0x1,0xca2f(%rip)        # ffffffff8010d988 <cons+0x68>
ffffffff80100f56:	00 00 00 

  picenable(IRQ_KBD);
ffffffff80100f59:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80100f5e:	e8 bc 38 00 00       	call   ffffffff8010481f <picenable>
  ioapicenable(IRQ_KBD, 0);
ffffffff80100f63:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80100f68:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80100f6d:	e8 90 21 00 00       	call   ffffffff80103102 <ioapicenable>
}
ffffffff80100f72:	90                   	nop
ffffffff80100f73:	5d                   	pop    %rbp
ffffffff80100f74:	c3                   	ret

ffffffff80100f75 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
ffffffff80100f75:	55                   	push   %rbp
ffffffff80100f76:	48 89 e5             	mov    %rsp,%rbp
ffffffff80100f79:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
ffffffff80100f80:	48 89 bd 08 fe ff ff 	mov    %rdi,-0x1f8(%rbp)
ffffffff80100f87:	48 89 b5 00 fe ff ff 	mov    %rsi,-0x200(%rbp)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
ffffffff80100f8e:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffffffff80100f95:	48 89 c7             	mov    %rax,%rdi
ffffffff80100f98:	e8 c6 1b 00 00       	call   ffffffff80102b63 <namei>
ffffffff80100f9d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffffffff80100fa1:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffffffff80100fa6:	75 0a                	jne    ffffffff80100fb2 <exec+0x3d>
    return -1;
ffffffff80100fa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80100fad:	e9 c2 04 00 00       	jmp    ffffffff80101474 <exec+0x4ff>
  ilock(ip);
ffffffff80100fb2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80100fb6:	48 89 c7             	mov    %rax,%rdi
ffffffff80100fb9:	e8 da 0e 00 00       	call   ffffffff80101e98 <ilock>
  pgdir = 0;
ffffffff80100fbe:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
ffffffff80100fc5:	00 

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
ffffffff80100fc6:	48 8d b5 50 fe ff ff 	lea    -0x1b0(%rbp),%rsi
ffffffff80100fcd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80100fd1:	b9 40 00 00 00       	mov    $0x40,%ecx
ffffffff80100fd6:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80100fdb:	48 89 c7             	mov    %rax,%rdi
ffffffff80100fde:	e8 5d 14 00 00       	call   ffffffff80102440 <readi>
ffffffff80100fe3:	83 f8 3f             	cmp    $0x3f,%eax
ffffffff80100fe6:	0f 86 3e 04 00 00    	jbe    ffffffff8010142a <exec+0x4b5>
    goto bad;
  if(elf.magic != ELF_MAGIC)
ffffffff80100fec:	8b 85 50 fe ff ff    	mov    -0x1b0(%rbp),%eax
ffffffff80100ff2:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
ffffffff80100ff7:	0f 85 30 04 00 00    	jne    ffffffff8010142d <exec+0x4b8>
    goto bad;

  if((pgdir = setupkvm()) == 0)
ffffffff80100ffd:	e8 67 88 00 00       	call   ffffffff80109869 <setupkvm>
ffffffff80101002:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffffffff80101006:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffffffff8010100b:	0f 84 1f 04 00 00    	je     ffffffff80101430 <exec+0x4bb>
    goto bad;

  // Load program into memory.
  sz = 0;
ffffffff80101011:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
ffffffff80101018:	00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffffffff80101019:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffffffff80101020:	48 8b 85 70 fe ff ff 	mov    -0x190(%rbp),%rax
ffffffff80101027:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffffffff8010102a:	e9 c8 00 00 00       	jmp    ffffffff801010f7 <exec+0x182>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
ffffffff8010102f:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff80101032:	48 8d b5 10 fe ff ff 	lea    -0x1f0(%rbp),%rsi
ffffffff80101039:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff8010103d:	b9 38 00 00 00       	mov    $0x38,%ecx
ffffffff80101042:	48 89 c7             	mov    %rax,%rdi
ffffffff80101045:	e8 f6 13 00 00       	call   ffffffff80102440 <readi>
ffffffff8010104a:	83 f8 38             	cmp    $0x38,%eax
ffffffff8010104d:	0f 85 e0 03 00 00    	jne    ffffffff80101433 <exec+0x4be>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
ffffffff80101053:	8b 85 10 fe ff ff    	mov    -0x1f0(%rbp),%eax
ffffffff80101059:	83 f8 01             	cmp    $0x1,%eax
ffffffff8010105c:	0f 85 87 00 00 00    	jne    ffffffff801010e9 <exec+0x174>
      continue;
    if(ph.memsz < ph.filesz)
ffffffff80101062:	48 8b 95 38 fe ff ff 	mov    -0x1c8(%rbp),%rdx
ffffffff80101069:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffffffff80101070:	48 39 c2             	cmp    %rax,%rdx
ffffffff80101073:	0f 82 bd 03 00 00    	jb     ffffffff80101436 <exec+0x4c1>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
ffffffff80101079:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffffffff80101080:	89 c2                	mov    %eax,%edx
ffffffff80101082:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffffffff80101089:	01 c2                	add    %eax,%edx
ffffffff8010108b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010108f:	89 c1                	mov    %eax,%ecx
ffffffff80101091:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80101095:	89 ce                	mov    %ecx,%esi
ffffffff80101097:	48 89 c7             	mov    %rax,%rdi
ffffffff8010109a:	e8 a9 7b 00 00       	call   ffffffff80108c48 <allocuvm>
ffffffff8010109f:	48 98                	cltq
ffffffff801010a1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffffffff801010a5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffffffff801010aa:	0f 84 89 03 00 00    	je     ffffffff80101439 <exec+0x4c4>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
ffffffff801010b0:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffffffff801010b7:	89 c7                	mov    %eax,%edi
ffffffff801010b9:	48 8b 85 18 fe ff ff 	mov    -0x1e8(%rbp),%rax
ffffffff801010c0:	89 c1                	mov    %eax,%ecx
ffffffff801010c2:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffffffff801010c9:	48 89 c6             	mov    %rax,%rsi
ffffffff801010cc:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
ffffffff801010d0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff801010d4:	41 89 f8             	mov    %edi,%r8d
ffffffff801010d7:	48 89 c7             	mov    %rax,%rdi
ffffffff801010da:	e8 6f 7a 00 00       	call   ffffffff80108b4e <loaduvm>
ffffffff801010df:	85 c0                	test   %eax,%eax
ffffffff801010e1:	0f 88 55 03 00 00    	js     ffffffff8010143c <exec+0x4c7>
ffffffff801010e7:	eb 01                	jmp    ffffffff801010ea <exec+0x175>
      continue;
ffffffff801010e9:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffffffff801010ea:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffffffff801010ee:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffffffff801010f1:	83 c0 38             	add    $0x38,%eax
ffffffff801010f4:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffffffff801010f7:	0f b7 85 88 fe ff ff 	movzwl -0x178(%rbp),%eax
ffffffff801010fe:	0f b7 c0             	movzwl %ax,%eax
ffffffff80101101:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffffffff80101104:	0f 8c 25 ff ff ff    	jl     ffffffff8010102f <exec+0xba>
      goto bad;
  }
  iunlockput(ip);
ffffffff8010110a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff8010110e:	48 89 c7             	mov    %rax,%rdi
ffffffff80101111:	e8 4a 10 00 00       	call   ffffffff80102160 <iunlockput>
  ip = 0;
ffffffff80101116:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
ffffffff8010111d:	00 

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
ffffffff8010111e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80101122:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffffffff80101128:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff8010112e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
ffffffff80101132:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80101136:	8d 90 00 20 00 00    	lea    0x2000(%rax),%edx
ffffffff8010113c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80101140:	89 c1                	mov    %eax,%ecx
ffffffff80101142:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80101146:	89 ce                	mov    %ecx,%esi
ffffffff80101148:	48 89 c7             	mov    %rax,%rdi
ffffffff8010114b:	e8 f8 7a 00 00       	call   ffffffff80108c48 <allocuvm>
ffffffff80101150:	48 98                	cltq
ffffffff80101152:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffffffff80101156:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffffffff8010115b:	0f 84 de 02 00 00    	je     ffffffff8010143f <exec+0x4ca>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
ffffffff80101161:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80101165:	48 2d 00 20 00 00    	sub    $0x2000,%rax
ffffffff8010116b:	48 89 c2             	mov    %rax,%rdx
ffffffff8010116e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80101172:	48 89 d6             	mov    %rdx,%rsi
ffffffff80101175:	48 89 c7             	mov    %rax,%rdi
ffffffff80101178:	e8 2c 7d 00 00       	call   ffffffff80108ea9 <clearpteu>
  sp = sz;
ffffffff8010117d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80101181:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
ffffffff80101185:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
ffffffff8010118c:	00 
ffffffff8010118d:	e9 b5 00 00 00       	jmp    ffffffff80101247 <exec+0x2d2>
    if(argc >= MAXARG)
ffffffff80101192:	48 83 7d e0 1f       	cmpq   $0x1f,-0x20(%rbp)
ffffffff80101197:	0f 87 a5 02 00 00    	ja     ffffffff80101442 <exec+0x4cd>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~(sizeof(uintp)-1);
ffffffff8010119d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801011a1:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff801011a8:	00 
ffffffff801011a9:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffffffff801011b0:	48 01 d0             	add    %rdx,%rax
ffffffff801011b3:	48 8b 00             	mov    (%rax),%rax
ffffffff801011b6:	48 89 c7             	mov    %rax,%rdi
ffffffff801011b9:	e8 93 50 00 00       	call   ffffffff80106251 <strlen>
ffffffff801011be:	83 c0 01             	add    $0x1,%eax
ffffffff801011c1:	48 98                	cltq
ffffffff801011c3:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffffffff801011c7:	48 29 c2             	sub    %rax,%rdx
ffffffff801011ca:	48 89 d0             	mov    %rdx,%rax
ffffffff801011cd:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
ffffffff801011d1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
ffffffff801011d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801011d9:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff801011e0:	00 
ffffffff801011e1:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffffffff801011e8:	48 01 d0             	add    %rdx,%rax
ffffffff801011eb:	48 8b 00             	mov    (%rax),%rax
ffffffff801011ee:	48 89 c7             	mov    %rax,%rdi
ffffffff801011f1:	e8 5b 50 00 00       	call   ffffffff80106251 <strlen>
ffffffff801011f6:	83 c0 01             	add    $0x1,%eax
ffffffff801011f9:	89 c1                	mov    %eax,%ecx
ffffffff801011fb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801011ff:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80101206:	00 
ffffffff80101207:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffffffff8010120e:	48 01 d0             	add    %rdx,%rax
ffffffff80101211:	48 8b 10             	mov    (%rax),%rdx
ffffffff80101214:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80101218:	89 c6                	mov    %eax,%esi
ffffffff8010121a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff8010121e:	48 89 c7             	mov    %rax,%rdi
ffffffff80101221:	e8 89 7e 00 00       	call   ffffffff801090af <copyout>
ffffffff80101226:	85 c0                	test   %eax,%eax
ffffffff80101228:	0f 88 17 02 00 00    	js     ffffffff80101445 <exec+0x4d0>
      goto bad;
    ustack[3+argc] = sp;
ffffffff8010122e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80101232:	48 8d 50 03          	lea    0x3(%rax),%rdx
ffffffff80101236:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010123a:	48 89 84 d5 90 fe ff 	mov    %rax,-0x170(%rbp,%rdx,8)
ffffffff80101241:	ff 
  for(argc = 0; argv[argc]; argc++) {
ffffffff80101242:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
ffffffff80101247:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010124b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80101252:	00 
ffffffff80101253:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffffffff8010125a:	48 01 d0             	add    %rdx,%rax
ffffffff8010125d:	48 8b 00             	mov    (%rax),%rax
ffffffff80101260:	48 85 c0             	test   %rax,%rax
ffffffff80101263:	0f 85 29 ff ff ff    	jne    ffffffff80101192 <exec+0x21d>
  }
  ustack[3+argc] = 0;
ffffffff80101269:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010126d:	48 83 c0 03          	add    $0x3,%rax
ffffffff80101271:	48 c7 84 c5 90 fe ff 	movq   $0x0,-0x170(%rbp,%rax,8)
ffffffff80101278:	ff 00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
ffffffff8010127d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80101282:	48 89 85 90 fe ff ff 	mov    %rax,-0x170(%rbp)
  ustack[1] = argc;
ffffffff80101289:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010128d:	48 89 85 98 fe ff ff 	mov    %rax,-0x168(%rbp)
  ustack[2] = sp - (argc+1)*sizeof(uintp);  // argv pointer
ffffffff80101294:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80101298:	48 83 c0 01          	add    $0x1,%rax
ffffffff8010129c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff801012a3:	00 
ffffffff801012a4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff801012a8:	48 29 d0             	sub    %rdx,%rax
ffffffff801012ab:	48 89 85 a0 fe ff ff 	mov    %rax,-0x160(%rbp)

#if X64
  proc->tf->rdi = argc;
ffffffff801012b2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801012b9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801012bd:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff801012c1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff801012c5:	48 89 50 30          	mov    %rdx,0x30(%rax)
  proc->tf->rsi = sp - (argc+1)*sizeof(uintp);
ffffffff801012c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801012cd:	48 83 c0 01          	add    $0x1,%rax
ffffffff801012d1:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffffffff801012d8:	00 
ffffffff801012d9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801012e0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801012e4:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff801012e8:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffffffff801012ec:	48 29 ca             	sub    %rcx,%rdx
ffffffff801012ef:	48 89 50 28          	mov    %rdx,0x28(%rax)
#endif

  sp -= (3+argc+1) * sizeof(uintp);
ffffffff801012f3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801012f7:	48 83 c0 04          	add    $0x4,%rax
ffffffff801012fb:	48 c1 e0 03          	shl    $0x3,%rax
ffffffff801012ff:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*sizeof(uintp)) < 0)
ffffffff80101303:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80101307:	48 83 c0 04          	add    $0x4,%rax
ffffffff8010130b:	8d 0c c5 00 00 00 00 	lea    0x0(,%rax,8),%ecx
ffffffff80101312:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80101316:	89 c6                	mov    %eax,%esi
ffffffff80101318:	48 8d 95 90 fe ff ff 	lea    -0x170(%rbp),%rdx
ffffffff8010131f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80101323:	48 89 c7             	mov    %rax,%rdi
ffffffff80101326:	e8 84 7d 00 00       	call   ffffffff801090af <copyout>
ffffffff8010132b:	85 c0                	test   %eax,%eax
ffffffff8010132d:	0f 88 15 01 00 00    	js     ffffffff80101448 <exec+0x4d3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
ffffffff80101333:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffffffff8010133a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff8010133e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101342:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80101346:	eb 1c                	jmp    ffffffff80101364 <exec+0x3ef>
    if(*s == '/')
ffffffff80101348:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010134c:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010134f:	3c 2f                	cmp    $0x2f,%al
ffffffff80101351:	75 0c                	jne    ffffffff8010135f <exec+0x3ea>
      last = s+1;
ffffffff80101353:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101357:	48 83 c0 01          	add    $0x1,%rax
ffffffff8010135b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(last=s=path; *s; s++)
ffffffff8010135f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffffffff80101364:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101368:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010136b:	84 c0                	test   %al,%al
ffffffff8010136d:	75 d9                	jne    ffffffff80101348 <exec+0x3d3>
  safestrcpy(proc->name, last, sizeof(proc->name));
ffffffff8010136f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80101376:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010137a:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffffffff80101381:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101385:	ba 10 00 00 00       	mov    $0x10,%edx
ffffffff8010138a:	48 89 c6             	mov    %rax,%rsi
ffffffff8010138d:	48 89 cf             	mov    %rcx,%rdi
ffffffff80101390:	e8 59 4e 00 00       	call   ffffffff801061ee <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
ffffffff80101395:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010139c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801013a0:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff801013a4:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  proc->pgdir = pgdir;
ffffffff801013a8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801013af:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801013b3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
ffffffff801013b7:	48 89 50 08          	mov    %rdx,0x8(%rax)
  proc->sz = sz;
ffffffff801013bb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801013c2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801013c6:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffffffff801013ca:	48 89 10             	mov    %rdx,(%rax)
  proc->tf->eip = elf.entry;  // main
ffffffff801013cd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801013d4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801013d8:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff801013dc:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffffffff801013e3:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  proc->tf->esp = sp;
ffffffff801013ea:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801013f1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801013f5:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff801013f9:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffffffff801013fd:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  switchuvm(proc);
ffffffff80101404:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010140b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010140f:	48 89 c7             	mov    %rax,%rdi
ffffffff80101412:	e8 1f 87 00 00       	call   ffffffff80109b36 <switchuvm>
  freevm(oldpgdir);
ffffffff80101417:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff8010141b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010141e:	e8 dc 79 00 00       	call   ffffffff80108dff <freevm>
  return 0;
ffffffff80101423:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80101428:	eb 4a                	jmp    ffffffff80101474 <exec+0x4ff>
    goto bad;
ffffffff8010142a:	90                   	nop
ffffffff8010142b:	eb 1c                	jmp    ffffffff80101449 <exec+0x4d4>
    goto bad;
ffffffff8010142d:	90                   	nop
ffffffff8010142e:	eb 19                	jmp    ffffffff80101449 <exec+0x4d4>
    goto bad;
ffffffff80101430:	90                   	nop
ffffffff80101431:	eb 16                	jmp    ffffffff80101449 <exec+0x4d4>
      goto bad;
ffffffff80101433:	90                   	nop
ffffffff80101434:	eb 13                	jmp    ffffffff80101449 <exec+0x4d4>
      goto bad;
ffffffff80101436:	90                   	nop
ffffffff80101437:	eb 10                	jmp    ffffffff80101449 <exec+0x4d4>
      goto bad;
ffffffff80101439:	90                   	nop
ffffffff8010143a:	eb 0d                	jmp    ffffffff80101449 <exec+0x4d4>
      goto bad;
ffffffff8010143c:	90                   	nop
ffffffff8010143d:	eb 0a                	jmp    ffffffff80101449 <exec+0x4d4>
    goto bad;
ffffffff8010143f:	90                   	nop
ffffffff80101440:	eb 07                	jmp    ffffffff80101449 <exec+0x4d4>
      goto bad;
ffffffff80101442:	90                   	nop
ffffffff80101443:	eb 04                	jmp    ffffffff80101449 <exec+0x4d4>
      goto bad;
ffffffff80101445:	90                   	nop
ffffffff80101446:	eb 01                	jmp    ffffffff80101449 <exec+0x4d4>
    goto bad;
ffffffff80101448:	90                   	nop

 bad:
  if(pgdir)
ffffffff80101449:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffffffff8010144e:	74 0c                	je     ffffffff8010145c <exec+0x4e7>
    freevm(pgdir);
ffffffff80101450:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80101454:	48 89 c7             	mov    %rax,%rdi
ffffffff80101457:	e8 a3 79 00 00       	call   ffffffff80108dff <freevm>
  if(ip)
ffffffff8010145c:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffffffff80101461:	74 0c                	je     ffffffff8010146f <exec+0x4fa>
    iunlockput(ip);
ffffffff80101463:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80101467:	48 89 c7             	mov    %rax,%rdi
ffffffff8010146a:	e8 f1 0c 00 00       	call   ffffffff80102160 <iunlockput>
  return -1;
ffffffff8010146f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80101474:	c9                   	leave
ffffffff80101475:	c3                   	ret

ffffffff80101476 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
ffffffff80101476:	55                   	push   %rbp
ffffffff80101477:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ftable.lock, "ftable");
ffffffff8010147a:	48 c7 c6 31 9c 10 80 	mov    $0xffffffff80109c31,%rsi
ffffffff80101481:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff80101488:	e8 21 47 00 00       	call   ffffffff80105bae <initlock>
}
ffffffff8010148d:	90                   	nop
ffffffff8010148e:	5d                   	pop    %rbp
ffffffff8010148f:	c3                   	ret

ffffffff80101490 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
ffffffff80101490:	55                   	push   %rbp
ffffffff80101491:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101494:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;

  acquire(&ftable.lock);
ffffffff80101498:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff8010149f:	e8 3f 47 00 00       	call   ffffffff80105be3 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffffffff801014a4:	48 c7 45 f8 a8 da 10 	movq   $0xffffffff8010daa8,-0x8(%rbp)
ffffffff801014ab:	80 
ffffffff801014ac:	eb 2d                	jmp    ffffffff801014db <filealloc+0x4b>
    if(f->ref == 0){
ffffffff801014ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801014b2:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801014b5:	85 c0                	test   %eax,%eax
ffffffff801014b7:	75 1d                	jne    ffffffff801014d6 <filealloc+0x46>
      f->ref = 1;
ffffffff801014b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801014bd:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%rax)
      release(&ftable.lock);
ffffffff801014c4:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff801014cb:	e8 ea 47 00 00       	call   ffffffff80105cba <release>
      return f;
ffffffff801014d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801014d4:	eb 23                	jmp    ffffffff801014f9 <filealloc+0x69>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffffffff801014d6:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffffffff801014db:	48 c7 c0 48 ea 10 80 	mov    $0xffffffff8010ea48,%rax
ffffffff801014e2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff801014e6:	72 c6                	jb     ffffffff801014ae <filealloc+0x1e>
    }
  }
  release(&ftable.lock);
ffffffff801014e8:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff801014ef:	e8 c6 47 00 00       	call   ffffffff80105cba <release>
  return 0;
ffffffff801014f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801014f9:	c9                   	leave
ffffffff801014fa:	c3                   	ret

ffffffff801014fb <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
ffffffff801014fb:	55                   	push   %rbp
ffffffff801014fc:	48 89 e5             	mov    %rsp,%rbp
ffffffff801014ff:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80101503:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ftable.lock);
ffffffff80101507:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff8010150e:	e8 d0 46 00 00       	call   ffffffff80105be3 <acquire>
  if(f->ref < 1)
ffffffff80101513:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101517:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff8010151a:	85 c0                	test   %eax,%eax
ffffffff8010151c:	7f 0c                	jg     ffffffff8010152a <filedup+0x2f>
    panic("filedup");
ffffffff8010151e:	48 c7 c7 38 9c 10 80 	mov    $0xffffffff80109c38,%rdi
ffffffff80101525:	e8 05 f4 ff ff       	call   ffffffff8010092f <panic>
  f->ref++;
ffffffff8010152a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010152e:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101531:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80101534:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101538:	89 50 04             	mov    %edx,0x4(%rax)
  release(&ftable.lock);
ffffffff8010153b:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff80101542:	e8 73 47 00 00       	call   ffffffff80105cba <release>
  return f;
ffffffff80101547:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff8010154b:	c9                   	leave
ffffffff8010154c:	c3                   	ret

ffffffff8010154d <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
ffffffff8010154d:	55                   	push   %rbp
ffffffff8010154e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101551:	53                   	push   %rbx
ffffffff80101552:	48 83 ec 48          	sub    $0x48,%rsp
ffffffff80101556:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct file ff;

  acquire(&ftable.lock);
ffffffff8010155a:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff80101561:	e8 7d 46 00 00       	call   ffffffff80105be3 <acquire>
  if(f->ref < 1)
ffffffff80101566:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff8010156a:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff8010156d:	85 c0                	test   %eax,%eax
ffffffff8010156f:	7f 0c                	jg     ffffffff8010157d <fileclose+0x30>
    panic("fileclose");
ffffffff80101571:	48 c7 c7 40 9c 10 80 	mov    $0xffffffff80109c40,%rdi
ffffffff80101578:	e8 b2 f3 ff ff       	call   ffffffff8010092f <panic>
  if(--f->ref > 0){
ffffffff8010157d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff80101581:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101584:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff80101587:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff8010158b:	89 50 04             	mov    %edx,0x4(%rax)
ffffffff8010158e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff80101592:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101595:	85 c0                	test   %eax,%eax
ffffffff80101597:	7e 11                	jle    ffffffff801015aa <fileclose+0x5d>
    release(&ftable.lock);
ffffffff80101599:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff801015a0:	e8 15 47 00 00       	call   ffffffff80105cba <release>
ffffffff801015a5:	e9 93 00 00 00       	jmp    ffffffff8010163d <fileclose+0xf0>
    return;
  }
  ff = *f;
ffffffff801015aa:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801015ae:	48 8b 08             	mov    (%rax),%rcx
ffffffff801015b1:	48 8b 58 08          	mov    0x8(%rax),%rbx
ffffffff801015b5:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffffffff801015b9:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
ffffffff801015bd:	48 8b 48 10          	mov    0x10(%rax),%rcx
ffffffff801015c1:	48 8b 58 18          	mov    0x18(%rax),%rbx
ffffffff801015c5:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffffffff801015c9:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffffffff801015cd:	48 8b 40 20          	mov    0x20(%rax),%rax
ffffffff801015d1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  f->ref = 0;
ffffffff801015d5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801015d9:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  f->type = FD_NONE;
ffffffff801015e0:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801015e4:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  release(&ftable.lock);
ffffffff801015ea:	48 c7 c7 40 da 10 80 	mov    $0xffffffff8010da40,%rdi
ffffffff801015f1:	e8 c4 46 00 00       	call   ffffffff80105cba <release>
  
  if(ff.type == FD_PIPE)
ffffffff801015f6:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffffffff801015f9:	83 f8 01             	cmp    $0x1,%eax
ffffffff801015fc:	75 17                	jne    ffffffff80101615 <fileclose+0xc8>
    pipeclose(ff.pipe, ff.writable);
ffffffff801015fe:	0f b6 45 c9          	movzbl -0x37(%rbp),%eax
ffffffff80101602:	0f be d0             	movsbl %al,%edx
ffffffff80101605:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80101609:	89 d6                	mov    %edx,%esi
ffffffff8010160b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010160e:	e8 bd 34 00 00       	call   ffffffff80104ad0 <pipeclose>
ffffffff80101613:	eb 28                	jmp    ffffffff8010163d <fileclose+0xf0>
  else if(ff.type == FD_INODE){
ffffffff80101615:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffffffff80101618:	83 f8 02             	cmp    $0x2,%eax
ffffffff8010161b:	75 20                	jne    ffffffff8010163d <fileclose+0xf0>
    begin_trans();
ffffffff8010161d:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80101622:	e8 20 24 00 00       	call   ffffffff80103a47 <begin_trans>
    iput(ff.ip);
ffffffff80101627:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010162b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010162e:	e8 48 0a 00 00       	call   ffffffff8010207b <iput>
    commit_trans();
ffffffff80101633:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80101638:	e8 52 24 00 00       	call   ffffffff80103a8f <commit_trans>
  }
}
ffffffff8010163d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffffffff80101641:	c9                   	leave
ffffffff80101642:	c3                   	ret

ffffffff80101643 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
ffffffff80101643:	55                   	push   %rbp
ffffffff80101644:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101647:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010164b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010164f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(f->type == FD_INODE){
ffffffff80101653:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101657:	8b 00                	mov    (%rax),%eax
ffffffff80101659:	83 f8 02             	cmp    $0x2,%eax
ffffffff8010165c:	75 3e                	jne    ffffffff8010169c <filestat+0x59>
    ilock(f->ip);
ffffffff8010165e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101662:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80101666:	48 89 c7             	mov    %rax,%rdi
ffffffff80101669:	e8 2a 08 00 00       	call   ffffffff80101e98 <ilock>
    stati(f->ip, st);
ffffffff8010166e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101672:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80101676:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff8010167a:	48 89 d6             	mov    %rdx,%rsi
ffffffff8010167d:	48 89 c7             	mov    %rax,%rdi
ffffffff80101680:	e8 5e 0d 00 00       	call   ffffffff801023e3 <stati>
    iunlock(f->ip);
ffffffff80101685:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101689:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff8010168d:	48 89 c7             	mov    %rax,%rdi
ffffffff80101690:	e8 74 09 00 00       	call   ffffffff80102009 <iunlock>
    return 0;
ffffffff80101695:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010169a:	eb 05                	jmp    ffffffff801016a1 <filestat+0x5e>
  }
  return -1;
ffffffff8010169c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff801016a1:	c9                   	leave
ffffffff801016a2:	c3                   	ret

ffffffff801016a3 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
ffffffff801016a3:	55                   	push   %rbp
ffffffff801016a4:	48 89 e5             	mov    %rsp,%rbp
ffffffff801016a7:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff801016ab:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801016af:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff801016b3:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->readable == 0)
ffffffff801016b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801016ba:	0f b6 40 08          	movzbl 0x8(%rax),%eax
ffffffff801016be:	84 c0                	test   %al,%al
ffffffff801016c0:	75 0a                	jne    ffffffff801016cc <fileread+0x29>
    return -1;
ffffffff801016c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801016c7:	e9 9d 00 00 00       	jmp    ffffffff80101769 <fileread+0xc6>
  if(f->type == FD_PIPE)
ffffffff801016cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801016d0:	8b 00                	mov    (%rax),%eax
ffffffff801016d2:	83 f8 01             	cmp    $0x1,%eax
ffffffff801016d5:	75 1c                	jne    ffffffff801016f3 <fileread+0x50>
    return piperead(f->pipe, addr, n);
ffffffff801016d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801016db:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff801016df:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffffffff801016e2:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffffffff801016e6:	48 89 ce             	mov    %rcx,%rsi
ffffffff801016e9:	48 89 c7             	mov    %rax,%rdi
ffffffff801016ec:	e8 9a 35 00 00       	call   ffffffff80104c8b <piperead>
ffffffff801016f1:	eb 76                	jmp    ffffffff80101769 <fileread+0xc6>
  if(f->type == FD_INODE){
ffffffff801016f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801016f7:	8b 00                	mov    (%rax),%eax
ffffffff801016f9:	83 f8 02             	cmp    $0x2,%eax
ffffffff801016fc:	75 5f                	jne    ffffffff8010175d <fileread+0xba>
    ilock(f->ip);
ffffffff801016fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101702:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80101706:	48 89 c7             	mov    %rax,%rdi
ffffffff80101709:	e8 8a 07 00 00       	call   ffffffff80101e98 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
ffffffff8010170e:	8b 4d dc             	mov    -0x24(%rbp),%ecx
ffffffff80101711:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101715:	8b 50 20             	mov    0x20(%rax),%edx
ffffffff80101718:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010171c:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80101720:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
ffffffff80101724:	48 89 c7             	mov    %rax,%rdi
ffffffff80101727:	e8 14 0d 00 00       	call   ffffffff80102440 <readi>
ffffffff8010172c:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff8010172f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80101733:	7e 13                	jle    ffffffff80101748 <fileread+0xa5>
      f->off += r;
ffffffff80101735:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101739:	8b 50 20             	mov    0x20(%rax),%edx
ffffffff8010173c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010173f:	01 c2                	add    %eax,%edx
ffffffff80101741:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101745:	89 50 20             	mov    %edx,0x20(%rax)
    iunlock(f->ip);
ffffffff80101748:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010174c:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80101750:	48 89 c7             	mov    %rax,%rdi
ffffffff80101753:	e8 b1 08 00 00       	call   ffffffff80102009 <iunlock>
    return r;
ffffffff80101758:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010175b:	eb 0c                	jmp    ffffffff80101769 <fileread+0xc6>
  }
  panic("fileread");
ffffffff8010175d:	48 c7 c7 4a 9c 10 80 	mov    $0xffffffff80109c4a,%rdi
ffffffff80101764:	e8 c6 f1 ff ff       	call   ffffffff8010092f <panic>
}
ffffffff80101769:	c9                   	leave
ffffffff8010176a:	c3                   	ret

ffffffff8010176b <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
ffffffff8010176b:	55                   	push   %rbp
ffffffff8010176c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010176f:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80101773:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80101777:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff8010177b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->writable == 0)
ffffffff8010177e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101782:	0f b6 40 09          	movzbl 0x9(%rax),%eax
ffffffff80101786:	84 c0                	test   %al,%al
ffffffff80101788:	75 0a                	jne    ffffffff80101794 <filewrite+0x29>
    return -1;
ffffffff8010178a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010178f:	e9 29 01 00 00       	jmp    ffffffff801018bd <filewrite+0x152>
  if(f->type == FD_PIPE)
ffffffff80101794:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101798:	8b 00                	mov    (%rax),%eax
ffffffff8010179a:	83 f8 01             	cmp    $0x1,%eax
ffffffff8010179d:	75 1f                	jne    ffffffff801017be <filewrite+0x53>
    return pipewrite(f->pipe, addr, n);
ffffffff8010179f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801017a3:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff801017a7:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffffffff801017aa:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffffffff801017ae:	48 89 ce             	mov    %rcx,%rsi
ffffffff801017b1:	48 89 c7             	mov    %rax,%rdi
ffffffff801017b4:	e8 c0 33 00 00       	call   ffffffff80104b79 <pipewrite>
ffffffff801017b9:	e9 ff 00 00 00       	jmp    ffffffff801018bd <filewrite+0x152>
  if(f->type == FD_INODE){
ffffffff801017be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801017c2:	8b 00                	mov    (%rax),%eax
ffffffff801017c4:	83 f8 02             	cmp    $0x2,%eax
ffffffff801017c7:	0f 85 e4 00 00 00    	jne    ffffffff801018b1 <filewrite+0x146>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
ffffffff801017cd:	c7 45 f4 00 06 00 00 	movl   $0x600,-0xc(%rbp)
    int i = 0;
ffffffff801017d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    while(i < n){
ffffffff801017db:	e9 ae 00 00 00       	jmp    ffffffff8010188e <filewrite+0x123>
      int n1 = n - i;
ffffffff801017e0:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801017e3:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffffffff801017e6:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(n1 > max)
ffffffff801017e9:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff801017ec:	3b 45 f4             	cmp    -0xc(%rbp),%eax
ffffffff801017ef:	7e 06                	jle    ffffffff801017f7 <filewrite+0x8c>
        n1 = max;
ffffffff801017f1:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff801017f4:	89 45 f8             	mov    %eax,-0x8(%rbp)

      begin_trans();
ffffffff801017f7:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801017fc:	e8 46 22 00 00       	call   ffffffff80103a47 <begin_trans>
      ilock(f->ip);
ffffffff80101801:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101805:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80101809:	48 89 c7             	mov    %rax,%rdi
ffffffff8010180c:	e8 87 06 00 00       	call   ffffffff80101e98 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
ffffffff80101811:	8b 4d f8             	mov    -0x8(%rbp),%ecx
ffffffff80101814:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101818:	8b 50 20             	mov    0x20(%rax),%edx
ffffffff8010181b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010181e:	48 63 f0             	movslq %eax,%rsi
ffffffff80101821:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80101825:	48 01 c6             	add    %rax,%rsi
ffffffff80101828:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010182c:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff80101830:	48 89 c7             	mov    %rax,%rdi
ffffffff80101833:	e8 8c 0d 00 00       	call   ffffffff801025c4 <writei>
ffffffff80101838:	89 45 f0             	mov    %eax,-0x10(%rbp)
ffffffff8010183b:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffffffff8010183f:	7e 13                	jle    ffffffff80101854 <filewrite+0xe9>
        f->off += r;
ffffffff80101841:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101845:	8b 50 20             	mov    0x20(%rax),%edx
ffffffff80101848:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff8010184b:	01 c2                	add    %eax,%edx
ffffffff8010184d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101851:	89 50 20             	mov    %edx,0x20(%rax)
      iunlock(f->ip);
ffffffff80101854:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101858:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff8010185c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010185f:	e8 a5 07 00 00       	call   ffffffff80102009 <iunlock>
      commit_trans();
ffffffff80101864:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80101869:	e8 21 22 00 00       	call   ffffffff80103a8f <commit_trans>

      if(r < 0)
ffffffff8010186e:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffffffff80101872:	78 28                	js     ffffffff8010189c <filewrite+0x131>
        break;
      if(r != n1)
ffffffff80101874:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff80101877:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffffffff8010187a:	74 0c                	je     ffffffff80101888 <filewrite+0x11d>
        panic("short filewrite");
ffffffff8010187c:	48 c7 c7 53 9c 10 80 	mov    $0xffffffff80109c53,%rdi
ffffffff80101883:	e8 a7 f0 ff ff       	call   ffffffff8010092f <panic>
      i += r;
ffffffff80101888:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff8010188b:	01 45 fc             	add    %eax,-0x4(%rbp)
    while(i < n){
ffffffff8010188e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80101891:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff80101894:	0f 8c 46 ff ff ff    	jl     ffffffff801017e0 <filewrite+0x75>
ffffffff8010189a:	eb 01                	jmp    ffffffff8010189d <filewrite+0x132>
        break;
ffffffff8010189c:	90                   	nop
    }
    return i == n ? n : -1;
ffffffff8010189d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801018a0:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff801018a3:	75 05                	jne    ffffffff801018aa <filewrite+0x13f>
ffffffff801018a5:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801018a8:	eb 13                	jmp    ffffffff801018bd <filewrite+0x152>
ffffffff801018aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801018af:	eb 0c                	jmp    ffffffff801018bd <filewrite+0x152>
  }
  panic("filewrite");
ffffffff801018b1:	48 c7 c7 63 9c 10 80 	mov    $0xffffffff80109c63,%rdi
ffffffff801018b8:	e8 72 f0 ff ff       	call   ffffffff8010092f <panic>
}
ffffffff801018bd:	c9                   	leave
ffffffff801018be:	c3                   	ret

ffffffff801018bf <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
ffffffff801018bf:	55                   	push   %rbp
ffffffff801018c0:	48 89 e5             	mov    %rsp,%rbp
ffffffff801018c3:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801018c7:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff801018ca:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct buf *bp;
  
  bp = bread(dev, 1);
ffffffff801018ce:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801018d1:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff801018d6:	89 c7                	mov    %eax,%edi
ffffffff801018d8:	e8 fa e9 ff ff       	call   ffffffff801002d7 <bread>
ffffffff801018dd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memmove(sb, bp->data, sizeof(*sb));
ffffffff801018e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801018e5:	48 8d 48 28          	lea    0x28(%rax),%rcx
ffffffff801018e9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801018ed:	ba 10 00 00 00       	mov    $0x10,%edx
ffffffff801018f2:	48 89 ce             	mov    %rcx,%rsi
ffffffff801018f5:	48 89 c7             	mov    %rax,%rdi
ffffffff801018f8:	e8 45 47 00 00       	call   ffffffff80106042 <memmove>
  brelse(bp);
ffffffff801018fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101901:	48 89 c7             	mov    %rax,%rdi
ffffffff80101904:	e8 53 ea ff ff       	call   ffffffff8010035c <brelse>
}
ffffffff80101909:	90                   	nop
ffffffff8010190a:	c9                   	leave
ffffffff8010190b:	c3                   	ret

ffffffff8010190c <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
ffffffff8010190c:	55                   	push   %rbp
ffffffff8010190d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101910:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80101914:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff80101917:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *bp;
  
  bp = bread(dev, bno);
ffffffff8010191a:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff8010191d:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80101920:	89 d6                	mov    %edx,%esi
ffffffff80101922:	89 c7                	mov    %eax,%edi
ffffffff80101924:	e8 ae e9 ff ff       	call   ffffffff801002d7 <bread>
ffffffff80101929:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(bp->data, 0, BSIZE);
ffffffff8010192d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101931:	48 83 c0 28          	add    $0x28,%rax
ffffffff80101935:	ba 00 02 00 00       	mov    $0x200,%edx
ffffffff8010193a:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff8010193f:	48 89 c7             	mov    %rax,%rdi
ffffffff80101942:	e8 0c 46 00 00       	call   ffffffff80105f53 <memset>
  log_write(bp);
ffffffff80101947:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010194b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010194e:	e8 94 21 00 00       	call   ffffffff80103ae7 <log_write>
  brelse(bp);
ffffffff80101953:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101957:	48 89 c7             	mov    %rax,%rdi
ffffffff8010195a:	e8 fd e9 ff ff       	call   ffffffff8010035c <brelse>
}
ffffffff8010195f:	90                   	nop
ffffffff80101960:	c9                   	leave
ffffffff80101961:	c3                   	ret

ffffffff80101962 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
ffffffff80101962:	55                   	push   %rbp
ffffffff80101963:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101966:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff8010196a:	89 7d cc             	mov    %edi,-0x34(%rbp)
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
ffffffff8010196d:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffffffff80101974:	00 
  readsb(dev, &sb);
ffffffff80101975:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80101978:	48 8d 55 d0          	lea    -0x30(%rbp),%rdx
ffffffff8010197c:	48 89 d6             	mov    %rdx,%rsi
ffffffff8010197f:	89 c7                	mov    %eax,%edi
ffffffff80101981:	e8 39 ff ff ff       	call   ffffffff801018bf <readsb>
  for(b = 0; b < sb.size; b += BPB){
ffffffff80101986:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff8010198d:	e9 0d 01 00 00       	jmp    ffffffff80101a9f <balloc+0x13d>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
ffffffff80101992:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80101995:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
ffffffff8010199b:	85 c0                	test   %eax,%eax
ffffffff8010199d:	0f 48 c2             	cmovs  %edx,%eax
ffffffff801019a0:	c1 f8 0c             	sar    $0xc,%eax
ffffffff801019a3:	89 c2                	mov    %eax,%edx
ffffffff801019a5:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffffffff801019a8:	c1 e8 03             	shr    $0x3,%eax
ffffffff801019ab:	01 d0                	add    %edx,%eax
ffffffff801019ad:	8d 50 03             	lea    0x3(%rax),%edx
ffffffff801019b0:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff801019b3:	89 d6                	mov    %edx,%esi
ffffffff801019b5:	89 c7                	mov    %eax,%edi
ffffffff801019b7:	e8 1b e9 ff ff       	call   ffffffff801002d7 <bread>
ffffffff801019bc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffffffff801019c0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffffffff801019c7:	e9 a2 00 00 00       	jmp    ffffffff80101a6e <balloc+0x10c>
      m = 1 << (bi % 8);
ffffffff801019cc:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff801019cf:	83 e0 07             	and    $0x7,%eax
ffffffff801019d2:	ba 01 00 00 00       	mov    $0x1,%edx
ffffffff801019d7:	89 c1                	mov    %eax,%ecx
ffffffff801019d9:	d3 e2                	shl    %cl,%edx
ffffffff801019db:	89 d0                	mov    %edx,%eax
ffffffff801019dd:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
ffffffff801019e0:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff801019e3:	8d 50 07             	lea    0x7(%rax),%edx
ffffffff801019e6:	85 c0                	test   %eax,%eax
ffffffff801019e8:	0f 48 c2             	cmovs  %edx,%eax
ffffffff801019eb:	c1 f8 03             	sar    $0x3,%eax
ffffffff801019ee:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff801019f2:	48 98                	cltq
ffffffff801019f4:	0f b6 44 02 28       	movzbl 0x28(%rdx,%rax,1),%eax
ffffffff801019f9:	0f b6 c0             	movzbl %al,%eax
ffffffff801019fc:	23 45 ec             	and    -0x14(%rbp),%eax
ffffffff801019ff:	85 c0                	test   %eax,%eax
ffffffff80101a01:	75 67                	jne    ffffffff80101a6a <balloc+0x108>
        bp->data[bi/8] |= m;  // Mark block in use.
ffffffff80101a03:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101a06:	8d 50 07             	lea    0x7(%rax),%edx
ffffffff80101a09:	85 c0                	test   %eax,%eax
ffffffff80101a0b:	0f 48 c2             	cmovs  %edx,%eax
ffffffff80101a0e:	c1 f8 03             	sar    $0x3,%eax
ffffffff80101a11:	89 c1                	mov    %eax,%ecx
ffffffff80101a13:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80101a17:	48 63 c1             	movslq %ecx,%rax
ffffffff80101a1a:	0f b6 44 02 28       	movzbl 0x28(%rdx,%rax,1),%eax
ffffffff80101a1f:	89 c2                	mov    %eax,%edx
ffffffff80101a21:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80101a24:	09 d0                	or     %edx,%eax
ffffffff80101a26:	89 c6                	mov    %eax,%esi
ffffffff80101a28:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80101a2c:	48 63 c1             	movslq %ecx,%rax
ffffffff80101a2f:	40 88 74 02 28       	mov    %sil,0x28(%rdx,%rax,1)
        log_write(bp);
ffffffff80101a34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101a38:	48 89 c7             	mov    %rax,%rdi
ffffffff80101a3b:	e8 a7 20 00 00       	call   ffffffff80103ae7 <log_write>
        brelse(bp);
ffffffff80101a40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101a44:	48 89 c7             	mov    %rax,%rdi
ffffffff80101a47:	e8 10 e9 ff ff       	call   ffffffff8010035c <brelse>
        bzero(dev, b + bi);
ffffffff80101a4c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101a4f:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101a52:	01 c2                	add    %eax,%edx
ffffffff80101a54:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80101a57:	89 d6                	mov    %edx,%esi
ffffffff80101a59:	89 c7                	mov    %eax,%edi
ffffffff80101a5b:	e8 ac fe ff ff       	call   ffffffff8010190c <bzero>
        return b + bi;
ffffffff80101a60:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101a63:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101a66:	01 d0                	add    %edx,%eax
ffffffff80101a68:	eb 4f                	jmp    ffffffff80101ab9 <balloc+0x157>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffffffff80101a6a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffffffff80101a6e:	81 7d f8 ff 0f 00 00 	cmpl   $0xfff,-0x8(%rbp)
ffffffff80101a75:	7f 15                	jg     ffffffff80101a8c <balloc+0x12a>
ffffffff80101a77:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101a7a:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80101a7d:	01 d0                	add    %edx,%eax
ffffffff80101a7f:	89 c2                	mov    %eax,%edx
ffffffff80101a81:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffffffff80101a84:	39 c2                	cmp    %eax,%edx
ffffffff80101a86:	0f 82 40 ff ff ff    	jb     ffffffff801019cc <balloc+0x6a>
      }
    }
    brelse(bp);
ffffffff80101a8c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101a90:	48 89 c7             	mov    %rax,%rdi
ffffffff80101a93:	e8 c4 e8 ff ff       	call   ffffffff8010035c <brelse>
  for(b = 0; b < sb.size; b += BPB){
ffffffff80101a98:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffffffff80101a9f:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffffffff80101aa2:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101aa5:	39 c2                	cmp    %eax,%edx
ffffffff80101aa7:	0f 82 e5 fe ff ff    	jb     ffffffff80101992 <balloc+0x30>
  }
  panic("balloc: out of blocks");
ffffffff80101aad:	48 c7 c7 6d 9c 10 80 	mov    $0xffffffff80109c6d,%rdi
ffffffff80101ab4:	e8 76 ee ff ff       	call   ffffffff8010092f <panic>
}
ffffffff80101ab9:	c9                   	leave
ffffffff80101aba:	c3                   	ret

ffffffff80101abb <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
ffffffff80101abb:	55                   	push   %rbp
ffffffff80101abc:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101abf:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80101ac3:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffffffff80101ac6:	89 75 d8             	mov    %esi,-0x28(%rbp)
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
ffffffff80101ac9:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffffffff80101acd:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80101ad0:	48 89 d6             	mov    %rdx,%rsi
ffffffff80101ad3:	89 c7                	mov    %eax,%edi
ffffffff80101ad5:	e8 e5 fd ff ff       	call   ffffffff801018bf <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
ffffffff80101ada:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffffffff80101add:	c1 e8 0c             	shr    $0xc,%eax
ffffffff80101ae0:	89 c2                	mov    %eax,%edx
ffffffff80101ae2:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffffffff80101ae5:	c1 e8 03             	shr    $0x3,%eax
ffffffff80101ae8:	01 d0                	add    %edx,%eax
ffffffff80101aea:	8d 50 03             	lea    0x3(%rax),%edx
ffffffff80101aed:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80101af0:	89 d6                	mov    %edx,%esi
ffffffff80101af2:	89 c7                	mov    %eax,%edi
ffffffff80101af4:	e8 de e7 ff ff       	call   ffffffff801002d7 <bread>
ffffffff80101af9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  bi = b % BPB;
ffffffff80101afd:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffffffff80101b00:	25 ff 0f 00 00       	and    $0xfff,%eax
ffffffff80101b05:	89 45 f4             	mov    %eax,-0xc(%rbp)
  m = 1 << (bi % 8);
ffffffff80101b08:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80101b0b:	83 e0 07             	and    $0x7,%eax
ffffffff80101b0e:	ba 01 00 00 00       	mov    $0x1,%edx
ffffffff80101b13:	89 c1                	mov    %eax,%ecx
ffffffff80101b15:	d3 e2                	shl    %cl,%edx
ffffffff80101b17:	89 d0                	mov    %edx,%eax
ffffffff80101b19:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if((bp->data[bi/8] & m) == 0)
ffffffff80101b1c:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80101b1f:	8d 50 07             	lea    0x7(%rax),%edx
ffffffff80101b22:	85 c0                	test   %eax,%eax
ffffffff80101b24:	0f 48 c2             	cmovs  %edx,%eax
ffffffff80101b27:	c1 f8 03             	sar    $0x3,%eax
ffffffff80101b2a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80101b2e:	48 98                	cltq
ffffffff80101b30:	0f b6 44 02 28       	movzbl 0x28(%rdx,%rax,1),%eax
ffffffff80101b35:	0f b6 c0             	movzbl %al,%eax
ffffffff80101b38:	23 45 f0             	and    -0x10(%rbp),%eax
ffffffff80101b3b:	85 c0                	test   %eax,%eax
ffffffff80101b3d:	75 0c                	jne    ffffffff80101b4b <bfree+0x90>
    panic("freeing free block");
ffffffff80101b3f:	48 c7 c7 83 9c 10 80 	mov    $0xffffffff80109c83,%rdi
ffffffff80101b46:	e8 e4 ed ff ff       	call   ffffffff8010092f <panic>
  bp->data[bi/8] &= ~m;
ffffffff80101b4b:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80101b4e:	8d 50 07             	lea    0x7(%rax),%edx
ffffffff80101b51:	85 c0                	test   %eax,%eax
ffffffff80101b53:	0f 48 c2             	cmovs  %edx,%eax
ffffffff80101b56:	c1 f8 03             	sar    $0x3,%eax
ffffffff80101b59:	89 c1                	mov    %eax,%ecx
ffffffff80101b5b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80101b5f:	48 63 c1             	movslq %ecx,%rax
ffffffff80101b62:	0f b6 44 02 28       	movzbl 0x28(%rdx,%rax,1),%eax
ffffffff80101b67:	89 c2                	mov    %eax,%edx
ffffffff80101b69:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff80101b6c:	f7 d0                	not    %eax
ffffffff80101b6e:	21 d0                	and    %edx,%eax
ffffffff80101b70:	89 c6                	mov    %eax,%esi
ffffffff80101b72:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80101b76:	48 63 c1             	movslq %ecx,%rax
ffffffff80101b79:	40 88 74 02 28       	mov    %sil,0x28(%rdx,%rax,1)
  log_write(bp);
ffffffff80101b7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101b82:	48 89 c7             	mov    %rax,%rdi
ffffffff80101b85:	e8 5d 1f 00 00       	call   ffffffff80103ae7 <log_write>
  brelse(bp);
ffffffff80101b8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101b8e:	48 89 c7             	mov    %rax,%rdi
ffffffff80101b91:	e8 c6 e7 ff ff       	call   ffffffff8010035c <brelse>
}
ffffffff80101b96:	90                   	nop
ffffffff80101b97:	c9                   	leave
ffffffff80101b98:	c3                   	ret

ffffffff80101b99 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
ffffffff80101b99:	55                   	push   %rbp
ffffffff80101b9a:	48 89 e5             	mov    %rsp,%rbp
  initlock(&icache.lock, "icache");
ffffffff80101b9d:	48 c7 c6 96 9c 10 80 	mov    $0xffffffff80109c96,%rsi
ffffffff80101ba4:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101bab:	e8 fe 3f 00 00       	call   ffffffff80105bae <initlock>
}
ffffffff80101bb0:	90                   	nop
ffffffff80101bb1:	5d                   	pop    %rbp
ffffffff80101bb2:	c3                   	ret

ffffffff80101bb3 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
ffffffff80101bb3:	55                   	push   %rbp
ffffffff80101bb4:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101bb7:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff80101bbb:	89 7d cc             	mov    %edi,-0x34(%rbp)
ffffffff80101bbe:	89 f0                	mov    %esi,%eax
ffffffff80101bc0:	66 89 45 c8          	mov    %ax,-0x38(%rbp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
ffffffff80101bc4:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80101bc7:	48 8d 55 d0          	lea    -0x30(%rbp),%rdx
ffffffff80101bcb:	48 89 d6             	mov    %rdx,%rsi
ffffffff80101bce:	89 c7                	mov    %eax,%edi
ffffffff80101bd0:	e8 ea fc ff ff       	call   ffffffff801018bf <readsb>

  for(inum = 1; inum < sb.ninodes; inum++){
ffffffff80101bd5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
ffffffff80101bdc:	e9 9d 00 00 00       	jmp    ffffffff80101c7e <ialloc+0xcb>
    bp = bread(dev, IBLOCK(inum));
ffffffff80101be1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80101be4:	48 98                	cltq
ffffffff80101be6:	48 c1 e8 03          	shr    $0x3,%rax
ffffffff80101bea:	8d 50 02             	lea    0x2(%rax),%edx
ffffffff80101bed:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80101bf0:	89 d6                	mov    %edx,%esi
ffffffff80101bf2:	89 c7                	mov    %eax,%edi
ffffffff80101bf4:	e8 de e6 ff ff       	call   ffffffff801002d7 <bread>
ffffffff80101bf9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    dip = (struct dinode*)bp->data + inum%IPB;
ffffffff80101bfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101c01:	48 8d 50 28          	lea    0x28(%rax),%rdx
ffffffff80101c05:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80101c08:	48 98                	cltq
ffffffff80101c0a:	83 e0 07             	and    $0x7,%eax
ffffffff80101c0d:	48 c1 e0 06          	shl    $0x6,%rax
ffffffff80101c11:	48 01 d0             	add    %rdx,%rax
ffffffff80101c14:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(dip->type == 0){  // a free inode
ffffffff80101c18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101c1c:	0f b7 00             	movzwl (%rax),%eax
ffffffff80101c1f:	66 85 c0             	test   %ax,%ax
ffffffff80101c22:	75 4a                	jne    ffffffff80101c6e <ialloc+0xbb>
      memset(dip, 0, sizeof(*dip));
ffffffff80101c24:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101c28:	ba 40 00 00 00       	mov    $0x40,%edx
ffffffff80101c2d:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80101c32:	48 89 c7             	mov    %rax,%rdi
ffffffff80101c35:	e8 19 43 00 00       	call   ffffffff80105f53 <memset>
      dip->type = type;
ffffffff80101c3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101c3e:	0f b7 55 c8          	movzwl -0x38(%rbp),%edx
ffffffff80101c42:	66 89 10             	mov    %dx,(%rax)
      log_write(bp);   // mark it allocated on the disk
ffffffff80101c45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101c49:	48 89 c7             	mov    %rax,%rdi
ffffffff80101c4c:	e8 96 1e 00 00       	call   ffffffff80103ae7 <log_write>
      brelse(bp);
ffffffff80101c51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101c55:	48 89 c7             	mov    %rax,%rdi
ffffffff80101c58:	e8 ff e6 ff ff       	call   ffffffff8010035c <brelse>
      return iget(dev, inum);
ffffffff80101c5d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101c60:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80101c63:	89 d6                	mov    %edx,%esi
ffffffff80101c65:	89 c7                	mov    %eax,%edi
ffffffff80101c67:	e8 01 01 00 00       	call   ffffffff80101d6d <iget>
ffffffff80101c6c:	eb 2a                	jmp    ffffffff80101c98 <ialloc+0xe5>
    }
    brelse(bp);
ffffffff80101c6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101c72:	48 89 c7             	mov    %rax,%rdi
ffffffff80101c75:	e8 e2 e6 ff ff       	call   ffffffff8010035c <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
ffffffff80101c7a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80101c7e:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffffffff80101c81:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80101c84:	39 c2                	cmp    %eax,%edx
ffffffff80101c86:	0f 82 55 ff ff ff    	jb     ffffffff80101be1 <ialloc+0x2e>
  }
  panic("ialloc: no inodes");
ffffffff80101c8c:	48 c7 c7 9d 9c 10 80 	mov    $0xffffffff80109c9d,%rdi
ffffffff80101c93:	e8 97 ec ff ff       	call   ffffffff8010092f <panic>
}
ffffffff80101c98:	c9                   	leave
ffffffff80101c99:	c3                   	ret

ffffffff80101c9a <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
ffffffff80101c9a:	55                   	push   %rbp
ffffffff80101c9b:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101c9e:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80101ca2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
ffffffff80101ca6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101caa:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101cad:	c1 e8 03             	shr    $0x3,%eax
ffffffff80101cb0:	8d 50 02             	lea    0x2(%rax),%edx
ffffffff80101cb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101cb7:	8b 00                	mov    (%rax),%eax
ffffffff80101cb9:	89 d6                	mov    %edx,%esi
ffffffff80101cbb:	89 c7                	mov    %eax,%edi
ffffffff80101cbd:	e8 15 e6 ff ff       	call   ffffffff801002d7 <bread>
ffffffff80101cc2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
ffffffff80101cc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101cca:	48 8d 50 28          	lea    0x28(%rax),%rdx
ffffffff80101cce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101cd2:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101cd5:	89 c0                	mov    %eax,%eax
ffffffff80101cd7:	83 e0 07             	and    $0x7,%eax
ffffffff80101cda:	48 c1 e0 06          	shl    $0x6,%rax
ffffffff80101cde:	48 01 d0             	add    %rdx,%rax
ffffffff80101ce1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  dip->type = ip->type;
ffffffff80101ce5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101ce9:	0f b7 50 10          	movzwl 0x10(%rax),%edx
ffffffff80101ced:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101cf1:	66 89 10             	mov    %dx,(%rax)
  dip->major = ip->major;
ffffffff80101cf4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101cf8:	0f b7 50 12          	movzwl 0x12(%rax),%edx
ffffffff80101cfc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101d00:	66 89 50 02          	mov    %dx,0x2(%rax)
  dip->minor = ip->minor;
ffffffff80101d04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d08:	0f b7 50 14          	movzwl 0x14(%rax),%edx
ffffffff80101d0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101d10:	66 89 50 04          	mov    %dx,0x4(%rax)
  dip->nlink = ip->nlink;
ffffffff80101d14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d18:	0f b7 50 16          	movzwl 0x16(%rax),%edx
ffffffff80101d1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101d20:	66 89 50 06          	mov    %dx,0x6(%rax)
  dip->size = ip->size;
ffffffff80101d24:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d28:	8b 50 18             	mov    0x18(%rax),%edx
ffffffff80101d2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101d2f:	89 50 08             	mov    %edx,0x8(%rax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
ffffffff80101d32:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101d36:	48 8d 48 1c          	lea    0x1c(%rax),%rcx
ffffffff80101d3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101d3e:	48 83 c0 0c          	add    $0xc,%rax
ffffffff80101d42:	ba 34 00 00 00       	mov    $0x34,%edx
ffffffff80101d47:	48 89 ce             	mov    %rcx,%rsi
ffffffff80101d4a:	48 89 c7             	mov    %rax,%rdi
ffffffff80101d4d:	e8 f0 42 00 00       	call   ffffffff80106042 <memmove>
  log_write(bp);
ffffffff80101d52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101d56:	48 89 c7             	mov    %rax,%rdi
ffffffff80101d59:	e8 89 1d 00 00       	call   ffffffff80103ae7 <log_write>
  brelse(bp);
ffffffff80101d5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101d62:	48 89 c7             	mov    %rax,%rdi
ffffffff80101d65:	e8 f2 e5 ff ff       	call   ffffffff8010035c <brelse>
}
ffffffff80101d6a:	90                   	nop
ffffffff80101d6b:	c9                   	leave
ffffffff80101d6c:	c3                   	ret

ffffffff80101d6d <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
ffffffff80101d6d:	55                   	push   %rbp
ffffffff80101d6e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101d71:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80101d75:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff80101d78:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
ffffffff80101d7b:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101d82:	e8 5c 3e 00 00       	call   ffffffff80105be3 <acquire>

  // Is the inode already cached?
  empty = 0;
ffffffff80101d87:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffffffff80101d8e:	00 
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffffffff80101d8f:	48 c7 45 f8 c8 ea 10 	movq   $0xffffffff8010eac8,-0x8(%rbp)
ffffffff80101d96:	80 
ffffffff80101d97:	eb 64                	jmp    ffffffff80101dfd <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
ffffffff80101d99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101d9d:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80101da0:	85 c0                	test   %eax,%eax
ffffffff80101da2:	7e 3a                	jle    ffffffff80101dde <iget+0x71>
ffffffff80101da4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101da8:	8b 00                	mov    (%rax),%eax
ffffffff80101daa:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffffffff80101dad:	75 2f                	jne    ffffffff80101dde <iget+0x71>
ffffffff80101daf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101db3:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101db6:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffffffff80101db9:	75 23                	jne    ffffffff80101dde <iget+0x71>
      ip->ref++;
ffffffff80101dbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101dbf:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80101dc2:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80101dc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101dc9:	89 50 08             	mov    %edx,0x8(%rax)
      release(&icache.lock);
ffffffff80101dcc:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101dd3:	e8 e2 3e 00 00       	call   ffffffff80105cba <release>
      return ip;
ffffffff80101dd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101ddc:	eb 7d                	jmp    ffffffff80101e5b <iget+0xee>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
ffffffff80101dde:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80101de3:	75 13                	jne    ffffffff80101df8 <iget+0x8b>
ffffffff80101de5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101de9:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80101dec:	85 c0                	test   %eax,%eax
ffffffff80101dee:	75 08                	jne    ffffffff80101df8 <iget+0x8b>
      empty = ip;
ffffffff80101df0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101df4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffffffff80101df8:	48 83 45 f8 50       	addq   $0x50,-0x8(%rbp)
ffffffff80101dfd:	48 81 7d f8 68 fa 10 	cmpq   $0xffffffff8010fa68,-0x8(%rbp)
ffffffff80101e04:	80 
ffffffff80101e05:	72 92                	jb     ffffffff80101d99 <iget+0x2c>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
ffffffff80101e07:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80101e0c:	75 0c                	jne    ffffffff80101e1a <iget+0xad>
    panic("iget: no inodes");
ffffffff80101e0e:	48 c7 c7 af 9c 10 80 	mov    $0xffffffff80109caf,%rdi
ffffffff80101e15:	e8 15 eb ff ff       	call   ffffffff8010092f <panic>

  ip = empty;
ffffffff80101e1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101e1e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  ip->dev = dev;
ffffffff80101e22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e26:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80101e29:	89 10                	mov    %edx,(%rax)
  ip->inum = inum;
ffffffff80101e2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e2f:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff80101e32:	89 50 04             	mov    %edx,0x4(%rax)
  ip->ref = 1;
ffffffff80101e35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e39:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  ip->flags = 0;
ffffffff80101e40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e44:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%rax)
  release(&icache.lock);
ffffffff80101e4b:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101e52:	e8 63 3e 00 00       	call   ffffffff80105cba <release>

  return ip;
ffffffff80101e57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80101e5b:	c9                   	leave
ffffffff80101e5c:	c3                   	ret

ffffffff80101e5d <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
ffffffff80101e5d:	55                   	push   %rbp
ffffffff80101e5e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101e61:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80101e65:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffffffff80101e69:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101e70:	e8 6e 3d 00 00       	call   ffffffff80105be3 <acquire>
  ip->ref++;
ffffffff80101e75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e79:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80101e7c:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80101e7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101e83:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffffffff80101e86:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101e8d:	e8 28 3e 00 00       	call   ffffffff80105cba <release>
  return ip;
ffffffff80101e92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80101e96:	c9                   	leave
ffffffff80101e97:	c3                   	ret

ffffffff80101e98 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
ffffffff80101e98:	55                   	push   %rbp
ffffffff80101e99:	48 89 e5             	mov    %rsp,%rbp
ffffffff80101e9c:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80101ea0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
ffffffff80101ea4:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80101ea9:	74 0b                	je     ffffffff80101eb6 <ilock+0x1e>
ffffffff80101eab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101eaf:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80101eb2:	85 c0                	test   %eax,%eax
ffffffff80101eb4:	7f 0c                	jg     ffffffff80101ec2 <ilock+0x2a>
    panic("ilock");
ffffffff80101eb6:	48 c7 c7 bf 9c 10 80 	mov    $0xffffffff80109cbf,%rdi
ffffffff80101ebd:	e8 6d ea ff ff       	call   ffffffff8010092f <panic>

  acquire(&icache.lock);
ffffffff80101ec2:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101ec9:	e8 15 3d 00 00       	call   ffffffff80105be3 <acquire>
  while(ip->flags & I_BUSY)
ffffffff80101ece:	eb 13                	jmp    ffffffff80101ee3 <ilock+0x4b>
    sleep(ip, &icache.lock);
ffffffff80101ed0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101ed4:	48 c7 c6 60 ea 10 80 	mov    $0xffffffff8010ea60,%rsi
ffffffff80101edb:	48 89 c7             	mov    %rax,%rdi
ffffffff80101ede:	e8 7c 39 00 00       	call   ffffffff8010585f <sleep>
  while(ip->flags & I_BUSY)
ffffffff80101ee3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101ee7:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80101eea:	83 e0 01             	and    $0x1,%eax
ffffffff80101eed:	85 c0                	test   %eax,%eax
ffffffff80101eef:	75 df                	jne    ffffffff80101ed0 <ilock+0x38>
  ip->flags |= I_BUSY;
ffffffff80101ef1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101ef5:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80101ef8:	83 c8 01             	or     $0x1,%eax
ffffffff80101efb:	89 c2                	mov    %eax,%edx
ffffffff80101efd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f01:	89 50 0c             	mov    %edx,0xc(%rax)
  release(&icache.lock);
ffffffff80101f04:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80101f0b:	e8 aa 3d 00 00       	call   ffffffff80105cba <release>

  if(!(ip->flags & I_VALID)){
ffffffff80101f10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f14:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80101f17:	83 e0 02             	and    $0x2,%eax
ffffffff80101f1a:	85 c0                	test   %eax,%eax
ffffffff80101f1c:	0f 85 e4 00 00 00    	jne    ffffffff80102006 <ilock+0x16e>
    bp = bread(ip->dev, IBLOCK(ip->inum));
ffffffff80101f22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f26:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101f29:	c1 e8 03             	shr    $0x3,%eax
ffffffff80101f2c:	8d 50 02             	lea    0x2(%rax),%edx
ffffffff80101f2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f33:	8b 00                	mov    (%rax),%eax
ffffffff80101f35:	89 d6                	mov    %edx,%esi
ffffffff80101f37:	89 c7                	mov    %eax,%edi
ffffffff80101f39:	e8 99 e3 ff ff       	call   ffffffff801002d7 <bread>
ffffffff80101f3e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
ffffffff80101f42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101f46:	48 8d 50 28          	lea    0x28(%rax),%rdx
ffffffff80101f4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f4e:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80101f51:	89 c0                	mov    %eax,%eax
ffffffff80101f53:	83 e0 07             	and    $0x7,%eax
ffffffff80101f56:	48 c1 e0 06          	shl    $0x6,%rax
ffffffff80101f5a:	48 01 d0             	add    %rdx,%rax
ffffffff80101f5d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    ip->type = dip->type;
ffffffff80101f61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101f65:	0f b7 10             	movzwl (%rax),%edx
ffffffff80101f68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f6c:	66 89 50 10          	mov    %dx,0x10(%rax)
    ip->major = dip->major;
ffffffff80101f70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101f74:	0f b7 50 02          	movzwl 0x2(%rax),%edx
ffffffff80101f78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f7c:	66 89 50 12          	mov    %dx,0x12(%rax)
    ip->minor = dip->minor;
ffffffff80101f80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101f84:	0f b7 50 04          	movzwl 0x4(%rax),%edx
ffffffff80101f88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f8c:	66 89 50 14          	mov    %dx,0x14(%rax)
    ip->nlink = dip->nlink;
ffffffff80101f90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101f94:	0f b7 50 06          	movzwl 0x6(%rax),%edx
ffffffff80101f98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101f9c:	66 89 50 16          	mov    %dx,0x16(%rax)
    ip->size = dip->size;
ffffffff80101fa0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101fa4:	8b 50 08             	mov    0x8(%rax),%edx
ffffffff80101fa7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101fab:	89 50 18             	mov    %edx,0x18(%rax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
ffffffff80101fae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80101fb2:	48 8d 48 0c          	lea    0xc(%rax),%rcx
ffffffff80101fb6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101fba:	48 83 c0 1c          	add    $0x1c,%rax
ffffffff80101fbe:	ba 34 00 00 00       	mov    $0x34,%edx
ffffffff80101fc3:	48 89 ce             	mov    %rcx,%rsi
ffffffff80101fc6:	48 89 c7             	mov    %rax,%rdi
ffffffff80101fc9:	e8 74 40 00 00       	call   ffffffff80106042 <memmove>
    brelse(bp);
ffffffff80101fce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80101fd2:	48 89 c7             	mov    %rax,%rdi
ffffffff80101fd5:	e8 82 e3 ff ff       	call   ffffffff8010035c <brelse>
    ip->flags |= I_VALID;
ffffffff80101fda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101fde:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80101fe1:	83 c8 02             	or     $0x2,%eax
ffffffff80101fe4:	89 c2                	mov    %eax,%edx
ffffffff80101fe6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101fea:	89 50 0c             	mov    %edx,0xc(%rax)
    if(ip->type == 0)
ffffffff80101fed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80101ff1:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80101ff5:	66 85 c0             	test   %ax,%ax
ffffffff80101ff8:	75 0c                	jne    ffffffff80102006 <ilock+0x16e>
      panic("ilock: no type");
ffffffff80101ffa:	48 c7 c7 c5 9c 10 80 	mov    $0xffffffff80109cc5,%rdi
ffffffff80102001:	e8 29 e9 ff ff       	call   ffffffff8010092f <panic>
  }
}
ffffffff80102006:	90                   	nop
ffffffff80102007:	c9                   	leave
ffffffff80102008:	c3                   	ret

ffffffff80102009 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
ffffffff80102009:	55                   	push   %rbp
ffffffff8010200a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010200d:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102011:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
ffffffff80102015:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff8010201a:	74 19                	je     ffffffff80102035 <iunlock+0x2c>
ffffffff8010201c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102020:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80102023:	83 e0 01             	and    $0x1,%eax
ffffffff80102026:	85 c0                	test   %eax,%eax
ffffffff80102028:	74 0b                	je     ffffffff80102035 <iunlock+0x2c>
ffffffff8010202a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010202e:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102031:	85 c0                	test   %eax,%eax
ffffffff80102033:	7f 0c                	jg     ffffffff80102041 <iunlock+0x38>
    panic("iunlock");
ffffffff80102035:	48 c7 c7 d4 9c 10 80 	mov    $0xffffffff80109cd4,%rdi
ffffffff8010203c:	e8 ee e8 ff ff       	call   ffffffff8010092f <panic>

  acquire(&icache.lock);
ffffffff80102041:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80102048:	e8 96 3b 00 00       	call   ffffffff80105be3 <acquire>
  ip->flags &= ~I_BUSY;
ffffffff8010204d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102051:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff80102054:	83 e0 fe             	and    $0xfffffffe,%eax
ffffffff80102057:	89 c2                	mov    %eax,%edx
ffffffff80102059:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010205d:	89 50 0c             	mov    %edx,0xc(%rax)
  wakeup(ip);
ffffffff80102060:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102064:	48 89 c7             	mov    %rax,%rdi
ffffffff80102067:	e8 07 39 00 00       	call   ffffffff80105973 <wakeup>
  release(&icache.lock);
ffffffff8010206c:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80102073:	e8 42 3c 00 00       	call   ffffffff80105cba <release>
}
ffffffff80102078:	90                   	nop
ffffffff80102079:	c9                   	leave
ffffffff8010207a:	c3                   	ret

ffffffff8010207b <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
ffffffff8010207b:	55                   	push   %rbp
ffffffff8010207c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010207f:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102083:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffffffff80102087:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff8010208e:	e8 50 3b 00 00       	call   ffffffff80105be3 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
ffffffff80102093:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102097:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff8010209a:	83 f8 01             	cmp    $0x1,%eax
ffffffff8010209d:	0f 85 9d 00 00 00    	jne    ffffffff80102140 <iput+0xc5>
ffffffff801020a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020a7:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff801020aa:	83 e0 02             	and    $0x2,%eax
ffffffff801020ad:	85 c0                	test   %eax,%eax
ffffffff801020af:	0f 84 8b 00 00 00    	je     ffffffff80102140 <iput+0xc5>
ffffffff801020b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020b9:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff801020bd:	66 85 c0             	test   %ax,%ax
ffffffff801020c0:	75 7e                	jne    ffffffff80102140 <iput+0xc5>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
ffffffff801020c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020c6:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff801020c9:	83 e0 01             	and    $0x1,%eax
ffffffff801020cc:	85 c0                	test   %eax,%eax
ffffffff801020ce:	74 0c                	je     ffffffff801020dc <iput+0x61>
      panic("iput busy");
ffffffff801020d0:	48 c7 c7 dc 9c 10 80 	mov    $0xffffffff80109cdc,%rdi
ffffffff801020d7:	e8 53 e8 ff ff       	call   ffffffff8010092f <panic>
    ip->flags |= I_BUSY;
ffffffff801020dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020e0:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff801020e3:	83 c8 01             	or     $0x1,%eax
ffffffff801020e6:	89 c2                	mov    %eax,%edx
ffffffff801020e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020ec:	89 50 0c             	mov    %edx,0xc(%rax)
    release(&icache.lock);
ffffffff801020ef:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff801020f6:	e8 bf 3b 00 00       	call   ffffffff80105cba <release>
    itrunc(ip);
ffffffff801020fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801020ff:	48 89 c7             	mov    %rax,%rdi
ffffffff80102102:	e8 a0 01 00 00       	call   ffffffff801022a7 <itrunc>
    ip->type = 0;
ffffffff80102107:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010210b:	66 c7 40 10 00 00    	movw   $0x0,0x10(%rax)
    iupdate(ip);
ffffffff80102111:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102115:	48 89 c7             	mov    %rax,%rdi
ffffffff80102118:	e8 7d fb ff ff       	call   ffffffff80101c9a <iupdate>
    acquire(&icache.lock);
ffffffff8010211d:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80102124:	e8 ba 3a 00 00       	call   ffffffff80105be3 <acquire>
    ip->flags = 0;
ffffffff80102129:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010212d:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%rax)
    wakeup(ip);
ffffffff80102134:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102138:	48 89 c7             	mov    %rax,%rdi
ffffffff8010213b:	e8 33 38 00 00       	call   ffffffff80105973 <wakeup>
  }
  ip->ref--;
ffffffff80102140:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102144:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102147:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff8010214a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010214e:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffffffff80102151:	48 c7 c7 60 ea 10 80 	mov    $0xffffffff8010ea60,%rdi
ffffffff80102158:	e8 5d 3b 00 00       	call   ffffffff80105cba <release>
}
ffffffff8010215d:	90                   	nop
ffffffff8010215e:	c9                   	leave
ffffffff8010215f:	c3                   	ret

ffffffff80102160 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
ffffffff80102160:	55                   	push   %rbp
ffffffff80102161:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102164:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102168:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  iunlock(ip);
ffffffff8010216c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102170:	48 89 c7             	mov    %rax,%rdi
ffffffff80102173:	e8 91 fe ff ff       	call   ffffffff80102009 <iunlock>
  iput(ip);
ffffffff80102178:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010217c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010217f:	e8 f7 fe ff ff       	call   ffffffff8010207b <iput>
}
ffffffff80102184:	90                   	nop
ffffffff80102185:	c9                   	leave
ffffffff80102186:	c3                   	ret

ffffffff80102187 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
ffffffff80102187:	55                   	push   %rbp
ffffffff80102188:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010218b:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff8010218f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff80102193:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
ffffffff80102196:	83 7d d4 0b          	cmpl   $0xb,-0x2c(%rbp)
ffffffff8010219a:	77 42                	ja     ffffffff801021de <bmap+0x57>
    if((addr = ip->addrs[bn]) == 0)
ffffffff8010219c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801021a0:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffffffff801021a3:	48 83 c2 04          	add    $0x4,%rdx
ffffffff801021a7:	8b 44 90 0c          	mov    0xc(%rax,%rdx,4),%eax
ffffffff801021ab:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff801021ae:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801021b2:	75 22                	jne    ffffffff801021d6 <bmap+0x4f>
      ip->addrs[bn] = addr = balloc(ip->dev);
ffffffff801021b4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801021b8:	8b 00                	mov    (%rax),%eax
ffffffff801021ba:	89 c7                	mov    %eax,%edi
ffffffff801021bc:	e8 a1 f7 ff ff       	call   ffffffff80101962 <balloc>
ffffffff801021c1:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff801021c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801021c8:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffffffff801021cb:	48 8d 4a 04          	lea    0x4(%rdx),%rcx
ffffffff801021cf:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801021d2:	89 54 88 0c          	mov    %edx,0xc(%rax,%rcx,4)
    return addr;
ffffffff801021d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801021d9:	e9 c7 00 00 00       	jmp    ffffffff801022a5 <bmap+0x11e>
  }
  bn -= NDIRECT;
ffffffff801021de:	83 6d d4 0c          	subl   $0xc,-0x2c(%rbp)

  if(bn < NINDIRECT){
ffffffff801021e2:	83 7d d4 7f          	cmpl   $0x7f,-0x2c(%rbp)
ffffffff801021e6:	0f 87 ad 00 00 00    	ja     ffffffff80102299 <bmap+0x112>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
ffffffff801021ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801021f0:	8b 40 4c             	mov    0x4c(%rax),%eax
ffffffff801021f3:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff801021f6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801021fa:	75 1a                	jne    ffffffff80102216 <bmap+0x8f>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
ffffffff801021fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102200:	8b 00                	mov    (%rax),%eax
ffffffff80102202:	89 c7                	mov    %eax,%edi
ffffffff80102204:	e8 59 f7 ff ff       	call   ffffffff80101962 <balloc>
ffffffff80102209:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff8010220c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102210:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102213:	89 50 4c             	mov    %edx,0x4c(%rax)
    bp = bread(ip->dev, addr);
ffffffff80102216:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010221a:	8b 00                	mov    (%rax),%eax
ffffffff8010221c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010221f:	89 d6                	mov    %edx,%esi
ffffffff80102221:	89 c7                	mov    %eax,%edi
ffffffff80102223:	e8 af e0 ff ff       	call   ffffffff801002d7 <bread>
ffffffff80102228:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffffffff8010222c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102230:	48 83 c0 28          	add    $0x28,%rax
ffffffff80102234:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if((addr = a[bn]) == 0){
ffffffff80102238:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffffffff8010223b:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff80102242:	00 
ffffffff80102243:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102247:	48 01 d0             	add    %rdx,%rax
ffffffff8010224a:	8b 00                	mov    (%rax),%eax
ffffffff8010224c:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff8010224f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80102253:	75 33                	jne    ffffffff80102288 <bmap+0x101>
      a[bn] = addr = balloc(ip->dev);
ffffffff80102255:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102259:	8b 00                	mov    (%rax),%eax
ffffffff8010225b:	89 c7                	mov    %eax,%edi
ffffffff8010225d:	e8 00 f7 ff ff       	call   ffffffff80101962 <balloc>
ffffffff80102262:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80102265:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffffffff80102268:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff8010226f:	00 
ffffffff80102270:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102274:	48 01 c2             	add    %rax,%rdx
ffffffff80102277:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010227a:	89 02                	mov    %eax,(%rdx)
      log_write(bp);
ffffffff8010227c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102280:	48 89 c7             	mov    %rax,%rdi
ffffffff80102283:	e8 5f 18 00 00       	call   ffffffff80103ae7 <log_write>
    }
    brelse(bp);
ffffffff80102288:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010228c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010228f:	e8 c8 e0 ff ff       	call   ffffffff8010035c <brelse>
    return addr;
ffffffff80102294:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80102297:	eb 0c                	jmp    ffffffff801022a5 <bmap+0x11e>
  }

  panic("bmap: out of range");
ffffffff80102299:	48 c7 c7 e6 9c 10 80 	mov    $0xffffffff80109ce6,%rdi
ffffffff801022a0:	e8 8a e6 ff ff       	call   ffffffff8010092f <panic>
}
ffffffff801022a5:	c9                   	leave
ffffffff801022a6:	c3                   	ret

ffffffff801022a7 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
ffffffff801022a7:	55                   	push   %rbp
ffffffff801022a8:	48 89 e5             	mov    %rsp,%rbp
ffffffff801022ab:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff801022af:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
ffffffff801022b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801022ba:	eb 51                	jmp    ffffffff8010230d <itrunc+0x66>
    if(ip->addrs[i]){
ffffffff801022bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801022c0:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801022c3:	48 63 d2             	movslq %edx,%rdx
ffffffff801022c6:	48 83 c2 04          	add    $0x4,%rdx
ffffffff801022ca:	8b 44 90 0c          	mov    0xc(%rax,%rdx,4),%eax
ffffffff801022ce:	85 c0                	test   %eax,%eax
ffffffff801022d0:	74 37                	je     ffffffff80102309 <itrunc+0x62>
      bfree(ip->dev, ip->addrs[i]);
ffffffff801022d2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801022d6:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801022d9:	48 63 d2             	movslq %edx,%rdx
ffffffff801022dc:	48 83 c2 04          	add    $0x4,%rdx
ffffffff801022e0:	8b 44 90 0c          	mov    0xc(%rax,%rdx,4),%eax
ffffffff801022e4:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffffffff801022e8:	8b 12                	mov    (%rdx),%edx
ffffffff801022ea:	89 c6                	mov    %eax,%esi
ffffffff801022ec:	89 d7                	mov    %edx,%edi
ffffffff801022ee:	e8 c8 f7 ff ff       	call   ffffffff80101abb <bfree>
      ip->addrs[i] = 0;
ffffffff801022f3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801022f7:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801022fa:	48 63 d2             	movslq %edx,%rdx
ffffffff801022fd:	48 83 c2 04          	add    $0x4,%rdx
ffffffff80102301:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%rax,%rdx,4)
ffffffff80102308:	00 
  for(i = 0; i < NDIRECT; i++){
ffffffff80102309:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff8010230d:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
ffffffff80102311:	7e a9                	jle    ffffffff801022bc <itrunc+0x15>
    }
  }
  
  if(ip->addrs[NDIRECT]){
ffffffff80102313:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102317:	8b 40 4c             	mov    0x4c(%rax),%eax
ffffffff8010231a:	85 c0                	test   %eax,%eax
ffffffff8010231c:	0f 84 a7 00 00 00    	je     ffffffff801023c9 <itrunc+0x122>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
ffffffff80102322:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102326:	8b 50 4c             	mov    0x4c(%rax),%edx
ffffffff80102329:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010232d:	8b 00                	mov    (%rax),%eax
ffffffff8010232f:	89 d6                	mov    %edx,%esi
ffffffff80102331:	89 c7                	mov    %eax,%edi
ffffffff80102333:	e8 9f df ff ff       	call   ffffffff801002d7 <bread>
ffffffff80102338:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffffffff8010233c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102340:	48 83 c0 28          	add    $0x28,%rax
ffffffff80102344:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for(j = 0; j < NINDIRECT; j++){
ffffffff80102348:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffffffff8010234f:	eb 43                	jmp    ffffffff80102394 <itrunc+0xed>
      if(a[j])
ffffffff80102351:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80102354:	48 98                	cltq
ffffffff80102356:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff8010235d:	00 
ffffffff8010235e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102362:	48 01 d0             	add    %rdx,%rax
ffffffff80102365:	8b 00                	mov    (%rax),%eax
ffffffff80102367:	85 c0                	test   %eax,%eax
ffffffff80102369:	74 25                	je     ffffffff80102390 <itrunc+0xe9>
        bfree(ip->dev, a[j]);
ffffffff8010236b:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff8010236e:	48 98                	cltq
ffffffff80102370:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff80102377:	00 
ffffffff80102378:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010237c:	48 01 d0             	add    %rdx,%rax
ffffffff8010237f:	8b 00                	mov    (%rax),%eax
ffffffff80102381:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffffffff80102385:	8b 12                	mov    (%rdx),%edx
ffffffff80102387:	89 c6                	mov    %eax,%esi
ffffffff80102389:	89 d7                	mov    %edx,%edi
ffffffff8010238b:	e8 2b f7 ff ff       	call   ffffffff80101abb <bfree>
    for(j = 0; j < NINDIRECT; j++){
ffffffff80102390:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffffffff80102394:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80102397:	83 f8 7f             	cmp    $0x7f,%eax
ffffffff8010239a:	76 b5                	jbe    ffffffff80102351 <itrunc+0xaa>
    }
    brelse(bp);
ffffffff8010239c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801023a0:	48 89 c7             	mov    %rax,%rdi
ffffffff801023a3:	e8 b4 df ff ff       	call   ffffffff8010035c <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
ffffffff801023a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801023ac:	8b 40 4c             	mov    0x4c(%rax),%eax
ffffffff801023af:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffffffff801023b3:	8b 12                	mov    (%rdx),%edx
ffffffff801023b5:	89 c6                	mov    %eax,%esi
ffffffff801023b7:	89 d7                	mov    %edx,%edi
ffffffff801023b9:	e8 fd f6 ff ff       	call   ffffffff80101abb <bfree>
    ip->addrs[NDIRECT] = 0;
ffffffff801023be:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801023c2:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%rax)
  }

  ip->size = 0;
ffffffff801023c9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801023cd:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
  iupdate(ip);
ffffffff801023d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801023d8:	48 89 c7             	mov    %rax,%rdi
ffffffff801023db:	e8 ba f8 ff ff       	call   ffffffff80101c9a <iupdate>
}
ffffffff801023e0:	90                   	nop
ffffffff801023e1:	c9                   	leave
ffffffff801023e2:	c3                   	ret

ffffffff801023e3 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
ffffffff801023e3:	55                   	push   %rbp
ffffffff801023e4:	48 89 e5             	mov    %rsp,%rbp
ffffffff801023e7:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff801023eb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801023ef:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  st->dev = ip->dev;
ffffffff801023f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801023f7:	8b 00                	mov    (%rax),%eax
ffffffff801023f9:	89 c2                	mov    %eax,%edx
ffffffff801023fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801023ff:	89 50 04             	mov    %edx,0x4(%rax)
  st->ino = ip->inum;
ffffffff80102402:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102406:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff80102409:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010240d:	89 50 08             	mov    %edx,0x8(%rax)
  st->type = ip->type;
ffffffff80102410:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102414:	0f b7 50 10          	movzwl 0x10(%rax),%edx
ffffffff80102418:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010241c:	66 89 10             	mov    %dx,(%rax)
  st->nlink = ip->nlink;
ffffffff8010241f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102423:	0f b7 50 16          	movzwl 0x16(%rax),%edx
ffffffff80102427:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010242b:	66 89 50 0c          	mov    %dx,0xc(%rax)
  st->size = ip->size;
ffffffff8010242f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102433:	8b 50 18             	mov    0x18(%rax),%edx
ffffffff80102436:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010243a:	89 50 10             	mov    %edx,0x10(%rax)
}
ffffffff8010243d:	90                   	nop
ffffffff8010243e:	c9                   	leave
ffffffff8010243f:	c3                   	ret

ffffffff80102440 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
ffffffff80102440:	55                   	push   %rbp
ffffffff80102441:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102444:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff80102448:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff8010244c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff80102450:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffffffff80102453:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffffffff80102456:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010245a:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff8010245e:	66 83 f8 03          	cmp    $0x3,%ax
ffffffff80102462:	75 73                	jne    ffffffff801024d7 <readi+0x97>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
ffffffff80102464:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102468:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff8010246c:	66 85 c0             	test   %ax,%ax
ffffffff8010246f:	78 2b                	js     ffffffff8010249c <readi+0x5c>
ffffffff80102471:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102475:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff80102479:	66 83 f8 09          	cmp    $0x9,%ax
ffffffff8010247d:	7f 1d                	jg     ffffffff8010249c <readi+0x5c>
ffffffff8010247f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102483:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff80102487:	98                   	cwtl
ffffffff80102488:	48 98                	cltq
ffffffff8010248a:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff8010248e:	48 05 a0 d9 10 80    	add    $0xffffffff8010d9a0,%rax
ffffffff80102494:	48 8b 00             	mov    (%rax),%rax
ffffffff80102497:	48 85 c0             	test   %rax,%rax
ffffffff8010249a:	75 0a                	jne    ffffffff801024a6 <readi+0x66>
      return -1;
ffffffff8010249c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801024a1:	e9 1c 01 00 00       	jmp    ffffffff801025c2 <readi+0x182>
    return devsw[ip->major].read(ip, dst, n);
ffffffff801024a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801024aa:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff801024ae:	98                   	cwtl
ffffffff801024af:	48 98                	cltq
ffffffff801024b1:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801024b5:	48 05 a0 d9 10 80    	add    $0xffffffff8010d9a0,%rax
ffffffff801024bb:	4c 8b 00             	mov    (%rax),%r8
ffffffff801024be:	8b 55 c8             	mov    -0x38(%rbp),%edx
ffffffff801024c1:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffffffff801024c5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801024c9:	48 89 ce             	mov    %rcx,%rsi
ffffffff801024cc:	48 89 c7             	mov    %rax,%rdi
ffffffff801024cf:	41 ff d0             	call   *%r8
ffffffff801024d2:	e9 eb 00 00 00       	jmp    ffffffff801025c2 <readi+0x182>
  }

  if(off > ip->size || off + n < off)
ffffffff801024d7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801024db:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff801024de:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffffffff801024e1:	72 0d                	jb     ffffffff801024f0 <readi+0xb0>
ffffffff801024e3:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffffffff801024e6:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff801024e9:	01 d0                	add    %edx,%eax
ffffffff801024eb:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffffffff801024ee:	73 0a                	jae    ffffffff801024fa <readi+0xba>
    return -1;
ffffffff801024f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801024f5:	e9 c8 00 00 00       	jmp    ffffffff801025c2 <readi+0x182>
  if(off + n > ip->size)
ffffffff801024fa:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffffffff801024fd:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff80102500:	01 c2                	add    %eax,%edx
ffffffff80102502:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102506:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80102509:	39 d0                	cmp    %edx,%eax
ffffffff8010250b:	73 0d                	jae    ffffffff8010251a <readi+0xda>
    n = ip->size - off;
ffffffff8010250d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102511:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80102514:	2b 45 cc             	sub    -0x34(%rbp),%eax
ffffffff80102517:	89 45 c8             	mov    %eax,-0x38(%rbp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffffffff8010251a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80102521:	e9 8d 00 00 00       	jmp    ffffffff801025b3 <readi+0x173>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffffffff80102526:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80102529:	c1 e8 09             	shr    $0x9,%eax
ffffffff8010252c:	89 c2                	mov    %eax,%edx
ffffffff8010252e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102532:	89 d6                	mov    %edx,%esi
ffffffff80102534:	48 89 c7             	mov    %rax,%rdi
ffffffff80102537:	e8 4b fc ff ff       	call   ffffffff80102187 <bmap>
ffffffff8010253c:	89 c2                	mov    %eax,%edx
ffffffff8010253e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102542:	8b 00                	mov    (%rax),%eax
ffffffff80102544:	89 d6                	mov    %edx,%esi
ffffffff80102546:	89 c7                	mov    %eax,%edi
ffffffff80102548:	e8 8a dd ff ff       	call   ffffffff801002d7 <bread>
ffffffff8010254d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffffffff80102551:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80102554:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff80102559:	ba 00 02 00 00       	mov    $0x200,%edx
ffffffff8010255e:	29 c2                	sub    %eax,%edx
ffffffff80102560:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff80102563:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffffffff80102566:	39 c2                	cmp    %eax,%edx
ffffffff80102568:	0f 46 c2             	cmovbe %edx,%eax
ffffffff8010256b:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(dst, bp->data + off%BSIZE, m);
ffffffff8010256e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102572:	48 8d 50 28          	lea    0x28(%rax),%rdx
ffffffff80102576:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80102579:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff8010257e:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffffffff80102582:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80102585:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80102589:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010258c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010258f:	e8 ae 3a 00 00       	call   ffffffff80106042 <memmove>
    brelse(bp);
ffffffff80102594:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102598:	48 89 c7             	mov    %rax,%rdi
ffffffff8010259b:	e8 bc dd ff ff       	call   ffffffff8010035c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffffffff801025a0:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801025a3:	01 45 fc             	add    %eax,-0x4(%rbp)
ffffffff801025a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801025a9:	01 45 cc             	add    %eax,-0x34(%rbp)
ffffffff801025ac:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801025af:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffffffff801025b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801025b6:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffffffff801025b9:	0f 82 67 ff ff ff    	jb     ffffffff80102526 <readi+0xe6>
  }
  return n;
ffffffff801025bf:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffffffff801025c2:	c9                   	leave
ffffffff801025c3:	c3                   	ret

ffffffff801025c4 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
ffffffff801025c4:	55                   	push   %rbp
ffffffff801025c5:	48 89 e5             	mov    %rsp,%rbp
ffffffff801025c8:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff801025cc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff801025d0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff801025d4:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffffffff801025d7:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffffffff801025da:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801025de:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff801025e2:	66 83 f8 03          	cmp    $0x3,%ax
ffffffff801025e6:	75 73                	jne    ffffffff8010265b <writei+0x97>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
ffffffff801025e8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801025ec:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff801025f0:	66 85 c0             	test   %ax,%ax
ffffffff801025f3:	78 2b                	js     ffffffff80102620 <writei+0x5c>
ffffffff801025f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801025f9:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff801025fd:	66 83 f8 09          	cmp    $0x9,%ax
ffffffff80102601:	7f 1d                	jg     ffffffff80102620 <writei+0x5c>
ffffffff80102603:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102607:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff8010260b:	98                   	cwtl
ffffffff8010260c:	48 98                	cltq
ffffffff8010260e:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80102612:	48 05 a8 d9 10 80    	add    $0xffffffff8010d9a8,%rax
ffffffff80102618:	48 8b 00             	mov    (%rax),%rax
ffffffff8010261b:	48 85 c0             	test   %rax,%rax
ffffffff8010261e:	75 0a                	jne    ffffffff8010262a <writei+0x66>
      return -1;
ffffffff80102620:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80102625:	e9 49 01 00 00       	jmp    ffffffff80102773 <writei+0x1af>
    return devsw[ip->major].write(ip, src, n);
ffffffff8010262a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010262e:	0f b7 40 12          	movzwl 0x12(%rax),%eax
ffffffff80102632:	98                   	cwtl
ffffffff80102633:	48 98                	cltq
ffffffff80102635:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80102639:	48 05 a8 d9 10 80    	add    $0xffffffff8010d9a8,%rax
ffffffff8010263f:	4c 8b 00             	mov    (%rax),%r8
ffffffff80102642:	8b 55 c8             	mov    -0x38(%rbp),%edx
ffffffff80102645:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffffffff80102649:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010264d:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102650:	48 89 c7             	mov    %rax,%rdi
ffffffff80102653:	41 ff d0             	call   *%r8
ffffffff80102656:	e9 18 01 00 00       	jmp    ffffffff80102773 <writei+0x1af>
  }

  if(off > ip->size || off + n < off)
ffffffff8010265b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010265f:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80102662:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffffffff80102665:	72 0d                	jb     ffffffff80102674 <writei+0xb0>
ffffffff80102667:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffffffff8010266a:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff8010266d:	01 d0                	add    %edx,%eax
ffffffff8010266f:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffffffff80102672:	73 0a                	jae    ffffffff8010267e <writei+0xba>
    return -1;
ffffffff80102674:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80102679:	e9 f5 00 00 00       	jmp    ffffffff80102773 <writei+0x1af>
  if(off + n > MAXFILE*BSIZE)
ffffffff8010267e:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffffffff80102681:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff80102684:	01 d0                	add    %edx,%eax
ffffffff80102686:	3d 00 18 01 00       	cmp    $0x11800,%eax
ffffffff8010268b:	76 0a                	jbe    ffffffff80102697 <writei+0xd3>
    return -1;
ffffffff8010268d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80102692:	e9 dc 00 00 00       	jmp    ffffffff80102773 <writei+0x1af>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffffffff80102697:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff8010269e:	e9 99 00 00 00       	jmp    ffffffff8010273c <writei+0x178>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffffffff801026a3:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff801026a6:	c1 e8 09             	shr    $0x9,%eax
ffffffff801026a9:	89 c2                	mov    %eax,%edx
ffffffff801026ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801026af:	89 d6                	mov    %edx,%esi
ffffffff801026b1:	48 89 c7             	mov    %rax,%rdi
ffffffff801026b4:	e8 ce fa ff ff       	call   ffffffff80102187 <bmap>
ffffffff801026b9:	89 c2                	mov    %eax,%edx
ffffffff801026bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801026bf:	8b 00                	mov    (%rax),%eax
ffffffff801026c1:	89 d6                	mov    %edx,%esi
ffffffff801026c3:	89 c7                	mov    %eax,%edi
ffffffff801026c5:	e8 0d dc ff ff       	call   ffffffff801002d7 <bread>
ffffffff801026ca:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffffffff801026ce:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff801026d1:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff801026d6:	ba 00 02 00 00       	mov    $0x200,%edx
ffffffff801026db:	29 c2                	sub    %eax,%edx
ffffffff801026dd:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffffffff801026e0:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffffffff801026e3:	39 c2                	cmp    %eax,%edx
ffffffff801026e5:	0f 46 c2             	cmovbe %edx,%eax
ffffffff801026e8:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(bp->data + off%BSIZE, src, m);
ffffffff801026eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801026ef:	48 8d 50 28          	lea    0x28(%rax),%rdx
ffffffff801026f3:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff801026f6:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff801026fb:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffffffff801026ff:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80102702:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80102706:	48 89 c6             	mov    %rax,%rsi
ffffffff80102709:	48 89 cf             	mov    %rcx,%rdi
ffffffff8010270c:	e8 31 39 00 00       	call   ffffffff80106042 <memmove>
    log_write(bp);
ffffffff80102711:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102715:	48 89 c7             	mov    %rax,%rdi
ffffffff80102718:	e8 ca 13 00 00       	call   ffffffff80103ae7 <log_write>
    brelse(bp);
ffffffff8010271d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102721:	48 89 c7             	mov    %rax,%rdi
ffffffff80102724:	e8 33 dc ff ff       	call   ffffffff8010035c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffffffff80102729:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff8010272c:	01 45 fc             	add    %eax,-0x4(%rbp)
ffffffff8010272f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80102732:	01 45 cc             	add    %eax,-0x34(%rbp)
ffffffff80102735:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80102738:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffffffff8010273c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010273f:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffffffff80102742:	0f 82 5b ff ff ff    	jb     ffffffff801026a3 <writei+0xdf>
  }

  if(n > 0 && off > ip->size){
ffffffff80102748:	83 7d c8 00          	cmpl   $0x0,-0x38(%rbp)
ffffffff8010274c:	74 22                	je     ffffffff80102770 <writei+0x1ac>
ffffffff8010274e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102752:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80102755:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffffffff80102758:	73 16                	jae    ffffffff80102770 <writei+0x1ac>
    ip->size = off;
ffffffff8010275a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010275e:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffffffff80102761:	89 50 18             	mov    %edx,0x18(%rax)
    iupdate(ip);
ffffffff80102764:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102768:	48 89 c7             	mov    %rax,%rdi
ffffffff8010276b:	e8 2a f5 ff ff       	call   ffffffff80101c9a <iupdate>
  }
  return n;
ffffffff80102770:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffffffff80102773:	c9                   	leave
ffffffff80102774:	c3                   	ret

ffffffff80102775 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
ffffffff80102775:	55                   	push   %rbp
ffffffff80102776:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102779:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010277d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80102781:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return strncmp(s, t, DIRSIZ);
ffffffff80102785:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffffffff80102789:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010278d:	ba 0e 00 00 00       	mov    $0xe,%edx
ffffffff80102792:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102795:	48 89 c7             	mov    %rax,%rdi
ffffffff80102798:	e8 73 39 00 00       	call   ffffffff80106110 <strncmp>
}
ffffffff8010279d:	c9                   	leave
ffffffff8010279e:	c3                   	ret

ffffffff8010279f <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
ffffffff8010279f:	55                   	push   %rbp
ffffffff801027a0:	48 89 e5             	mov    %rsp,%rbp
ffffffff801027a3:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff801027a7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff801027ab:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff801027af:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
ffffffff801027b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801027b7:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff801027bb:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff801027bf:	74 0c                	je     ffffffff801027cd <dirlookup+0x2e>
    panic("dirlookup not DIR");
ffffffff801027c1:	48 c7 c7 f9 9c 10 80 	mov    $0xffffffff80109cf9,%rdi
ffffffff801027c8:	e8 62 e1 ff ff       	call   ffffffff8010092f <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
ffffffff801027cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801027d4:	e9 80 00 00 00       	jmp    ffffffff80102859 <dirlookup+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffffffff801027d9:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801027dc:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffffffff801027e0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801027e4:	b9 10 00 00 00       	mov    $0x10,%ecx
ffffffff801027e9:	48 89 c7             	mov    %rax,%rdi
ffffffff801027ec:	e8 4f fc ff ff       	call   ffffffff80102440 <readi>
ffffffff801027f1:	83 f8 10             	cmp    $0x10,%eax
ffffffff801027f4:	74 0c                	je     ffffffff80102802 <dirlookup+0x63>
      panic("dirlink read");
ffffffff801027f6:	48 c7 c7 0b 9d 10 80 	mov    $0xffffffff80109d0b,%rdi
ffffffff801027fd:	e8 2d e1 ff ff       	call   ffffffff8010092f <panic>
    if(de.inum == 0)
ffffffff80102802:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffffffff80102806:	66 85 c0             	test   %ax,%ax
ffffffff80102809:	74 49                	je     ffffffff80102854 <dirlookup+0xb5>
      continue;
    if(namecmp(name, de.name) == 0){
ffffffff8010280b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffffffff8010280f:	48 8d 50 02          	lea    0x2(%rax),%rdx
ffffffff80102813:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80102817:	48 89 d6             	mov    %rdx,%rsi
ffffffff8010281a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010281d:	e8 53 ff ff ff       	call   ffffffff80102775 <namecmp>
ffffffff80102822:	85 c0                	test   %eax,%eax
ffffffff80102824:	75 2f                	jne    ffffffff80102855 <dirlookup+0xb6>
      // entry matches path element
      if(poff)
ffffffff80102826:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffffffff8010282b:	74 09                	je     ffffffff80102836 <dirlookup+0x97>
        *poff = off;
ffffffff8010282d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80102831:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102834:	89 10                	mov    %edx,(%rax)
      inum = de.inum;
ffffffff80102836:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffffffff8010283a:	0f b7 c0             	movzwl %ax,%eax
ffffffff8010283d:	89 45 f8             	mov    %eax,-0x8(%rbp)
      return iget(dp->dev, inum);
ffffffff80102840:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102844:	8b 00                	mov    (%rax),%eax
ffffffff80102846:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffffffff80102849:	89 d6                	mov    %edx,%esi
ffffffff8010284b:	89 c7                	mov    %eax,%edi
ffffffff8010284d:	e8 1b f5 ff ff       	call   ffffffff80101d6d <iget>
ffffffff80102852:	eb 1a                	jmp    ffffffff8010286e <dirlookup+0xcf>
      continue;
ffffffff80102854:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
ffffffff80102855:	83 45 fc 10          	addl   $0x10,-0x4(%rbp)
ffffffff80102859:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010285d:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80102860:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff80102863:	0f 82 70 ff ff ff    	jb     ffffffff801027d9 <dirlookup+0x3a>
    }
  }

  return 0;
ffffffff80102869:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff8010286e:	c9                   	leave
ffffffff8010286f:	c3                   	ret

ffffffff80102870 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
ffffffff80102870:	55                   	push   %rbp
ffffffff80102871:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102874:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff80102878:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff8010287c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff80102880:	89 55 cc             	mov    %edx,-0x34(%rbp)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
ffffffff80102883:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffffffff80102887:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010288b:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80102890:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102893:	48 89 c7             	mov    %rax,%rdi
ffffffff80102896:	e8 04 ff ff ff       	call   ffffffff8010279f <dirlookup>
ffffffff8010289b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff8010289f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff801028a4:	74 16                	je     ffffffff801028bc <dirlink+0x4c>
    iput(ip);
ffffffff801028a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801028aa:	48 89 c7             	mov    %rax,%rdi
ffffffff801028ad:	e8 c9 f7 ff ff       	call   ffffffff8010207b <iput>
    return -1;
ffffffff801028b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801028b7:	e9 a6 00 00 00       	jmp    ffffffff80102962 <dirlink+0xf2>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
ffffffff801028bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801028c3:	eb 3b                	jmp    ffffffff80102900 <dirlink+0x90>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffffffff801028c5:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801028c8:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffffffff801028cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801028d0:	b9 10 00 00 00       	mov    $0x10,%ecx
ffffffff801028d5:	48 89 c7             	mov    %rax,%rdi
ffffffff801028d8:	e8 63 fb ff ff       	call   ffffffff80102440 <readi>
ffffffff801028dd:	83 f8 10             	cmp    $0x10,%eax
ffffffff801028e0:	74 0c                	je     ffffffff801028ee <dirlink+0x7e>
      panic("dirlink read");
ffffffff801028e2:	48 c7 c7 0b 9d 10 80 	mov    $0xffffffff80109d0b,%rdi
ffffffff801028e9:	e8 41 e0 ff ff       	call   ffffffff8010092f <panic>
    if(de.inum == 0)
ffffffff801028ee:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffffffff801028f2:	66 85 c0             	test   %ax,%ax
ffffffff801028f5:	74 19                	je     ffffffff80102910 <dirlink+0xa0>
  for(off = 0; off < dp->size; off += sizeof(de)){
ffffffff801028f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801028fa:	83 c0 10             	add    $0x10,%eax
ffffffff801028fd:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80102900:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80102904:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80102907:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010290a:	39 c2                	cmp    %eax,%edx
ffffffff8010290c:	72 b7                	jb     ffffffff801028c5 <dirlink+0x55>
ffffffff8010290e:	eb 01                	jmp    ffffffff80102911 <dirlink+0xa1>
      break;
ffffffff80102910:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
ffffffff80102911:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80102915:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffffffff80102919:	48 8d 4a 02          	lea    0x2(%rdx),%rcx
ffffffff8010291d:	ba 0e 00 00 00       	mov    $0xe,%edx
ffffffff80102922:	48 89 c6             	mov    %rax,%rsi
ffffffff80102925:	48 89 cf             	mov    %rcx,%rdi
ffffffff80102928:	e8 50 38 00 00       	call   ffffffff8010617d <strncpy>
  de.inum = inum;
ffffffff8010292d:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffffffff80102930:	66 89 45 e0          	mov    %ax,-0x20(%rbp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffffffff80102934:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102937:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffffffff8010293b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff8010293f:	b9 10 00 00 00       	mov    $0x10,%ecx
ffffffff80102944:	48 89 c7             	mov    %rax,%rdi
ffffffff80102947:	e8 78 fc ff ff       	call   ffffffff801025c4 <writei>
ffffffff8010294c:	83 f8 10             	cmp    $0x10,%eax
ffffffff8010294f:	74 0c                	je     ffffffff8010295d <dirlink+0xed>
    panic("dirlink");
ffffffff80102951:	48 c7 c7 18 9d 10 80 	mov    $0xffffffff80109d18,%rdi
ffffffff80102958:	e8 d2 df ff ff       	call   ffffffff8010092f <panic>
  
  return 0;
ffffffff8010295d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80102962:	c9                   	leave
ffffffff80102963:	c3                   	ret

ffffffff80102964 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
ffffffff80102964:	55                   	push   %rbp
ffffffff80102965:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102968:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff8010296c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80102970:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s;
  int len;

  while(*path == '/')
ffffffff80102974:	eb 05                	jmp    ffffffff8010297b <skipelem+0x17>
    path++;
ffffffff80102976:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffffffff8010297b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010297f:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102982:	3c 2f                	cmp    $0x2f,%al
ffffffff80102984:	74 f0                	je     ffffffff80102976 <skipelem+0x12>
  if(*path == 0)
ffffffff80102986:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010298a:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010298d:	84 c0                	test   %al,%al
ffffffff8010298f:	75 0a                	jne    ffffffff8010299b <skipelem+0x37>
    return 0;
ffffffff80102991:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80102996:	e9 8c 00 00 00       	jmp    ffffffff80102a27 <skipelem+0xc3>
  s = path;
ffffffff8010299b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010299f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(*path != '/' && *path != 0)
ffffffff801029a3:	eb 05                	jmp    ffffffff801029aa <skipelem+0x46>
    path++;
ffffffff801029a5:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path != '/' && *path != 0)
ffffffff801029aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801029ae:	0f b6 00             	movzbl (%rax),%eax
ffffffff801029b1:	3c 2f                	cmp    $0x2f,%al
ffffffff801029b3:	74 0b                	je     ffffffff801029c0 <skipelem+0x5c>
ffffffff801029b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801029b9:	0f b6 00             	movzbl (%rax),%eax
ffffffff801029bc:	84 c0                	test   %al,%al
ffffffff801029be:	75 e5                	jne    ffffffff801029a5 <skipelem+0x41>
  len = path - s;
ffffffff801029c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801029c4:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
ffffffff801029c8:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(len >= DIRSIZ)
ffffffff801029cb:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
ffffffff801029cf:	7e 1a                	jle    ffffffff801029eb <skipelem+0x87>
    memmove(name, s, DIRSIZ);
ffffffff801029d1:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff801029d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801029d9:	ba 0e 00 00 00       	mov    $0xe,%edx
ffffffff801029de:	48 89 ce             	mov    %rcx,%rsi
ffffffff801029e1:	48 89 c7             	mov    %rax,%rdi
ffffffff801029e4:	e8 59 36 00 00       	call   ffffffff80106042 <memmove>
ffffffff801029e9:	eb 2d                	jmp    ffffffff80102a18 <skipelem+0xb4>
  else {
    memmove(name, s, len);
ffffffff801029eb:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff801029ee:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff801029f2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801029f6:	48 89 ce             	mov    %rcx,%rsi
ffffffff801029f9:	48 89 c7             	mov    %rax,%rdi
ffffffff801029fc:	e8 41 36 00 00       	call   ffffffff80106042 <memmove>
    name[len] = 0;
ffffffff80102a01:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80102a04:	48 63 d0             	movslq %eax,%rdx
ffffffff80102a07:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80102a0b:	48 01 d0             	add    %rdx,%rax
ffffffff80102a0e:	c6 00 00             	movb   $0x0,(%rax)
  }
  while(*path == '/')
ffffffff80102a11:	eb 05                	jmp    ffffffff80102a18 <skipelem+0xb4>
    path++;
ffffffff80102a13:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffffffff80102a18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102a1c:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102a1f:	3c 2f                	cmp    $0x2f,%al
ffffffff80102a21:	74 f0                	je     ffffffff80102a13 <skipelem+0xaf>
  return path;
ffffffff80102a23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffffffff80102a27:	c9                   	leave
ffffffff80102a28:	c3                   	ret

ffffffff80102a29 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
ffffffff80102a29:	55                   	push   %rbp
ffffffff80102a2a:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102a2d:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80102a31:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80102a35:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffffffff80102a38:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  struct inode *ip, *next;

  if(*path == '/')
ffffffff80102a3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102a40:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102a43:	3c 2f                	cmp    $0x2f,%al
ffffffff80102a45:	75 18                	jne    ffffffff80102a5f <namex+0x36>
    ip = iget(ROOTDEV, ROOTINO);
ffffffff80102a47:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80102a4c:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80102a51:	e8 17 f3 ff ff       	call   ffffffff80101d6d <iget>
ffffffff80102a56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80102a5a:	e9 c3 00 00 00       	jmp    ffffffff80102b22 <namex+0xf9>
  else
    ip = idup(proc->cwd);
ffffffff80102a5f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80102a66:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80102a6a:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffffffff80102a71:	48 89 c7             	mov    %rax,%rdi
ffffffff80102a74:	e8 e4 f3 ff ff       	call   ffffffff80101e5d <idup>
ffffffff80102a79:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  while((path = skipelem(path, name)) != 0){
ffffffff80102a7d:	e9 a0 00 00 00       	jmp    ffffffff80102b22 <namex+0xf9>
    ilock(ip);
ffffffff80102a82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102a86:	48 89 c7             	mov    %rax,%rdi
ffffffff80102a89:	e8 0a f4 ff ff       	call   ffffffff80101e98 <ilock>
    if(ip->type != T_DIR){
ffffffff80102a8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102a92:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80102a96:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff80102a9a:	74 16                	je     ffffffff80102ab2 <namex+0x89>
      iunlockput(ip);
ffffffff80102a9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102aa0:	48 89 c7             	mov    %rax,%rdi
ffffffff80102aa3:	e8 b8 f6 ff ff       	call   ffffffff80102160 <iunlockput>
      return 0;
ffffffff80102aa8:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80102aad:	e9 af 00 00 00       	jmp    ffffffff80102b61 <namex+0x138>
    }
    if(nameiparent && *path == '\0'){
ffffffff80102ab2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffffffff80102ab6:	74 20                	je     ffffffff80102ad8 <namex+0xaf>
ffffffff80102ab8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102abc:	0f b6 00             	movzbl (%rax),%eax
ffffffff80102abf:	84 c0                	test   %al,%al
ffffffff80102ac1:	75 15                	jne    ffffffff80102ad8 <namex+0xaf>
      // Stop one level early.
      iunlock(ip);
ffffffff80102ac3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102ac7:	48 89 c7             	mov    %rax,%rdi
ffffffff80102aca:	e8 3a f5 ff ff       	call   ffffffff80102009 <iunlock>
      return ip;
ffffffff80102acf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102ad3:	e9 89 00 00 00       	jmp    ffffffff80102b61 <namex+0x138>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
ffffffff80102ad8:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffffffff80102adc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102ae0:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80102ae5:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102ae8:	48 89 c7             	mov    %rax,%rdi
ffffffff80102aeb:	e8 af fc ff ff       	call   ffffffff8010279f <dirlookup>
ffffffff80102af0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80102af4:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80102af9:	75 13                	jne    ffffffff80102b0e <namex+0xe5>
      iunlockput(ip);
ffffffff80102afb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102aff:	48 89 c7             	mov    %rax,%rdi
ffffffff80102b02:	e8 59 f6 ff ff       	call   ffffffff80102160 <iunlockput>
      return 0;
ffffffff80102b07:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80102b0c:	eb 53                	jmp    ffffffff80102b61 <namex+0x138>
    }
    iunlockput(ip);
ffffffff80102b0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102b12:	48 89 c7             	mov    %rax,%rdi
ffffffff80102b15:	e8 46 f6 ff ff       	call   ffffffff80102160 <iunlockput>
    ip = next;
ffffffff80102b1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80102b1e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((path = skipelem(path, name)) != 0){
ffffffff80102b22:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffffffff80102b26:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102b2a:	48 89 d6             	mov    %rdx,%rsi
ffffffff80102b2d:	48 89 c7             	mov    %rax,%rdi
ffffffff80102b30:	e8 2f fe ff ff       	call   ffffffff80102964 <skipelem>
ffffffff80102b35:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff80102b39:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80102b3e:	0f 85 3e ff ff ff    	jne    ffffffff80102a82 <namex+0x59>
  }
  if(nameiparent){
ffffffff80102b44:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffffffff80102b48:	74 13                	je     ffffffff80102b5d <namex+0x134>
    iput(ip);
ffffffff80102b4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102b4e:	48 89 c7             	mov    %rax,%rdi
ffffffff80102b51:	e8 25 f5 ff ff       	call   ffffffff8010207b <iput>
    return 0;
ffffffff80102b56:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80102b5b:	eb 04                	jmp    ffffffff80102b61 <namex+0x138>
  }
  return ip;
ffffffff80102b5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80102b61:	c9                   	leave
ffffffff80102b62:	c3                   	ret

ffffffff80102b63 <namei>:

struct inode*
namei(char *path)
{
ffffffff80102b63:	55                   	push   %rbp
ffffffff80102b64:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102b67:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80102b6b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  char name[DIRSIZ];
  return namex(path, 0, name);
ffffffff80102b6f:	48 8d 55 f2          	lea    -0xe(%rbp),%rdx
ffffffff80102b73:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102b77:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80102b7c:	48 89 c7             	mov    %rax,%rdi
ffffffff80102b7f:	e8 a5 fe ff ff       	call   ffffffff80102a29 <namex>
}
ffffffff80102b84:	c9                   	leave
ffffffff80102b85:	c3                   	ret

ffffffff80102b86 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
ffffffff80102b86:	55                   	push   %rbp
ffffffff80102b87:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102b8a:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102b8e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80102b92:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return namex(path, 1, name);
ffffffff80102b96:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80102b9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102b9e:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80102ba3:	48 89 c7             	mov    %rax,%rdi
ffffffff80102ba6:	e8 7e fe ff ff       	call   ffffffff80102a29 <namex>
}
ffffffff80102bab:	c9                   	leave
ffffffff80102bac:	c3                   	ret

ffffffff80102bad <inb>:
{
ffffffff80102bad:	55                   	push   %rbp
ffffffff80102bae:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102bb1:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80102bb5:	89 f8                	mov    %edi,%eax
ffffffff80102bb7:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffffffff80102bbb:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffffffff80102bbf:	89 c2                	mov    %eax,%edx
ffffffff80102bc1:	ec                   	in     (%dx),%al
ffffffff80102bc2:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffffffff80102bc5:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffffffff80102bc9:	c9                   	leave
ffffffff80102bca:	c3                   	ret

ffffffff80102bcb <insl>:
{
ffffffff80102bcb:	55                   	push   %rbp
ffffffff80102bcc:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102bcf:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102bd3:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff80102bd6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80102bda:	89 55 f8             	mov    %edx,-0x8(%rbp)
  asm volatile("cld; rep insl" :
ffffffff80102bdd:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102be0:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffffffff80102be4:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80102be7:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102bea:	48 89 f7             	mov    %rsi,%rdi
ffffffff80102bed:	89 c1                	mov    %eax,%ecx
ffffffff80102bef:	fc                   	cld
ffffffff80102bf0:	f3 6d                	rep insl (%dx),%es:(%rdi)
ffffffff80102bf2:	89 c8                	mov    %ecx,%eax
ffffffff80102bf4:	48 89 fe             	mov    %rdi,%rsi
ffffffff80102bf7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80102bfb:	89 45 f8             	mov    %eax,-0x8(%rbp)
}
ffffffff80102bfe:	90                   	nop
ffffffff80102bff:	c9                   	leave
ffffffff80102c00:	c3                   	ret

ffffffff80102c01 <outb>:
{
ffffffff80102c01:	55                   	push   %rbp
ffffffff80102c02:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102c05:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80102c09:	89 fa                	mov    %edi,%edx
ffffffff80102c0b:	89 f0                	mov    %esi,%eax
ffffffff80102c0d:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff80102c11:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff80102c14:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff80102c18:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff80102c1c:	ee                   	out    %al,(%dx)
}
ffffffff80102c1d:	90                   	nop
ffffffff80102c1e:	c9                   	leave
ffffffff80102c1f:	c3                   	ret

ffffffff80102c20 <outsl>:
{
ffffffff80102c20:	55                   	push   %rbp
ffffffff80102c21:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102c24:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102c28:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff80102c2b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80102c2f:	89 55 f8             	mov    %edx,-0x8(%rbp)
  asm volatile("cld; rep outsl" :
ffffffff80102c32:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80102c35:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffffffff80102c39:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80102c3c:	48 89 ce             	mov    %rcx,%rsi
ffffffff80102c3f:	89 c1                	mov    %eax,%ecx
ffffffff80102c41:	fc                   	cld
ffffffff80102c42:	f3 6f                	rep outsl %ds:(%rsi),(%dx)
ffffffff80102c44:	89 c8                	mov    %ecx,%eax
ffffffff80102c46:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80102c4a:	89 45 f8             	mov    %eax,-0x8(%rbp)
}
ffffffff80102c4d:	90                   	nop
ffffffff80102c4e:	c9                   	leave
ffffffff80102c4f:	c3                   	ret

ffffffff80102c50 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
ffffffff80102c50:	55                   	push   %rbp
ffffffff80102c51:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102c54:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80102c58:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
ffffffff80102c5b:	90                   	nop
ffffffff80102c5c:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffffffff80102c61:	e8 47 ff ff ff       	call   ffffffff80102bad <inb>
ffffffff80102c66:	0f b6 c0             	movzbl %al,%eax
ffffffff80102c69:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80102c6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80102c6f:	25 c0 00 00 00       	and    $0xc0,%eax
ffffffff80102c74:	83 f8 40             	cmp    $0x40,%eax
ffffffff80102c77:	75 e3                	jne    ffffffff80102c5c <idewait+0xc>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
ffffffff80102c79:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff80102c7d:	74 11                	je     ffffffff80102c90 <idewait+0x40>
ffffffff80102c7f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80102c82:	83 e0 21             	and    $0x21,%eax
ffffffff80102c85:	85 c0                	test   %eax,%eax
ffffffff80102c87:	74 07                	je     ffffffff80102c90 <idewait+0x40>
    return -1;
ffffffff80102c89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80102c8e:	eb 05                	jmp    ffffffff80102c95 <idewait+0x45>
  return 0;
ffffffff80102c90:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80102c95:	c9                   	leave
ffffffff80102c96:	c3                   	ret

ffffffff80102c97 <ideinit>:

void
ideinit(void)
{
ffffffff80102c97:	55                   	push   %rbp
ffffffff80102c98:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102c9b:	48 83 ec 10          	sub    $0x10,%rsp
  int i;

  initlock(&idelock, "ide");
ffffffff80102c9f:	48 c7 c6 20 9d 10 80 	mov    $0xffffffff80109d20,%rsi
ffffffff80102ca6:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80102cad:	e8 fc 2e 00 00       	call   ffffffff80105bae <initlock>
  picenable(IRQ_IDE);
ffffffff80102cb2:	bf 0e 00 00 00       	mov    $0xe,%edi
ffffffff80102cb7:	e8 63 1b 00 00       	call   ffffffff8010481f <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
ffffffff80102cbc:	8b 05 22 d7 00 00    	mov    0xd722(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80102cc2:	83 e8 01             	sub    $0x1,%eax
ffffffff80102cc5:	89 c6                	mov    %eax,%esi
ffffffff80102cc7:	bf 0e 00 00 00       	mov    $0xe,%edi
ffffffff80102ccc:	e8 31 04 00 00       	call   ffffffff80103102 <ioapicenable>
  idewait(0);
ffffffff80102cd1:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80102cd6:	e8 75 ff ff ff       	call   ffffffff80102c50 <idewait>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
ffffffff80102cdb:	be f0 00 00 00       	mov    $0xf0,%esi
ffffffff80102ce0:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffffffff80102ce5:	e8 17 ff ff ff       	call   ffffffff80102c01 <outb>
  for(i=0; i<1000; i++){
ffffffff80102cea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80102cf1:	eb 1e                	jmp    ffffffff80102d11 <ideinit+0x7a>
    if(inb(0x1f7) != 0){
ffffffff80102cf3:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffffffff80102cf8:	e8 b0 fe ff ff       	call   ffffffff80102bad <inb>
ffffffff80102cfd:	84 c0                	test   %al,%al
ffffffff80102cff:	74 0c                	je     ffffffff80102d0d <ideinit+0x76>
      havedisk1 = 1;
ffffffff80102d01:	c7 05 e5 cd 00 00 01 	movl   $0x1,0xcde5(%rip)        # ffffffff8010faf0 <havedisk1>
ffffffff80102d08:	00 00 00 
      break;
ffffffff80102d0b:	eb 0d                	jmp    ffffffff80102d1a <ideinit+0x83>
  for(i=0; i<1000; i++){
ffffffff80102d0d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80102d11:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
ffffffff80102d18:	7e d9                	jle    ffffffff80102cf3 <ideinit+0x5c>
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
ffffffff80102d1a:	be e0 00 00 00       	mov    $0xe0,%esi
ffffffff80102d1f:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffffffff80102d24:	e8 d8 fe ff ff       	call   ffffffff80102c01 <outb>
}
ffffffff80102d29:	90                   	nop
ffffffff80102d2a:	c9                   	leave
ffffffff80102d2b:	c3                   	ret

ffffffff80102d2c <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
ffffffff80102d2c:	55                   	push   %rbp
ffffffff80102d2d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102d30:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80102d34:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(b == 0)
ffffffff80102d38:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80102d3d:	75 0c                	jne    ffffffff80102d4b <idestart+0x1f>
    panic("idestart");
ffffffff80102d3f:	48 c7 c7 24 9d 10 80 	mov    $0xffffffff80109d24,%rdi
ffffffff80102d46:	e8 e4 db ff ff       	call   ffffffff8010092f <panic>

  idewait(0);
ffffffff80102d4b:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80102d50:	e8 fb fe ff ff       	call   ffffffff80102c50 <idewait>
  outb(0x3f6, 0);  // generate interrupt
ffffffff80102d55:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80102d5a:	bf f6 03 00 00       	mov    $0x3f6,%edi
ffffffff80102d5f:	e8 9d fe ff ff       	call   ffffffff80102c01 <outb>
  outb(0x1f2, 1);  // number of sectors
ffffffff80102d64:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80102d69:	bf f2 01 00 00       	mov    $0x1f2,%edi
ffffffff80102d6e:	e8 8e fe ff ff       	call   ffffffff80102c01 <outb>
  outb(0x1f3, b->sector & 0xff);
ffffffff80102d73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102d77:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102d7a:	0f b6 c0             	movzbl %al,%eax
ffffffff80102d7d:	89 c6                	mov    %eax,%esi
ffffffff80102d7f:	bf f3 01 00 00       	mov    $0x1f3,%edi
ffffffff80102d84:	e8 78 fe ff ff       	call   ffffffff80102c01 <outb>
  outb(0x1f4, (b->sector >> 8) & 0xff);
ffffffff80102d89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102d8d:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102d90:	c1 e8 08             	shr    $0x8,%eax
ffffffff80102d93:	0f b6 c0             	movzbl %al,%eax
ffffffff80102d96:	89 c6                	mov    %eax,%esi
ffffffff80102d98:	bf f4 01 00 00       	mov    $0x1f4,%edi
ffffffff80102d9d:	e8 5f fe ff ff       	call   ffffffff80102c01 <outb>
  outb(0x1f5, (b->sector >> 16) & 0xff);
ffffffff80102da2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102da6:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102da9:	c1 e8 10             	shr    $0x10,%eax
ffffffff80102dac:	0f b6 c0             	movzbl %al,%eax
ffffffff80102daf:	89 c6                	mov    %eax,%esi
ffffffff80102db1:	bf f5 01 00 00       	mov    $0x1f5,%edi
ffffffff80102db6:	e8 46 fe ff ff       	call   ffffffff80102c01 <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
ffffffff80102dbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102dbf:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80102dc2:	c1 e0 04             	shl    $0x4,%eax
ffffffff80102dc5:	83 e0 10             	and    $0x10,%eax
ffffffff80102dc8:	89 c2                	mov    %eax,%edx
ffffffff80102dca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102dce:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80102dd1:	c1 e8 18             	shr    $0x18,%eax
ffffffff80102dd4:	83 e0 0f             	and    $0xf,%eax
ffffffff80102dd7:	09 d0                	or     %edx,%eax
ffffffff80102dd9:	83 c8 e0             	or     $0xffffffe0,%eax
ffffffff80102ddc:	0f b6 c0             	movzbl %al,%eax
ffffffff80102ddf:	89 c6                	mov    %eax,%esi
ffffffff80102de1:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffffffff80102de6:	e8 16 fe ff ff       	call   ffffffff80102c01 <outb>
  if(b->flags & B_DIRTY){
ffffffff80102deb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102def:	8b 00                	mov    (%rax),%eax
ffffffff80102df1:	83 e0 04             	and    $0x4,%eax
ffffffff80102df4:	85 c0                	test   %eax,%eax
ffffffff80102df6:	74 2b                	je     ffffffff80102e23 <idestart+0xf7>
    outb(0x1f7, IDE_CMD_WRITE);
ffffffff80102df8:	be 30 00 00 00       	mov    $0x30,%esi
ffffffff80102dfd:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffffffff80102e02:	e8 fa fd ff ff       	call   ffffffff80102c01 <outb>
    outsl(0x1f0, b->data, 512/4);
ffffffff80102e07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102e0b:	48 83 c0 28          	add    $0x28,%rax
ffffffff80102e0f:	ba 80 00 00 00       	mov    $0x80,%edx
ffffffff80102e14:	48 89 c6             	mov    %rax,%rsi
ffffffff80102e17:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffffffff80102e1c:	e8 ff fd ff ff       	call   ffffffff80102c20 <outsl>
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
ffffffff80102e21:	eb 0f                	jmp    ffffffff80102e32 <idestart+0x106>
    outb(0x1f7, IDE_CMD_READ);
ffffffff80102e23:	be 20 00 00 00       	mov    $0x20,%esi
ffffffff80102e28:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffffffff80102e2d:	e8 cf fd ff ff       	call   ffffffff80102c01 <outb>
}
ffffffff80102e32:	90                   	nop
ffffffff80102e33:	c9                   	leave
ffffffff80102e34:	c3                   	ret

ffffffff80102e35 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
ffffffff80102e35:	55                   	push   %rbp
ffffffff80102e36:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102e39:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
ffffffff80102e3d:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80102e44:	e8 9a 2d 00 00       	call   ffffffff80105be3 <acquire>
  if((b = idequeue) == 0){
ffffffff80102e49:	48 8b 05 98 cc 00 00 	mov    0xcc98(%rip),%rax        # ffffffff8010fae8 <idequeue>
ffffffff80102e50:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80102e54:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80102e59:	75 11                	jne    ffffffff80102e6c <ideintr+0x37>
    release(&idelock);
ffffffff80102e5b:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80102e62:	e8 53 2e 00 00       	call   ffffffff80105cba <release>
    // cprintf("spurious IDE interrupt\n");
    return;
ffffffff80102e67:	e9 99 00 00 00       	jmp    ffffffff80102f05 <ideintr+0xd0>
  }
  idequeue = b->qnext;
ffffffff80102e6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102e70:	48 8b 40 20          	mov    0x20(%rax),%rax
ffffffff80102e74:	48 89 05 6d cc 00 00 	mov    %rax,0xcc6d(%rip)        # ffffffff8010fae8 <idequeue>

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
ffffffff80102e7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102e7f:	8b 00                	mov    (%rax),%eax
ffffffff80102e81:	83 e0 04             	and    $0x4,%eax
ffffffff80102e84:	85 c0                	test   %eax,%eax
ffffffff80102e86:	75 28                	jne    ffffffff80102eb0 <ideintr+0x7b>
ffffffff80102e88:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80102e8d:	e8 be fd ff ff       	call   ffffffff80102c50 <idewait>
ffffffff80102e92:	85 c0                	test   %eax,%eax
ffffffff80102e94:	78 1a                	js     ffffffff80102eb0 <ideintr+0x7b>
    insl(0x1f0, b->data, 512/4);
ffffffff80102e96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102e9a:	48 83 c0 28          	add    $0x28,%rax
ffffffff80102e9e:	ba 80 00 00 00       	mov    $0x80,%edx
ffffffff80102ea3:	48 89 c6             	mov    %rax,%rsi
ffffffff80102ea6:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffffffff80102eab:	e8 1b fd ff ff       	call   ffffffff80102bcb <insl>
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
ffffffff80102eb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102eb4:	8b 00                	mov    (%rax),%eax
ffffffff80102eb6:	83 c8 02             	or     $0x2,%eax
ffffffff80102eb9:	89 c2                	mov    %eax,%edx
ffffffff80102ebb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102ebf:	89 10                	mov    %edx,(%rax)
  b->flags &= ~B_DIRTY;
ffffffff80102ec1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102ec5:	8b 00                	mov    (%rax),%eax
ffffffff80102ec7:	83 e0 fb             	and    $0xfffffffb,%eax
ffffffff80102eca:	89 c2                	mov    %eax,%edx
ffffffff80102ecc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102ed0:	89 10                	mov    %edx,(%rax)
  wakeup(b);
ffffffff80102ed2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102ed6:	48 89 c7             	mov    %rax,%rdi
ffffffff80102ed9:	e8 95 2a 00 00       	call   ffffffff80105973 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
ffffffff80102ede:	48 8b 05 03 cc 00 00 	mov    0xcc03(%rip),%rax        # ffffffff8010fae8 <idequeue>
ffffffff80102ee5:	48 85 c0             	test   %rax,%rax
ffffffff80102ee8:	74 0f                	je     ffffffff80102ef9 <ideintr+0xc4>
    idestart(idequeue);
ffffffff80102eea:	48 8b 05 f7 cb 00 00 	mov    0xcbf7(%rip),%rax        # ffffffff8010fae8 <idequeue>
ffffffff80102ef1:	48 89 c7             	mov    %rax,%rdi
ffffffff80102ef4:	e8 33 fe ff ff       	call   ffffffff80102d2c <idestart>

  release(&idelock);
ffffffff80102ef9:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80102f00:	e8 b5 2d 00 00       	call   ffffffff80105cba <release>
}
ffffffff80102f05:	c9                   	leave
ffffffff80102f06:	c3                   	ret

ffffffff80102f07 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
ffffffff80102f07:	55                   	push   %rbp
ffffffff80102f08:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102f0b:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80102f0f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf **pp;

  if(!(b->flags & B_BUSY))
ffffffff80102f13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102f17:	8b 00                	mov    (%rax),%eax
ffffffff80102f19:	83 e0 01             	and    $0x1,%eax
ffffffff80102f1c:	85 c0                	test   %eax,%eax
ffffffff80102f1e:	75 0c                	jne    ffffffff80102f2c <iderw+0x25>
    panic("iderw: buf not busy");
ffffffff80102f20:	48 c7 c7 2d 9d 10 80 	mov    $0xffffffff80109d2d,%rdi
ffffffff80102f27:	e8 03 da ff ff       	call   ffffffff8010092f <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
ffffffff80102f2c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102f30:	8b 00                	mov    (%rax),%eax
ffffffff80102f32:	83 e0 06             	and    $0x6,%eax
ffffffff80102f35:	83 f8 02             	cmp    $0x2,%eax
ffffffff80102f38:	75 0c                	jne    ffffffff80102f46 <iderw+0x3f>
    panic("iderw: nothing to do");
ffffffff80102f3a:	48 c7 c7 41 9d 10 80 	mov    $0xffffffff80109d41,%rdi
ffffffff80102f41:	e8 e9 d9 ff ff       	call   ffffffff8010092f <panic>
  if(b->dev != 0 && !havedisk1)
ffffffff80102f46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102f4a:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80102f4d:	85 c0                	test   %eax,%eax
ffffffff80102f4f:	74 16                	je     ffffffff80102f67 <iderw+0x60>
ffffffff80102f51:	8b 05 99 cb 00 00    	mov    0xcb99(%rip),%eax        # ffffffff8010faf0 <havedisk1>
ffffffff80102f57:	85 c0                	test   %eax,%eax
ffffffff80102f59:	75 0c                	jne    ffffffff80102f67 <iderw+0x60>
    panic("iderw: ide disk 1 not present");
ffffffff80102f5b:	48 c7 c7 56 9d 10 80 	mov    $0xffffffff80109d56,%rdi
ffffffff80102f62:	e8 c8 d9 ff ff       	call   ffffffff8010092f <panic>

  acquire(&idelock);  //DOC:acquire-lock
ffffffff80102f67:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80102f6e:	e8 70 2c 00 00       	call   ffffffff80105be3 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
ffffffff80102f73:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102f77:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffffffff80102f7e:	00 
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
ffffffff80102f7f:	48 c7 45 f8 e8 fa 10 	movq   $0xffffffff8010fae8,-0x8(%rbp)
ffffffff80102f86:	80 
ffffffff80102f87:	eb 0f                	jmp    ffffffff80102f98 <iderw+0x91>
ffffffff80102f89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102f8d:	48 8b 00             	mov    (%rax),%rax
ffffffff80102f90:	48 83 c0 20          	add    $0x20,%rax
ffffffff80102f94:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80102f98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102f9c:	48 8b 00             	mov    (%rax),%rax
ffffffff80102f9f:	48 85 c0             	test   %rax,%rax
ffffffff80102fa2:	75 e5                	jne    ffffffff80102f89 <iderw+0x82>
    ;
  *pp = b;
ffffffff80102fa4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80102fa8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80102fac:	48 89 10             	mov    %rdx,(%rax)
  
  // Start disk if necessary.
  if(idequeue == b)
ffffffff80102faf:	48 8b 05 32 cb 00 00 	mov    0xcb32(%rip),%rax        # ffffffff8010fae8 <idequeue>
ffffffff80102fb6:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffffffff80102fba:	75 21                	jne    ffffffff80102fdd <iderw+0xd6>
    idestart(b);
ffffffff80102fbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102fc0:	48 89 c7             	mov    %rax,%rdi
ffffffff80102fc3:	e8 64 fd ff ff       	call   ffffffff80102d2c <idestart>
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffffffff80102fc8:	eb 13                	jmp    ffffffff80102fdd <iderw+0xd6>
    sleep(b, &idelock);
ffffffff80102fca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102fce:	48 c7 c6 80 fa 10 80 	mov    $0xffffffff8010fa80,%rsi
ffffffff80102fd5:	48 89 c7             	mov    %rax,%rdi
ffffffff80102fd8:	e8 82 28 00 00       	call   ffffffff8010585f <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffffffff80102fdd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80102fe1:	8b 00                	mov    (%rax),%eax
ffffffff80102fe3:	83 e0 06             	and    $0x6,%eax
ffffffff80102fe6:	83 f8 02             	cmp    $0x2,%eax
ffffffff80102fe9:	75 df                	jne    ffffffff80102fca <iderw+0xc3>
  }

  release(&idelock);
ffffffff80102feb:	48 c7 c7 80 fa 10 80 	mov    $0xffffffff8010fa80,%rdi
ffffffff80102ff2:	e8 c3 2c 00 00       	call   ffffffff80105cba <release>
}
ffffffff80102ff7:	90                   	nop
ffffffff80102ff8:	c9                   	leave
ffffffff80102ff9:	c3                   	ret

ffffffff80102ffa <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
ffffffff80102ffa:	55                   	push   %rbp
ffffffff80102ffb:	48 89 e5             	mov    %rsp,%rbp
ffffffff80102ffe:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103002:	89 7d fc             	mov    %edi,-0x4(%rbp)
  ioapic->reg = reg;
ffffffff80103005:	48 8b 05 ec ca 00 00 	mov    0xcaec(%rip),%rax        # ffffffff8010faf8 <ioapic>
ffffffff8010300c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010300f:	89 10                	mov    %edx,(%rax)
  return ioapic->data;
ffffffff80103011:	48 8b 05 e0 ca 00 00 	mov    0xcae0(%rip),%rax        # ffffffff8010faf8 <ioapic>
ffffffff80103018:	8b 40 10             	mov    0x10(%rax),%eax
}
ffffffff8010301b:	c9                   	leave
ffffffff8010301c:	c3                   	ret

ffffffff8010301d <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
ffffffff8010301d:	55                   	push   %rbp
ffffffff8010301e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103021:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103025:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff80103028:	89 75 f8             	mov    %esi,-0x8(%rbp)
  ioapic->reg = reg;
ffffffff8010302b:	48 8b 05 c6 ca 00 00 	mov    0xcac6(%rip),%rax        # ffffffff8010faf8 <ioapic>
ffffffff80103032:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80103035:	89 10                	mov    %edx,(%rax)
  ioapic->data = data;
ffffffff80103037:	48 8b 05 ba ca 00 00 	mov    0xcaba(%rip),%rax        # ffffffff8010faf8 <ioapic>
ffffffff8010303e:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffffffff80103041:	89 50 10             	mov    %edx,0x10(%rax)
}
ffffffff80103044:	90                   	nop
ffffffff80103045:	c9                   	leave
ffffffff80103046:	c3                   	ret

ffffffff80103047 <ioapicinit>:

void
ioapicinit(void)
{
ffffffff80103047:	55                   	push   %rbp
ffffffff80103048:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010304b:	48 83 ec 10          	sub    $0x10,%rsp
  int i, id, maxintr;

  if(!ismp)
ffffffff8010304f:	8b 05 8b d3 00 00    	mov    0xd38b(%rip),%eax        # ffffffff801103e0 <ismp>
ffffffff80103055:	85 c0                	test   %eax,%eax
ffffffff80103057:	0f 84 a2 00 00 00    	je     ffffffff801030ff <ioapicinit+0xb8>
    return;

  ioapic = (volatile struct ioapic*) IO2V(IOAPIC);
ffffffff8010305d:	48 b8 00 00 c0 40 ff 	movabs $0xffffffff40c00000,%rax
ffffffff80103064:	ff ff ff 
ffffffff80103067:	48 89 05 8a ca 00 00 	mov    %rax,0xca8a(%rip)        # ffffffff8010faf8 <ioapic>
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
ffffffff8010306e:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80103073:	e8 82 ff ff ff       	call   ffffffff80102ffa <ioapicread>
ffffffff80103078:	c1 e8 10             	shr    $0x10,%eax
ffffffff8010307b:	25 ff 00 00 00       	and    $0xff,%eax
ffffffff80103080:	89 45 f8             	mov    %eax,-0x8(%rbp)
  id = ioapicread(REG_ID) >> 24;
ffffffff80103083:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80103088:	e8 6d ff ff ff       	call   ffffffff80102ffa <ioapicread>
ffffffff8010308d:	c1 e8 18             	shr    $0x18,%eax
ffffffff80103090:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(id != ioapicid)
ffffffff80103093:	0f b6 05 4e d3 00 00 	movzbl 0xd34e(%rip),%eax        # ffffffff801103e8 <ioapicid>
ffffffff8010309a:	0f b6 c0             	movzbl %al,%eax
ffffffff8010309d:	39 45 f4             	cmp    %eax,-0xc(%rbp)
ffffffff801030a0:	74 11                	je     ffffffff801030b3 <ioapicinit+0x6c>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
ffffffff801030a2:	48 c7 c7 78 9d 10 80 	mov    $0xffffffff80109d78,%rdi
ffffffff801030a9:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801030ae:	e8 f1 d4 ff ff       	call   ffffffff801005a4 <cprintf>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
ffffffff801030b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801030ba:	eb 39                	jmp    ffffffff801030f5 <ioapicinit+0xae>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
ffffffff801030bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801030bf:	83 c0 20             	add    $0x20,%eax
ffffffff801030c2:	0d 00 00 01 00       	or     $0x10000,%eax
ffffffff801030c7:	89 c2                	mov    %eax,%edx
ffffffff801030c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801030cc:	83 c0 08             	add    $0x8,%eax
ffffffff801030cf:	01 c0                	add    %eax,%eax
ffffffff801030d1:	89 d6                	mov    %edx,%esi
ffffffff801030d3:	89 c7                	mov    %eax,%edi
ffffffff801030d5:	e8 43 ff ff ff       	call   ffffffff8010301d <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
ffffffff801030da:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801030dd:	83 c0 08             	add    $0x8,%eax
ffffffff801030e0:	01 c0                	add    %eax,%eax
ffffffff801030e2:	83 c0 01             	add    $0x1,%eax
ffffffff801030e5:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801030ea:	89 c7                	mov    %eax,%edi
ffffffff801030ec:	e8 2c ff ff ff       	call   ffffffff8010301d <ioapicwrite>
  for(i = 0; i <= maxintr; i++){
ffffffff801030f1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801030f5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801030f8:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffffffff801030fb:	7e bf                	jle    ffffffff801030bc <ioapicinit+0x75>
ffffffff801030fd:	eb 01                	jmp    ffffffff80103100 <ioapicinit+0xb9>
    return;
ffffffff801030ff:	90                   	nop
  }
}
ffffffff80103100:	c9                   	leave
ffffffff80103101:	c3                   	ret

ffffffff80103102 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
ffffffff80103102:	55                   	push   %rbp
ffffffff80103103:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103106:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff8010310a:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff8010310d:	89 75 f8             	mov    %esi,-0x8(%rbp)
  if(!ismp)
ffffffff80103110:	8b 05 ca d2 00 00    	mov    0xd2ca(%rip),%eax        # ffffffff801103e0 <ismp>
ffffffff80103116:	85 c0                	test   %eax,%eax
ffffffff80103118:	74 37                	je     ffffffff80103151 <ioapicenable+0x4f>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
ffffffff8010311a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010311d:	83 c0 20             	add    $0x20,%eax
ffffffff80103120:	89 c2                	mov    %eax,%edx
ffffffff80103122:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103125:	83 c0 08             	add    $0x8,%eax
ffffffff80103128:	01 c0                	add    %eax,%eax
ffffffff8010312a:	89 d6                	mov    %edx,%esi
ffffffff8010312c:	89 c7                	mov    %eax,%edi
ffffffff8010312e:	e8 ea fe ff ff       	call   ffffffff8010301d <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
ffffffff80103133:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80103136:	c1 e0 18             	shl    $0x18,%eax
ffffffff80103139:	89 c2                	mov    %eax,%edx
ffffffff8010313b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010313e:	83 c0 08             	add    $0x8,%eax
ffffffff80103141:	01 c0                	add    %eax,%eax
ffffffff80103143:	83 c0 01             	add    $0x1,%eax
ffffffff80103146:	89 d6                	mov    %edx,%esi
ffffffff80103148:	89 c7                	mov    %eax,%edi
ffffffff8010314a:	e8 ce fe ff ff       	call   ffffffff8010301d <ioapicwrite>
ffffffff8010314f:	eb 01                	jmp    ffffffff80103152 <ioapicenable+0x50>
    return;
ffffffff80103151:	90                   	nop
}
ffffffff80103152:	c9                   	leave
ffffffff80103153:	c3                   	ret

ffffffff80103154 <v2p>:
#endif
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uintp v2p(void *a) { return ((uintp) (a)) - ((uintp)KERNBASE); }
ffffffff80103154:	55                   	push   %rbp
ffffffff80103155:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103158:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff8010315c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80103160:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103164:	ba 00 00 00 80       	mov    $0x80000000,%edx
ffffffff80103169:	48 01 d0             	add    %rdx,%rax
ffffffff8010316c:	c9                   	leave
ffffffff8010316d:	c3                   	ret

ffffffff8010316e <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
ffffffff8010316e:	55                   	push   %rbp
ffffffff8010316f:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103172:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80103176:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010317a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&kmem.lock, "kmem");
ffffffff8010317e:	48 c7 c6 aa 9d 10 80 	mov    $0xffffffff80109daa,%rsi
ffffffff80103185:	48 c7 c7 00 fb 10 80 	mov    $0xffffffff8010fb00,%rdi
ffffffff8010318c:	e8 1d 2a 00 00       	call   ffffffff80105bae <initlock>
  kmem.use_lock = 0;
ffffffff80103191:	c7 05 cd c9 00 00 00 	movl   $0x0,0xc9cd(%rip)        # ffffffff8010fb68 <kmem+0x68>
ffffffff80103198:	00 00 00 
  freerange(vstart, vend);
ffffffff8010319b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff8010319f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801031a3:	48 89 d6             	mov    %rdx,%rsi
ffffffff801031a6:	48 89 c7             	mov    %rax,%rdi
ffffffff801031a9:	e8 33 00 00 00       	call   ffffffff801031e1 <freerange>
}
ffffffff801031ae:	90                   	nop
ffffffff801031af:	c9                   	leave
ffffffff801031b0:	c3                   	ret

ffffffff801031b1 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
ffffffff801031b1:	55                   	push   %rbp
ffffffff801031b2:	48 89 e5             	mov    %rsp,%rbp
ffffffff801031b5:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff801031b9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801031bd:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  freerange(vstart, vend);
ffffffff801031c1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff801031c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801031c9:	48 89 d6             	mov    %rdx,%rsi
ffffffff801031cc:	48 89 c7             	mov    %rax,%rdi
ffffffff801031cf:	e8 0d 00 00 00       	call   ffffffff801031e1 <freerange>
  kmem.use_lock = 1;
ffffffff801031d4:	c7 05 8a c9 00 00 01 	movl   $0x1,0xc98a(%rip)        # ffffffff8010fb68 <kmem+0x68>
ffffffff801031db:	00 00 00 
}
ffffffff801031de:	90                   	nop
ffffffff801031df:	c9                   	leave
ffffffff801031e0:	c3                   	ret

ffffffff801031e1 <freerange>:

void
freerange(void *vstart, void *vend)
{
ffffffff801031e1:	55                   	push   %rbp
ffffffff801031e2:	48 89 e5             	mov    %rsp,%rbp
ffffffff801031e5:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801031e9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801031ed:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *p;
  p = (char*)PGROUNDUP((uintp)vstart);
ffffffff801031f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801031f5:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffffffff801031fb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80103201:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffffffff80103205:	eb 14                	jmp    ffffffff8010321b <freerange+0x3a>
    kfree(p);
ffffffff80103207:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010320b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010320e:	e8 1c 00 00 00       	call   ffffffff8010322f <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffffffff80103213:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffffffff8010321a:	00 
ffffffff8010321b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010321f:	48 05 00 10 00 00    	add    $0x1000,%rax
ffffffff80103225:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
ffffffff80103229:	73 dc                	jae    ffffffff80103207 <freerange+0x26>
}
ffffffff8010322b:	90                   	nop
ffffffff8010322c:	90                   	nop
ffffffff8010322d:	c9                   	leave
ffffffff8010322e:	c3                   	ret

ffffffff8010322f <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
ffffffff8010322f:	55                   	push   %rbp
ffffffff80103230:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103233:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80103237:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct run *r;

  if((uintp)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
ffffffff8010323b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010323f:	25 ff 0f 00 00       	and    $0xfff,%eax
ffffffff80103244:	48 85 c0             	test   %rax,%rax
ffffffff80103247:	75 1e                	jne    ffffffff80103267 <kfree+0x38>
ffffffff80103249:	48 81 7d e8 00 50 11 	cmpq   $0xffffffff80115000,-0x18(%rbp)
ffffffff80103250:	80 
ffffffff80103251:	72 14                	jb     ffffffff80103267 <kfree+0x38>
ffffffff80103253:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103257:	48 89 c7             	mov    %rax,%rdi
ffffffff8010325a:	e8 f5 fe ff ff       	call   ffffffff80103154 <v2p>
ffffffff8010325f:	48 3d ff ff ff 0d    	cmp    $0xdffffff,%rax
ffffffff80103265:	76 0c                	jbe    ffffffff80103273 <kfree+0x44>
    panic("kfree");
ffffffff80103267:	48 c7 c7 af 9d 10 80 	mov    $0xffffffff80109daf,%rdi
ffffffff8010326e:	e8 bc d6 ff ff       	call   ffffffff8010092f <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
ffffffff80103273:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103277:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff8010327c:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80103281:	48 89 c7             	mov    %rax,%rdi
ffffffff80103284:	e8 ca 2c 00 00       	call   ffffffff80105f53 <memset>

  if(kmem.use_lock)
ffffffff80103289:	8b 05 d9 c8 00 00    	mov    0xc8d9(%rip),%eax        # ffffffff8010fb68 <kmem+0x68>
ffffffff8010328f:	85 c0                	test   %eax,%eax
ffffffff80103291:	74 0c                	je     ffffffff8010329f <kfree+0x70>
    acquire(&kmem.lock);
ffffffff80103293:	48 c7 c7 00 fb 10 80 	mov    $0xffffffff8010fb00,%rdi
ffffffff8010329a:	e8 44 29 00 00       	call   ffffffff80105be3 <acquire>
  r = (struct run*)v;
ffffffff8010329f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801032a3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  r->next = kmem.freelist;
ffffffff801032a7:	48 8b 15 c2 c8 00 00 	mov    0xc8c2(%rip),%rdx        # ffffffff8010fb70 <kmem+0x70>
ffffffff801032ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801032b2:	48 89 10             	mov    %rdx,(%rax)
  kmem.freelist = r;
ffffffff801032b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801032b9:	48 89 05 b0 c8 00 00 	mov    %rax,0xc8b0(%rip)        # ffffffff8010fb70 <kmem+0x70>
  if(kmem.use_lock)
ffffffff801032c0:	8b 05 a2 c8 00 00    	mov    0xc8a2(%rip),%eax        # ffffffff8010fb68 <kmem+0x68>
ffffffff801032c6:	85 c0                	test   %eax,%eax
ffffffff801032c8:	74 0c                	je     ffffffff801032d6 <kfree+0xa7>
    release(&kmem.lock);
ffffffff801032ca:	48 c7 c7 00 fb 10 80 	mov    $0xffffffff8010fb00,%rdi
ffffffff801032d1:	e8 e4 29 00 00       	call   ffffffff80105cba <release>
}
ffffffff801032d6:	90                   	nop
ffffffff801032d7:	c9                   	leave
ffffffff801032d8:	c3                   	ret

ffffffff801032d9 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
ffffffff801032d9:	55                   	push   %rbp
ffffffff801032da:	48 89 e5             	mov    %rsp,%rbp
ffffffff801032dd:	48 83 ec 10          	sub    $0x10,%rsp
  struct run *r;

  if(kmem.use_lock)
ffffffff801032e1:	8b 05 81 c8 00 00    	mov    0xc881(%rip),%eax        # ffffffff8010fb68 <kmem+0x68>
ffffffff801032e7:	85 c0                	test   %eax,%eax
ffffffff801032e9:	74 0c                	je     ffffffff801032f7 <kalloc+0x1e>
    acquire(&kmem.lock);
ffffffff801032eb:	48 c7 c7 00 fb 10 80 	mov    $0xffffffff8010fb00,%rdi
ffffffff801032f2:	e8 ec 28 00 00       	call   ffffffff80105be3 <acquire>
  r = kmem.freelist;
ffffffff801032f7:	48 8b 05 72 c8 00 00 	mov    0xc872(%rip),%rax        # ffffffff8010fb70 <kmem+0x70>
ffffffff801032fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(r)
ffffffff80103302:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80103307:	74 0e                	je     ffffffff80103317 <kalloc+0x3e>
    kmem.freelist = r->next;
ffffffff80103309:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010330d:	48 8b 00             	mov    (%rax),%rax
ffffffff80103310:	48 89 05 59 c8 00 00 	mov    %rax,0xc859(%rip)        # ffffffff8010fb70 <kmem+0x70>
  if(kmem.use_lock)
ffffffff80103317:	8b 05 4b c8 00 00    	mov    0xc84b(%rip),%eax        # ffffffff8010fb68 <kmem+0x68>
ffffffff8010331d:	85 c0                	test   %eax,%eax
ffffffff8010331f:	74 0c                	je     ffffffff8010332d <kalloc+0x54>
    release(&kmem.lock);
ffffffff80103321:	48 c7 c7 00 fb 10 80 	mov    $0xffffffff8010fb00,%rdi
ffffffff80103328:	e8 8d 29 00 00       	call   ffffffff80105cba <release>
  return (char*)r;
ffffffff8010332d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80103331:	c9                   	leave
ffffffff80103332:	c3                   	ret

ffffffff80103333 <inb>:
{
ffffffff80103333:	55                   	push   %rbp
ffffffff80103334:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103337:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff8010333b:	89 f8                	mov    %edi,%eax
ffffffff8010333d:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffffffff80103341:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffffffff80103345:	89 c2                	mov    %eax,%edx
ffffffff80103347:	ec                   	in     (%dx),%al
ffffffff80103348:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffffffff8010334b:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffffffff8010334f:	c9                   	leave
ffffffff80103350:	c3                   	ret

ffffffff80103351 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
ffffffff80103351:	55                   	push   %rbp
ffffffff80103352:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103355:	48 83 ec 10          	sub    $0x10,%rsp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
ffffffff80103359:	bf 64 00 00 00       	mov    $0x64,%edi
ffffffff8010335e:	e8 d0 ff ff ff       	call   ffffffff80103333 <inb>
ffffffff80103363:	0f b6 c0             	movzbl %al,%eax
ffffffff80103366:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((st & KBS_DIB) == 0)
ffffffff80103369:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff8010336c:	83 e0 01             	and    $0x1,%eax
ffffffff8010336f:	85 c0                	test   %eax,%eax
ffffffff80103371:	75 0a                	jne    ffffffff8010337d <kbdgetc+0x2c>
    return -1;
ffffffff80103373:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80103378:	e9 32 01 00 00       	jmp    ffffffff801034af <kbdgetc+0x15e>
  data = inb(KBDATAP);
ffffffff8010337d:	bf 60 00 00 00       	mov    $0x60,%edi
ffffffff80103382:	e8 ac ff ff ff       	call   ffffffff80103333 <inb>
ffffffff80103387:	0f b6 c0             	movzbl %al,%eax
ffffffff8010338a:	89 45 fc             	mov    %eax,-0x4(%rbp)

  if(data == 0xE0){
ffffffff8010338d:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%rbp)
ffffffff80103394:	75 19                	jne    ffffffff801033af <kbdgetc+0x5e>
    shift |= E0ESC;
ffffffff80103396:	8b 05 dc c7 00 00    	mov    0xc7dc(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff8010339c:	83 c8 40             	or     $0x40,%eax
ffffffff8010339f:	89 05 d3 c7 00 00    	mov    %eax,0xc7d3(%rip)        # ffffffff8010fb78 <shift.1>
    return 0;
ffffffff801033a5:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801033aa:	e9 00 01 00 00       	jmp    ffffffff801034af <kbdgetc+0x15e>
  } else if(data & 0x80){
ffffffff801033af:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801033b2:	25 80 00 00 00       	and    $0x80,%eax
ffffffff801033b7:	85 c0                	test   %eax,%eax
ffffffff801033b9:	74 47                	je     ffffffff80103402 <kbdgetc+0xb1>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
ffffffff801033bb:	8b 05 b7 c7 00 00    	mov    0xc7b7(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff801033c1:	83 e0 40             	and    $0x40,%eax
ffffffff801033c4:	85 c0                	test   %eax,%eax
ffffffff801033c6:	75 08                	jne    ffffffff801033d0 <kbdgetc+0x7f>
ffffffff801033c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801033cb:	83 e0 7f             	and    $0x7f,%eax
ffffffff801033ce:	eb 03                	jmp    ffffffff801033d3 <kbdgetc+0x82>
ffffffff801033d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801033d3:	89 45 fc             	mov    %eax,-0x4(%rbp)
    shift &= ~(shiftcode[data] | E0ESC);
ffffffff801033d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801033d9:	0f b6 80 20 b0 10 80 	movzbl -0x7fef4fe0(%rax),%eax
ffffffff801033e0:	83 c8 40             	or     $0x40,%eax
ffffffff801033e3:	0f b6 c0             	movzbl %al,%eax
ffffffff801033e6:	f7 d0                	not    %eax
ffffffff801033e8:	89 c2                	mov    %eax,%edx
ffffffff801033ea:	8b 05 88 c7 00 00    	mov    0xc788(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff801033f0:	21 d0                	and    %edx,%eax
ffffffff801033f2:	89 05 80 c7 00 00    	mov    %eax,0xc780(%rip)        # ffffffff8010fb78 <shift.1>
    return 0;
ffffffff801033f8:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801033fd:	e9 ad 00 00 00       	jmp    ffffffff801034af <kbdgetc+0x15e>
  } else if(shift & E0ESC){
ffffffff80103402:	8b 05 70 c7 00 00    	mov    0xc770(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff80103408:	83 e0 40             	and    $0x40,%eax
ffffffff8010340b:	85 c0                	test   %eax,%eax
ffffffff8010340d:	74 16                	je     ffffffff80103425 <kbdgetc+0xd4>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
ffffffff8010340f:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%rbp)
    shift &= ~E0ESC;
ffffffff80103416:	8b 05 5c c7 00 00    	mov    0xc75c(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff8010341c:	83 e0 bf             	and    $0xffffffbf,%eax
ffffffff8010341f:	89 05 53 c7 00 00    	mov    %eax,0xc753(%rip)        # ffffffff8010fb78 <shift.1>
  }

  shift |= shiftcode[data];
ffffffff80103425:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103428:	0f b6 80 20 b0 10 80 	movzbl -0x7fef4fe0(%rax),%eax
ffffffff8010342f:	0f b6 d0             	movzbl %al,%edx
ffffffff80103432:	8b 05 40 c7 00 00    	mov    0xc740(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff80103438:	09 d0                	or     %edx,%eax
ffffffff8010343a:	89 05 38 c7 00 00    	mov    %eax,0xc738(%rip)        # ffffffff8010fb78 <shift.1>
  shift ^= togglecode[data];
ffffffff80103440:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103443:	0f b6 80 20 b1 10 80 	movzbl -0x7fef4ee0(%rax),%eax
ffffffff8010344a:	0f b6 d0             	movzbl %al,%edx
ffffffff8010344d:	8b 05 25 c7 00 00    	mov    0xc725(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff80103453:	31 d0                	xor    %edx,%eax
ffffffff80103455:	89 05 1d c7 00 00    	mov    %eax,0xc71d(%rip)        # ffffffff8010fb78 <shift.1>
  c = charcode[shift & (CTL | SHIFT)][data];
ffffffff8010345b:	8b 05 17 c7 00 00    	mov    0xc717(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff80103461:	83 e0 03             	and    $0x3,%eax
ffffffff80103464:	89 c0                	mov    %eax,%eax
ffffffff80103466:	48 8b 14 c5 20 b5 10 	mov    -0x7fef4ae0(,%rax,8),%rdx
ffffffff8010346d:	80 
ffffffff8010346e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103471:	48 01 d0             	add    %rdx,%rax
ffffffff80103474:	0f b6 00             	movzbl (%rax),%eax
ffffffff80103477:	0f b6 c0             	movzbl %al,%eax
ffffffff8010347a:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(shift & CAPSLOCK){
ffffffff8010347d:	8b 05 f5 c6 00 00    	mov    0xc6f5(%rip),%eax        # ffffffff8010fb78 <shift.1>
ffffffff80103483:	83 e0 08             	and    $0x8,%eax
ffffffff80103486:	85 c0                	test   %eax,%eax
ffffffff80103488:	74 22                	je     ffffffff801034ac <kbdgetc+0x15b>
    if('a' <= c && c <= 'z')
ffffffff8010348a:	83 7d f8 60          	cmpl   $0x60,-0x8(%rbp)
ffffffff8010348e:	76 0c                	jbe    ffffffff8010349c <kbdgetc+0x14b>
ffffffff80103490:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%rbp)
ffffffff80103494:	77 06                	ja     ffffffff8010349c <kbdgetc+0x14b>
      c += 'A' - 'a';
ffffffff80103496:	83 6d f8 20          	subl   $0x20,-0x8(%rbp)
ffffffff8010349a:	eb 10                	jmp    ffffffff801034ac <kbdgetc+0x15b>
    else if('A' <= c && c <= 'Z')
ffffffff8010349c:	83 7d f8 40          	cmpl   $0x40,-0x8(%rbp)
ffffffff801034a0:	76 0a                	jbe    ffffffff801034ac <kbdgetc+0x15b>
ffffffff801034a2:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%rbp)
ffffffff801034a6:	77 04                	ja     ffffffff801034ac <kbdgetc+0x15b>
      c += 'a' - 'A';
ffffffff801034a8:	83 45 f8 20          	addl   $0x20,-0x8(%rbp)
  }
  return c;
ffffffff801034ac:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffffffff801034af:	c9                   	leave
ffffffff801034b0:	c3                   	ret

ffffffff801034b1 <kbdintr>:

void
kbdintr(void)
{
ffffffff801034b1:	55                   	push   %rbp
ffffffff801034b2:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(kbdgetc);
ffffffff801034b5:	48 c7 c7 51 33 10 80 	mov    $0xffffffff80103351,%rdi
ffffffff801034bc:	e8 02 d7 ff ff       	call   ffffffff80100bc3 <consoleintr>
}
ffffffff801034c1:	90                   	nop
ffffffff801034c2:	5d                   	pop    %rbp
ffffffff801034c3:	c3                   	ret

ffffffff801034c4 <outb>:
{
ffffffff801034c4:	55                   	push   %rbp
ffffffff801034c5:	48 89 e5             	mov    %rsp,%rbp
ffffffff801034c8:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801034cc:	89 fa                	mov    %edi,%edx
ffffffff801034ce:	89 f0                	mov    %esi,%eax
ffffffff801034d0:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff801034d4:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff801034d7:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff801034db:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff801034df:	ee                   	out    %al,(%dx)
}
ffffffff801034e0:	90                   	nop
ffffffff801034e1:	c9                   	leave
ffffffff801034e2:	c3                   	ret

ffffffff801034e3 <readeflags>:
{
ffffffff801034e3:	55                   	push   %rbp
ffffffff801034e4:	48 89 e5             	mov    %rsp,%rbp
ffffffff801034e7:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffffffff801034eb:	9c                   	pushf
ffffffff801034ec:	58                   	pop    %rax
ffffffff801034ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffffffff801034f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff801034f5:	c9                   	leave
ffffffff801034f6:	c3                   	ret

ffffffff801034f7 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
ffffffff801034f7:	55                   	push   %rbp
ffffffff801034f8:	48 89 e5             	mov    %rsp,%rbp
ffffffff801034fb:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801034ff:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff80103502:	89 75 f8             	mov    %esi,-0x8(%rbp)
  lapic[index] = value;
ffffffff80103505:	48 8b 05 74 c6 00 00 	mov    0xc674(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff8010350c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010350f:	48 63 d2             	movslq %edx,%rdx
ffffffff80103512:	48 c1 e2 02          	shl    $0x2,%rdx
ffffffff80103516:	48 01 c2             	add    %rax,%rdx
ffffffff80103519:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff8010351c:	89 02                	mov    %eax,(%rdx)
  lapic[ID];  // wait for write to finish, by reading
ffffffff8010351e:	48 8b 05 5b c6 00 00 	mov    0xc65b(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff80103525:	48 83 c0 20          	add    $0x20,%rax
ffffffff80103529:	8b 00                	mov    (%rax),%eax
}
ffffffff8010352b:	90                   	nop
ffffffff8010352c:	c9                   	leave
ffffffff8010352d:	c3                   	ret

ffffffff8010352e <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
ffffffff8010352e:	55                   	push   %rbp
ffffffff8010352f:	48 89 e5             	mov    %rsp,%rbp
  if(!lapic) 
ffffffff80103532:	48 8b 05 47 c6 00 00 	mov    0xc647(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff80103539:	48 85 c0             	test   %rax,%rax
ffffffff8010353c:	0f 84 06 01 00 00    	je     ffffffff80103648 <lapicinit+0x11a>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
ffffffff80103542:	be 3f 01 00 00       	mov    $0x13f,%esi
ffffffff80103547:	bf 3c 00 00 00       	mov    $0x3c,%edi
ffffffff8010354c:	e8 a6 ff ff ff       	call   ffffffff801034f7 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
ffffffff80103551:	be 0b 00 00 00       	mov    $0xb,%esi
ffffffff80103556:	bf f8 00 00 00       	mov    $0xf8,%edi
ffffffff8010355b:	e8 97 ff ff ff       	call   ffffffff801034f7 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
ffffffff80103560:	be 20 00 02 00       	mov    $0x20020,%esi
ffffffff80103565:	bf c8 00 00 00       	mov    $0xc8,%edi
ffffffff8010356a:	e8 88 ff ff ff       	call   ffffffff801034f7 <lapicw>
  lapicw(TICR, 10000000); 
ffffffff8010356f:	be 80 96 98 00       	mov    $0x989680,%esi
ffffffff80103574:	bf e0 00 00 00       	mov    $0xe0,%edi
ffffffff80103579:	e8 79 ff ff ff       	call   ffffffff801034f7 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
ffffffff8010357e:	be 00 00 01 00       	mov    $0x10000,%esi
ffffffff80103583:	bf d4 00 00 00       	mov    $0xd4,%edi
ffffffff80103588:	e8 6a ff ff ff       	call   ffffffff801034f7 <lapicw>
  lapicw(LINT1, MASKED);
ffffffff8010358d:	be 00 00 01 00       	mov    $0x10000,%esi
ffffffff80103592:	bf d8 00 00 00       	mov    $0xd8,%edi
ffffffff80103597:	e8 5b ff ff ff       	call   ffffffff801034f7 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
ffffffff8010359c:	48 8b 05 dd c5 00 00 	mov    0xc5dd(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff801035a3:	48 83 c0 30          	add    $0x30,%rax
ffffffff801035a7:	8b 00                	mov    (%rax),%eax
ffffffff801035a9:	c1 e8 10             	shr    $0x10,%eax
ffffffff801035ac:	25 fc 00 00 00       	and    $0xfc,%eax
ffffffff801035b1:	85 c0                	test   %eax,%eax
ffffffff801035b3:	74 0f                	je     ffffffff801035c4 <lapicinit+0x96>
    lapicw(PCINT, MASKED);
ffffffff801035b5:	be 00 00 01 00       	mov    $0x10000,%esi
ffffffff801035ba:	bf d0 00 00 00       	mov    $0xd0,%edi
ffffffff801035bf:	e8 33 ff ff ff       	call   ffffffff801034f7 <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
ffffffff801035c4:	be 33 00 00 00       	mov    $0x33,%esi
ffffffff801035c9:	bf dc 00 00 00       	mov    $0xdc,%edi
ffffffff801035ce:	e8 24 ff ff ff       	call   ffffffff801034f7 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
ffffffff801035d3:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801035d8:	bf a0 00 00 00       	mov    $0xa0,%edi
ffffffff801035dd:	e8 15 ff ff ff       	call   ffffffff801034f7 <lapicw>
  lapicw(ESR, 0);
ffffffff801035e2:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801035e7:	bf a0 00 00 00       	mov    $0xa0,%edi
ffffffff801035ec:	e8 06 ff ff ff       	call   ffffffff801034f7 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
ffffffff801035f1:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801035f6:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffffffff801035fb:	e8 f7 fe ff ff       	call   ffffffff801034f7 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
ffffffff80103600:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80103605:	bf c4 00 00 00       	mov    $0xc4,%edi
ffffffff8010360a:	e8 e8 fe ff ff       	call   ffffffff801034f7 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
ffffffff8010360f:	be 00 85 08 00       	mov    $0x88500,%esi
ffffffff80103614:	bf c0 00 00 00       	mov    $0xc0,%edi
ffffffff80103619:	e8 d9 fe ff ff       	call   ffffffff801034f7 <lapicw>
  while(lapic[ICRLO] & DELIVS)
ffffffff8010361e:	90                   	nop
ffffffff8010361f:	48 8b 05 5a c5 00 00 	mov    0xc55a(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff80103626:	48 05 00 03 00 00    	add    $0x300,%rax
ffffffff8010362c:	8b 00                	mov    (%rax),%eax
ffffffff8010362e:	25 00 10 00 00       	and    $0x1000,%eax
ffffffff80103633:	85 c0                	test   %eax,%eax
ffffffff80103635:	75 e8                	jne    ffffffff8010361f <lapicinit+0xf1>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
ffffffff80103637:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff8010363c:	bf 20 00 00 00       	mov    $0x20,%edi
ffffffff80103641:	e8 b1 fe ff ff       	call   ffffffff801034f7 <lapicw>
ffffffff80103646:	eb 01                	jmp    ffffffff80103649 <lapicinit+0x11b>
    return;
ffffffff80103648:	90                   	nop
}
ffffffff80103649:	5d                   	pop    %rbp
ffffffff8010364a:	c3                   	ret

ffffffff8010364b <cpunum>:
// This is only used during secondary processor startup.
// cpu->id is the fast way to get the cpu number, once the
// processor is fully started.
int
cpunum(void)
{
ffffffff8010364b:	55                   	push   %rbp
ffffffff8010364c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010364f:	48 83 ec 10          	sub    $0x10,%rsp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
ffffffff80103653:	e8 8b fe ff ff       	call   ffffffff801034e3 <readeflags>
ffffffff80103658:	25 00 02 00 00       	and    $0x200,%eax
ffffffff8010365d:	48 85 c0             	test   %rax,%rax
ffffffff80103660:	74 2b                	je     ffffffff8010368d <cpunum+0x42>
    static int n;
    if(n++ == 0)
ffffffff80103662:	8b 05 20 c5 00 00    	mov    0xc520(%rip),%eax        # ffffffff8010fb88 <n.0>
ffffffff80103668:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff8010366b:	89 15 17 c5 00 00    	mov    %edx,0xc517(%rip)        # ffffffff8010fb88 <n.0>
ffffffff80103671:	85 c0                	test   %eax,%eax
ffffffff80103673:	75 18                	jne    ffffffff8010368d <cpunum+0x42>
      cprintf("cpu called from %x with interrupts enabled\n",
ffffffff80103675:	48 8b 45 08          	mov    0x8(%rbp),%rax
ffffffff80103679:	48 89 c6             	mov    %rax,%rsi
ffffffff8010367c:	48 c7 c7 b8 9d 10 80 	mov    $0xffffffff80109db8,%rdi
ffffffff80103683:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80103688:	e8 17 cf ff ff       	call   ffffffff801005a4 <cprintf>
        __builtin_return_address(0));
  }

  if(!lapic)
ffffffff8010368d:	48 8b 05 ec c4 00 00 	mov    0xc4ec(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff80103694:	48 85 c0             	test   %rax,%rax
ffffffff80103697:	75 07                	jne    ffffffff801036a0 <cpunum+0x55>
    return 0;
ffffffff80103699:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010369e:	eb 5a                	jmp    ffffffff801036fa <cpunum+0xaf>

  id = lapic[ID]>>24;
ffffffff801036a0:	48 8b 05 d9 c4 00 00 	mov    0xc4d9(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff801036a7:	48 83 c0 20          	add    $0x20,%rax
ffffffff801036ab:	8b 00                	mov    (%rax),%eax
ffffffff801036ad:	c1 e8 18             	shr    $0x18,%eax
ffffffff801036b0:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (n = 0; n < ncpu; n++)
ffffffff801036b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801036ba:	eb 2e                	jmp    ffffffff801036ea <cpunum+0x9f>
    if (id == cpus[n].apicid)
ffffffff801036bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801036bf:	48 63 d0             	movslq %eax,%rdx
ffffffff801036c2:	48 89 d0             	mov    %rdx,%rax
ffffffff801036c5:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801036c9:	48 29 d0             	sub    %rdx,%rax
ffffffff801036cc:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801036d0:	48 05 61 fc 10 80    	add    $0xffffffff8010fc61,%rax
ffffffff801036d6:	0f b6 00             	movzbl (%rax),%eax
ffffffff801036d9:	0f b6 c0             	movzbl %al,%eax
ffffffff801036dc:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffffffff801036df:	75 05                	jne    ffffffff801036e6 <cpunum+0x9b>
      return n;
ffffffff801036e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801036e4:	eb 14                	jmp    ffffffff801036fa <cpunum+0xaf>
  for (n = 0; n < ncpu; n++)
ffffffff801036e6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801036ea:	8b 05 f4 cc 00 00    	mov    0xccf4(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff801036f0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff801036f3:	7c c7                	jl     ffffffff801036bc <cpunum+0x71>

  return 0;
ffffffff801036f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801036fa:	c9                   	leave
ffffffff801036fb:	c3                   	ret

ffffffff801036fc <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
ffffffff801036fc:	55                   	push   %rbp
ffffffff801036fd:	48 89 e5             	mov    %rsp,%rbp
  if(lapic)
ffffffff80103700:	48 8b 05 79 c4 00 00 	mov    0xc479(%rip),%rax        # ffffffff8010fb80 <lapic>
ffffffff80103707:	48 85 c0             	test   %rax,%rax
ffffffff8010370a:	74 0f                	je     ffffffff8010371b <lapiceoi+0x1f>
    lapicw(EOI, 0);
ffffffff8010370c:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80103711:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffffffff80103716:	e8 dc fd ff ff       	call   ffffffff801034f7 <lapicw>
}
ffffffff8010371b:	90                   	nop
ffffffff8010371c:	5d                   	pop    %rbp
ffffffff8010371d:	c3                   	ret

ffffffff8010371e <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
ffffffff8010371e:	55                   	push   %rbp
ffffffff8010371f:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103722:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103726:	89 7d fc             	mov    %edi,-0x4(%rbp)
}
ffffffff80103729:	90                   	nop
ffffffff8010372a:	c9                   	leave
ffffffff8010372b:	c3                   	ret

ffffffff8010372c <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
ffffffff8010372c:	55                   	push   %rbp
ffffffff8010372d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103730:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80103734:	89 f8                	mov    %edi,%eax
ffffffff80103736:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffffffff80103739:	88 45 ec             	mov    %al,-0x14(%rbp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
ffffffff8010373c:	be 0f 00 00 00       	mov    $0xf,%esi
ffffffff80103741:	bf 70 00 00 00       	mov    $0x70,%edi
ffffffff80103746:	e8 79 fd ff ff       	call   ffffffff801034c4 <outb>
  outb(IO_RTC+1, 0x0A);
ffffffff8010374b:	be 0a 00 00 00       	mov    $0xa,%esi
ffffffff80103750:	bf 71 00 00 00       	mov    $0x71,%edi
ffffffff80103755:	e8 6a fd ff ff       	call   ffffffff801034c4 <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
ffffffff8010375a:	48 c7 45 f0 67 04 00 	movq   $0xffffffff80000467,-0x10(%rbp)
ffffffff80103761:	80 
  wrv[0] = 0;
ffffffff80103762:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103766:	66 c7 00 00 00       	movw   $0x0,(%rax)
  wrv[1] = addr >> 4;
ffffffff8010376b:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffffffff8010376e:	c1 e8 04             	shr    $0x4,%eax
ffffffff80103771:	89 c2                	mov    %eax,%edx
ffffffff80103773:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103777:	48 83 c0 02          	add    $0x2,%rax
ffffffff8010377b:	66 89 10             	mov    %dx,(%rax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
ffffffff8010377e:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffffffff80103782:	c1 e0 18             	shl    $0x18,%eax
ffffffff80103785:	89 c6                	mov    %eax,%esi
ffffffff80103787:	bf c4 00 00 00       	mov    $0xc4,%edi
ffffffff8010378c:	e8 66 fd ff ff       	call   ffffffff801034f7 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
ffffffff80103791:	be 00 c5 00 00       	mov    $0xc500,%esi
ffffffff80103796:	bf c0 00 00 00       	mov    $0xc0,%edi
ffffffff8010379b:	e8 57 fd ff ff       	call   ffffffff801034f7 <lapicw>
  microdelay(200);
ffffffff801037a0:	bf c8 00 00 00       	mov    $0xc8,%edi
ffffffff801037a5:	e8 74 ff ff ff       	call   ffffffff8010371e <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
ffffffff801037aa:	be 00 85 00 00       	mov    $0x8500,%esi
ffffffff801037af:	bf c0 00 00 00       	mov    $0xc0,%edi
ffffffff801037b4:	e8 3e fd ff ff       	call   ffffffff801034f7 <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
ffffffff801037b9:	bf 64 00 00 00       	mov    $0x64,%edi
ffffffff801037be:	e8 5b ff ff ff       	call   ffffffff8010371e <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
ffffffff801037c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801037ca:	eb 36                	jmp    ffffffff80103802 <lapicstartap+0xd6>
    lapicw(ICRHI, apicid<<24);
ffffffff801037cc:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffffffff801037d0:	c1 e0 18             	shl    $0x18,%eax
ffffffff801037d3:	89 c6                	mov    %eax,%esi
ffffffff801037d5:	bf c4 00 00 00       	mov    $0xc4,%edi
ffffffff801037da:	e8 18 fd ff ff       	call   ffffffff801034f7 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
ffffffff801037df:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffffffff801037e2:	c1 e8 0c             	shr    $0xc,%eax
ffffffff801037e5:	80 cc 06             	or     $0x6,%ah
ffffffff801037e8:	89 c6                	mov    %eax,%esi
ffffffff801037ea:	bf c0 00 00 00       	mov    $0xc0,%edi
ffffffff801037ef:	e8 03 fd ff ff       	call   ffffffff801034f7 <lapicw>
    microdelay(200);
ffffffff801037f4:	bf c8 00 00 00       	mov    $0xc8,%edi
ffffffff801037f9:	e8 20 ff ff ff       	call   ffffffff8010371e <microdelay>
  for(i = 0; i < 2; i++){
ffffffff801037fe:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103802:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffffffff80103806:	7e c4                	jle    ffffffff801037cc <lapicstartap+0xa0>
  }
}
ffffffff80103808:	90                   	nop
ffffffff80103809:	90                   	nop
ffffffff8010380a:	c9                   	leave
ffffffff8010380b:	c3                   	ret

ffffffff8010380c <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
ffffffff8010380c:	55                   	push   %rbp
ffffffff8010380d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103810:	48 83 ec 10          	sub    $0x10,%rsp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
ffffffff80103814:	48 c7 c6 e4 9d 10 80 	mov    $0xffffffff80109de4,%rsi
ffffffff8010381b:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103822:	e8 87 23 00 00       	call   ffffffff80105bae <initlock>
  readsb(ROOTDEV, &sb);
ffffffff80103827:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff8010382b:	48 89 c6             	mov    %rax,%rsi
ffffffff8010382e:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80103833:	e8 87 e0 ff ff       	call   ffffffff801018bf <readsb>
  log.start = sb.size - sb.nlog;
ffffffff80103838:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffffffff8010383b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010383e:	29 c2                	sub    %eax,%edx
ffffffff80103840:	89 d0                	mov    %edx,%eax
ffffffff80103842:	89 05 c0 c3 00 00    	mov    %eax,0xc3c0(%rip)        # ffffffff8010fc08 <log+0x68>
  log.size = sb.nlog;
ffffffff80103848:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010384b:	89 05 bb c3 00 00    	mov    %eax,0xc3bb(%rip)        # ffffffff8010fc0c <log+0x6c>
  log.dev = ROOTDEV;
ffffffff80103851:	c7 05 b9 c3 00 00 01 	movl   $0x1,0xc3b9(%rip)        # ffffffff8010fc14 <log+0x74>
ffffffff80103858:	00 00 00 
  recover_from_log();
ffffffff8010385b:	e8 c7 01 00 00       	call   ffffffff80103a27 <recover_from_log>
}
ffffffff80103860:	90                   	nop
ffffffff80103861:	c9                   	leave
ffffffff80103862:	c3                   	ret

ffffffff80103863 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
ffffffff80103863:	55                   	push   %rbp
ffffffff80103864:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103867:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffffffff8010386b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80103872:	e9 90 00 00 00       	jmp    ffffffff80103907 <install_trans+0xa4>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
ffffffff80103877:	8b 15 8b c3 00 00    	mov    0xc38b(%rip),%edx        # ffffffff8010fc08 <log+0x68>
ffffffff8010387d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103880:	01 d0                	add    %edx,%eax
ffffffff80103882:	83 c0 01             	add    $0x1,%eax
ffffffff80103885:	89 c2                	mov    %eax,%edx
ffffffff80103887:	8b 05 87 c3 00 00    	mov    0xc387(%rip),%eax        # ffffffff8010fc14 <log+0x74>
ffffffff8010388d:	89 d6                	mov    %edx,%esi
ffffffff8010388f:	89 c7                	mov    %eax,%edi
ffffffff80103891:	e8 41 ca ff ff       	call   ffffffff801002d7 <bread>
ffffffff80103896:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
ffffffff8010389a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010389d:	48 98                	cltq
ffffffff8010389f:	48 83 c0 1c          	add    $0x1c,%rax
ffffffff801038a3:	8b 04 85 ac fb 10 80 	mov    -0x7fef0454(,%rax,4),%eax
ffffffff801038aa:	89 c2                	mov    %eax,%edx
ffffffff801038ac:	8b 05 62 c3 00 00    	mov    0xc362(%rip),%eax        # ffffffff8010fc14 <log+0x74>
ffffffff801038b2:	89 d6                	mov    %edx,%esi
ffffffff801038b4:	89 c7                	mov    %eax,%edi
ffffffff801038b6:	e8 1c ca ff ff       	call   ffffffff801002d7 <bread>
ffffffff801038bb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
ffffffff801038bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801038c3:	48 8d 48 28          	lea    0x28(%rax),%rcx
ffffffff801038c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801038cb:	48 83 c0 28          	add    $0x28,%rax
ffffffff801038cf:	ba 00 02 00 00       	mov    $0x200,%edx
ffffffff801038d4:	48 89 ce             	mov    %rcx,%rsi
ffffffff801038d7:	48 89 c7             	mov    %rax,%rdi
ffffffff801038da:	e8 63 27 00 00       	call   ffffffff80106042 <memmove>
    bwrite(dbuf);  // write dst to disk
ffffffff801038df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801038e3:	48 89 c7             	mov    %rax,%rdi
ffffffff801038e6:	e8 2c ca ff ff       	call   ffffffff80100317 <bwrite>
    brelse(lbuf); 
ffffffff801038eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801038ef:	48 89 c7             	mov    %rax,%rdi
ffffffff801038f2:	e8 65 ca ff ff       	call   ffffffff8010035c <brelse>
    brelse(dbuf);
ffffffff801038f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801038fb:	48 89 c7             	mov    %rax,%rdi
ffffffff801038fe:	e8 59 ca ff ff       	call   ffffffff8010035c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
ffffffff80103903:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103907:	8b 05 0b c3 00 00    	mov    0xc30b(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff8010390d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff80103910:	0f 8c 61 ff ff ff    	jl     ffffffff80103877 <install_trans+0x14>
  }
}
ffffffff80103916:	90                   	nop
ffffffff80103917:	90                   	nop
ffffffff80103918:	c9                   	leave
ffffffff80103919:	c3                   	ret

ffffffff8010391a <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
ffffffff8010391a:	55                   	push   %rbp
ffffffff8010391b:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010391e:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffffffff80103922:	8b 05 e0 c2 00 00    	mov    0xc2e0(%rip),%eax        # ffffffff8010fc08 <log+0x68>
ffffffff80103928:	89 c2                	mov    %eax,%edx
ffffffff8010392a:	8b 05 e4 c2 00 00    	mov    0xc2e4(%rip),%eax        # ffffffff8010fc14 <log+0x74>
ffffffff80103930:	89 d6                	mov    %edx,%esi
ffffffff80103932:	89 c7                	mov    %eax,%edi
ffffffff80103934:	e8 9e c9 ff ff       	call   ffffffff801002d7 <bread>
ffffffff80103939:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *lh = (struct logheader *) (buf->data);
ffffffff8010393d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103941:	48 83 c0 28          	add    $0x28,%rax
ffffffff80103945:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  log.lh.n = lh->n;
ffffffff80103949:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010394d:	8b 00                	mov    (%rax),%eax
ffffffff8010394f:	89 05 c3 c2 00 00    	mov    %eax,0xc2c3(%rip)        # ffffffff8010fc18 <log+0x78>
  for (i = 0; i < log.lh.n; i++) {
ffffffff80103955:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff8010395c:	eb 23                	jmp    ffffffff80103981 <read_head+0x67>
    log.lh.sector[i] = lh->sector[i];
ffffffff8010395e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103962:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80103965:	48 63 d2             	movslq %edx,%rdx
ffffffff80103968:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffffffff8010396c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010396f:	48 63 d2             	movslq %edx,%rdx
ffffffff80103972:	48 83 c2 1c          	add    $0x1c,%rdx
ffffffff80103976:	89 04 95 ac fb 10 80 	mov    %eax,-0x7fef0454(,%rdx,4)
  for (i = 0; i < log.lh.n; i++) {
ffffffff8010397d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103981:	8b 05 91 c2 00 00    	mov    0xc291(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103987:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff8010398a:	7c d2                	jl     ffffffff8010395e <read_head+0x44>
  }
  brelse(buf);
ffffffff8010398c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103990:	48 89 c7             	mov    %rax,%rdi
ffffffff80103993:	e8 c4 c9 ff ff       	call   ffffffff8010035c <brelse>
}
ffffffff80103998:	90                   	nop
ffffffff80103999:	c9                   	leave
ffffffff8010399a:	c3                   	ret

ffffffff8010399b <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
ffffffff8010399b:	55                   	push   %rbp
ffffffff8010399c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010399f:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffffffff801039a3:	8b 05 5f c2 00 00    	mov    0xc25f(%rip),%eax        # ffffffff8010fc08 <log+0x68>
ffffffff801039a9:	89 c2                	mov    %eax,%edx
ffffffff801039ab:	8b 05 63 c2 00 00    	mov    0xc263(%rip),%eax        # ffffffff8010fc14 <log+0x74>
ffffffff801039b1:	89 d6                	mov    %edx,%esi
ffffffff801039b3:	89 c7                	mov    %eax,%edi
ffffffff801039b5:	e8 1d c9 ff ff       	call   ffffffff801002d7 <bread>
ffffffff801039ba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *hb = (struct logheader *) (buf->data);
ffffffff801039be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801039c2:	48 83 c0 28          	add    $0x28,%rax
ffffffff801039c6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  hb->n = log.lh.n;
ffffffff801039ca:	8b 15 48 c2 00 00    	mov    0xc248(%rip),%edx        # ffffffff8010fc18 <log+0x78>
ffffffff801039d0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801039d4:	89 10                	mov    %edx,(%rax)
  for (i = 0; i < log.lh.n; i++) {
ffffffff801039d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff801039dd:	eb 22                	jmp    ffffffff80103a01 <write_head+0x66>
    hb->sector[i] = log.lh.sector[i];
ffffffff801039df:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801039e2:	48 98                	cltq
ffffffff801039e4:	48 83 c0 1c          	add    $0x1c,%rax
ffffffff801039e8:	8b 0c 85 ac fb 10 80 	mov    -0x7fef0454(,%rax,4),%ecx
ffffffff801039ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801039f3:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801039f6:	48 63 d2             	movslq %edx,%rdx
ffffffff801039f9:	89 4c 90 04          	mov    %ecx,0x4(%rax,%rdx,4)
  for (i = 0; i < log.lh.n; i++) {
ffffffff801039fd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103a01:	8b 05 11 c2 00 00    	mov    0xc211(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103a07:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff80103a0a:	7c d3                	jl     ffffffff801039df <write_head+0x44>
  }
  bwrite(buf);
ffffffff80103a0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103a10:	48 89 c7             	mov    %rax,%rdi
ffffffff80103a13:	e8 ff c8 ff ff       	call   ffffffff80100317 <bwrite>
  brelse(buf);
ffffffff80103a18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103a1c:	48 89 c7             	mov    %rax,%rdi
ffffffff80103a1f:	e8 38 c9 ff ff       	call   ffffffff8010035c <brelse>
}
ffffffff80103a24:	90                   	nop
ffffffff80103a25:	c9                   	leave
ffffffff80103a26:	c3                   	ret

ffffffff80103a27 <recover_from_log>:

static void
recover_from_log(void)
{
ffffffff80103a27:	55                   	push   %rbp
ffffffff80103a28:	48 89 e5             	mov    %rsp,%rbp
  read_head();      
ffffffff80103a2b:	e8 ea fe ff ff       	call   ffffffff8010391a <read_head>
  install_trans(); // if committed, copy from log to disk
ffffffff80103a30:	e8 2e fe ff ff       	call   ffffffff80103863 <install_trans>
  log.lh.n = 0;
ffffffff80103a35:	c7 05 d9 c1 00 00 00 	movl   $0x0,0xc1d9(%rip)        # ffffffff8010fc18 <log+0x78>
ffffffff80103a3c:	00 00 00 
  write_head(); // clear the log
ffffffff80103a3f:	e8 57 ff ff ff       	call   ffffffff8010399b <write_head>
}
ffffffff80103a44:	90                   	nop
ffffffff80103a45:	5d                   	pop    %rbp
ffffffff80103a46:	c3                   	ret

ffffffff80103a47 <begin_trans>:

void
begin_trans(void)
{
ffffffff80103a47:	55                   	push   %rbp
ffffffff80103a48:	48 89 e5             	mov    %rsp,%rbp
  acquire(&log.lock);
ffffffff80103a4b:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103a52:	e8 8c 21 00 00       	call   ffffffff80105be3 <acquire>
  while (log.busy) {
ffffffff80103a57:	eb 13                	jmp    ffffffff80103a6c <begin_trans+0x25>
    sleep(&log, &log.lock);
ffffffff80103a59:	48 c7 c6 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rsi
ffffffff80103a60:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103a67:	e8 f3 1d 00 00       	call   ffffffff8010585f <sleep>
  while (log.busy) {
ffffffff80103a6c:	8b 05 9e c1 00 00    	mov    0xc19e(%rip),%eax        # ffffffff8010fc10 <log+0x70>
ffffffff80103a72:	85 c0                	test   %eax,%eax
ffffffff80103a74:	75 e3                	jne    ffffffff80103a59 <begin_trans+0x12>
  }
  log.busy = 1;
ffffffff80103a76:	c7 05 90 c1 00 00 01 	movl   $0x1,0xc190(%rip)        # ffffffff8010fc10 <log+0x70>
ffffffff80103a7d:	00 00 00 
  release(&log.lock);
ffffffff80103a80:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103a87:	e8 2e 22 00 00       	call   ffffffff80105cba <release>
}
ffffffff80103a8c:	90                   	nop
ffffffff80103a8d:	5d                   	pop    %rbp
ffffffff80103a8e:	c3                   	ret

ffffffff80103a8f <commit_trans>:

void
commit_trans(void)
{
ffffffff80103a8f:	55                   	push   %rbp
ffffffff80103a90:	48 89 e5             	mov    %rsp,%rbp
  if (log.lh.n > 0) {
ffffffff80103a93:	8b 05 7f c1 00 00    	mov    0xc17f(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103a99:	85 c0                	test   %eax,%eax
ffffffff80103a9b:	7e 19                	jle    ffffffff80103ab6 <commit_trans+0x27>
    write_head();    // Write header to disk -- the real commit
ffffffff80103a9d:	e8 f9 fe ff ff       	call   ffffffff8010399b <write_head>
    install_trans(); // Now install writes to home locations
ffffffff80103aa2:	e8 bc fd ff ff       	call   ffffffff80103863 <install_trans>
    log.lh.n = 0; 
ffffffff80103aa7:	c7 05 67 c1 00 00 00 	movl   $0x0,0xc167(%rip)        # ffffffff8010fc18 <log+0x78>
ffffffff80103aae:	00 00 00 
    write_head();    // Erase the transaction from the log
ffffffff80103ab1:	e8 e5 fe ff ff       	call   ffffffff8010399b <write_head>
  }
  
  acquire(&log.lock);
ffffffff80103ab6:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103abd:	e8 21 21 00 00       	call   ffffffff80105be3 <acquire>
  log.busy = 0;
ffffffff80103ac2:	c7 05 44 c1 00 00 00 	movl   $0x0,0xc144(%rip)        # ffffffff8010fc10 <log+0x70>
ffffffff80103ac9:	00 00 00 
  wakeup(&log);
ffffffff80103acc:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103ad3:	e8 9b 1e 00 00       	call   ffffffff80105973 <wakeup>
  release(&log.lock);
ffffffff80103ad8:	48 c7 c7 a0 fb 10 80 	mov    $0xffffffff8010fba0,%rdi
ffffffff80103adf:	e8 d6 21 00 00       	call   ffffffff80105cba <release>
}
ffffffff80103ae4:	90                   	nop
ffffffff80103ae5:	5d                   	pop    %rbp
ffffffff80103ae6:	c3                   	ret

ffffffff80103ae7 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
ffffffff80103ae7:	55                   	push   %rbp
ffffffff80103ae8:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103aeb:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80103aef:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
ffffffff80103af3:	8b 05 1f c1 00 00    	mov    0xc11f(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103af9:	83 f8 09             	cmp    $0x9,%eax
ffffffff80103afc:	7f 13                	jg     ffffffff80103b11 <log_write+0x2a>
ffffffff80103afe:	8b 15 14 c1 00 00    	mov    0xc114(%rip),%edx        # ffffffff8010fc18 <log+0x78>
ffffffff80103b04:	8b 05 02 c1 00 00    	mov    0xc102(%rip),%eax        # ffffffff8010fc0c <log+0x6c>
ffffffff80103b0a:	83 e8 01             	sub    $0x1,%eax
ffffffff80103b0d:	39 c2                	cmp    %eax,%edx
ffffffff80103b0f:	7c 0c                	jl     ffffffff80103b1d <log_write+0x36>
    panic("too big a transaction");
ffffffff80103b11:	48 c7 c7 e8 9d 10 80 	mov    $0xffffffff80109de8,%rdi
ffffffff80103b18:	e8 12 ce ff ff       	call   ffffffff8010092f <panic>
  if (!log.busy)
ffffffff80103b1d:	8b 05 ed c0 00 00    	mov    0xc0ed(%rip),%eax        # ffffffff8010fc10 <log+0x70>
ffffffff80103b23:	85 c0                	test   %eax,%eax
ffffffff80103b25:	75 0c                	jne    ffffffff80103b33 <log_write+0x4c>
    panic("write outside of trans");
ffffffff80103b27:	48 c7 c7 fe 9d 10 80 	mov    $0xffffffff80109dfe,%rdi
ffffffff80103b2e:	e8 fc cd ff ff       	call   ffffffff8010092f <panic>

  for (i = 0; i < log.lh.n; i++) {
ffffffff80103b33:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80103b3a:	eb 21                	jmp    ffffffff80103b5d <log_write+0x76>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
ffffffff80103b3c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103b3f:	48 98                	cltq
ffffffff80103b41:	48 83 c0 1c          	add    $0x1c,%rax
ffffffff80103b45:	8b 04 85 ac fb 10 80 	mov    -0x7fef0454(,%rax,4),%eax
ffffffff80103b4c:	89 c2                	mov    %eax,%edx
ffffffff80103b4e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103b52:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80103b55:	39 c2                	cmp    %eax,%edx
ffffffff80103b57:	74 11                	je     ffffffff80103b6a <log_write+0x83>
  for (i = 0; i < log.lh.n; i++) {
ffffffff80103b59:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103b5d:	8b 05 b5 c0 00 00    	mov    0xc0b5(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103b63:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff80103b66:	7c d4                	jl     ffffffff80103b3c <log_write+0x55>
ffffffff80103b68:	eb 01                	jmp    ffffffff80103b6b <log_write+0x84>
      break;
ffffffff80103b6a:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
ffffffff80103b6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103b6f:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80103b72:	89 c2                	mov    %eax,%edx
ffffffff80103b74:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103b77:	48 98                	cltq
ffffffff80103b79:	48 83 c0 1c          	add    $0x1c,%rax
ffffffff80103b7d:	89 14 85 ac fb 10 80 	mov    %edx,-0x7fef0454(,%rax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
ffffffff80103b84:	8b 15 7e c0 00 00    	mov    0xc07e(%rip),%edx        # ffffffff8010fc08 <log+0x68>
ffffffff80103b8a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103b8d:	01 d0                	add    %edx,%eax
ffffffff80103b8f:	83 c0 01             	add    $0x1,%eax
ffffffff80103b92:	89 c2                	mov    %eax,%edx
ffffffff80103b94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103b98:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80103b9b:	89 d6                	mov    %edx,%esi
ffffffff80103b9d:	89 c7                	mov    %eax,%edi
ffffffff80103b9f:	e8 33 c7 ff ff       	call   ffffffff801002d7 <bread>
ffffffff80103ba4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  memmove(lbuf->data, b->data, BSIZE);
ffffffff80103ba8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103bac:	48 8d 48 28          	lea    0x28(%rax),%rcx
ffffffff80103bb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103bb4:	48 83 c0 28          	add    $0x28,%rax
ffffffff80103bb8:	ba 00 02 00 00       	mov    $0x200,%edx
ffffffff80103bbd:	48 89 ce             	mov    %rcx,%rsi
ffffffff80103bc0:	48 89 c7             	mov    %rax,%rdi
ffffffff80103bc3:	e8 7a 24 00 00       	call   ffffffff80106042 <memmove>
  bwrite(lbuf);
ffffffff80103bc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103bcc:	48 89 c7             	mov    %rax,%rdi
ffffffff80103bcf:	e8 43 c7 ff ff       	call   ffffffff80100317 <bwrite>
  brelse(lbuf);
ffffffff80103bd4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103bd8:	48 89 c7             	mov    %rax,%rdi
ffffffff80103bdb:	e8 7c c7 ff ff       	call   ffffffff8010035c <brelse>
  if (i == log.lh.n)
ffffffff80103be0:	8b 05 32 c0 00 00    	mov    0xc032(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103be6:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffffffff80103be9:	75 0f                	jne    ffffffff80103bfa <log_write+0x113>
    log.lh.n++;
ffffffff80103beb:	8b 05 27 c0 00 00    	mov    0xc027(%rip),%eax        # ffffffff8010fc18 <log+0x78>
ffffffff80103bf1:	83 c0 01             	add    $0x1,%eax
ffffffff80103bf4:	89 05 1e c0 00 00    	mov    %eax,0xc01e(%rip)        # ffffffff8010fc18 <log+0x78>
  b->flags |= B_DIRTY; // XXX prevent eviction
ffffffff80103bfa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103bfe:	8b 00                	mov    (%rax),%eax
ffffffff80103c00:	83 c8 04             	or     $0x4,%eax
ffffffff80103c03:	89 c2                	mov    %eax,%edx
ffffffff80103c05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103c09:	89 10                	mov    %edx,(%rax)
}
ffffffff80103c0b:	90                   	nop
ffffffff80103c0c:	c9                   	leave
ffffffff80103c0d:	c3                   	ret

ffffffff80103c0e <v2p>:
ffffffff80103c0e:	55                   	push   %rbp
ffffffff80103c0f:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103c12:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103c16:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80103c1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103c1e:	ba 00 00 00 80       	mov    $0x80000000,%edx
ffffffff80103c23:	48 01 d0             	add    %rdx,%rax
ffffffff80103c26:	c9                   	leave
ffffffff80103c27:	c3                   	ret

ffffffff80103c28 <p2v>:
static inline void *p2v(uintp a) { return (void *) ((a) + ((uintp)KERNBASE)); }
ffffffff80103c28:	55                   	push   %rbp
ffffffff80103c29:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103c2c:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103c30:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80103c34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103c38:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
ffffffff80103c3e:	c9                   	leave
ffffffff80103c3f:	c3                   	ret

ffffffff80103c40 <xchg>:
  asm volatile("hlt");
}

static inline uint
xchg(volatile uint *addr, uintp newval)
{
ffffffff80103c40:	55                   	push   %rbp
ffffffff80103c41:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103c44:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80103c48:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80103c4c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
ffffffff80103c50:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80103c54:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80103c58:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffffffff80103c5c:	f0 87 02             	lock xchg %eax,(%rdx)
ffffffff80103c5f:	89 45 fc             	mov    %eax,-0x4(%rbp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
ffffffff80103c62:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff80103c65:	c9                   	leave
ffffffff80103c66:	c3                   	ret

ffffffff80103c67 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
ffffffff80103c67:	55                   	push   %rbp
ffffffff80103c68:	48 89 e5             	mov    %rsp,%rbp
  uartearlyinit();
ffffffff80103c6b:	e8 79 40 00 00       	call   ffffffff80107ce9 <uartearlyinit>
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
ffffffff80103c70:	48 c7 c6 00 00 40 80 	mov    $0xffffffff80400000,%rsi
ffffffff80103c77:	48 c7 c7 00 50 11 80 	mov    $0xffffffff80115000,%rdi
ffffffff80103c7e:	e8 eb f4 ff ff       	call   ffffffff8010316e <kinit1>
  kvmalloc();      // kernel page table
ffffffff80103c83:	e8 cb 5c 00 00       	call   ffffffff80109953 <kvmalloc>
  if (acpiinit()) // try to use acpi for machine info
ffffffff80103c88:	e8 3e 0a 00 00       	call   ffffffff801046cb <acpiinit>
ffffffff80103c8d:	85 c0                	test   %eax,%eax
ffffffff80103c8f:	74 05                	je     ffffffff80103c96 <main+0x2f>
    mpinit();      // otherwise use bios MP tables
ffffffff80103c91:	e8 c7 04 00 00       	call   ffffffff8010415d <mpinit>
  lapicinit();
ffffffff80103c96:	e8 93 f8 ff ff       	call   ffffffff8010352e <lapicinit>
  seginit();       // set up segments
ffffffff80103c9b:	e8 a5 59 00 00       	call   ffffffff80109645 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
ffffffff80103ca0:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80103ca7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80103cab:	0f b6 00             	movzbl (%rax),%eax
ffffffff80103cae:	0f b6 c0             	movzbl %al,%eax
ffffffff80103cb1:	89 c6                	mov    %eax,%esi
ffffffff80103cb3:	48 c7 c7 15 9e 10 80 	mov    $0xffffffff80109e15,%rdi
ffffffff80103cba:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80103cbf:	e8 e0 c8 ff ff       	call   ffffffff801005a4 <cprintf>
  picinit();       // interrupt controller
ffffffff80103cc4:	e8 89 0b 00 00       	call   ffffffff80104852 <picinit>
  ioapicinit();    // another interrupt controller
ffffffff80103cc9:	e8 79 f3 ff ff       	call   ffffffff80103047 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
ffffffff80103cce:	e8 3c d2 ff ff       	call   ffffffff80100f0f <consoleinit>
  uartinit();      // serial port
ffffffff80103cd3:	e8 ca 40 00 00       	call   ffffffff80107da2 <uartinit>
  pinit();         // process table
ffffffff80103cd8:	e8 e6 10 00 00       	call   ffffffff80104dc3 <pinit>
  tvinit();        // trap vectors
ffffffff80103cdd:	e8 ca 57 00 00       	call   ffffffff801094ac <tvinit>
  binit();         // buffer cache
ffffffff80103ce2:	e8 44 c4 ff ff       	call   ffffffff8010012b <binit>
  fileinit();      // file table
ffffffff80103ce7:	e8 8a d7 ff ff       	call   ffffffff80101476 <fileinit>
  iinit();         // inode cache
ffffffff80103cec:	e8 a8 de ff ff       	call   ffffffff80101b99 <iinit>
  ideinit();       // disk
ffffffff80103cf1:	e8 a1 ef ff ff       	call   ffffffff80102c97 <ideinit>
  if(!ismp)
ffffffff80103cf6:	8b 05 e4 c6 00 00    	mov    0xc6e4(%rip),%eax        # ffffffff801103e0 <ismp>
ffffffff80103cfc:	85 c0                	test   %eax,%eax
ffffffff80103cfe:	75 05                	jne    ffffffff80103d05 <main+0x9e>
    timerinit();   // uniprocessor timer
ffffffff80103d00:	e8 e2 3b 00 00       	call   ffffffff801078e7 <timerinit>
  startothers();   // start other processors
ffffffff80103d05:	e8 85 00 00 00       	call   ffffffff80103d8f <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
ffffffff80103d0a:	48 c7 c6 00 00 00 8e 	mov    $0xffffffff8e000000,%rsi
ffffffff80103d11:	48 c7 c7 00 00 40 80 	mov    $0xffffffff80400000,%rdi
ffffffff80103d18:	e8 94 f4 ff ff       	call   ffffffff801031b1 <kinit2>
  userinit();      // first user process
ffffffff80103d1d:	e8 f1 11 00 00       	call   ffffffff80104f13 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
ffffffff80103d22:	e8 18 00 00 00       	call   ffffffff80103d3f <mpmain>

ffffffff80103d27 <mpenter>:
}

// Other CPUs jump here from entryother.S.
void
mpenter(void)
{
ffffffff80103d27:	55                   	push   %rbp
ffffffff80103d28:	48 89 e5             	mov    %rsp,%rbp
  switchkvm(); 
ffffffff80103d2b:	e8 e8 5d 00 00       	call   ffffffff80109b18 <switchkvm>
  seginit();
ffffffff80103d30:	e8 10 59 00 00       	call   ffffffff80109645 <seginit>
  lapicinit();
ffffffff80103d35:	e8 f4 f7 ff ff       	call   ffffffff8010352e <lapicinit>
  mpmain();
ffffffff80103d3a:	e8 00 00 00 00       	call   ffffffff80103d3f <mpmain>

ffffffff80103d3f <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
ffffffff80103d3f:	55                   	push   %rbp
ffffffff80103d40:	48 89 e5             	mov    %rsp,%rbp
  cprintf("cpu%d: starting\n", cpu->id);
ffffffff80103d43:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80103d4a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80103d4e:	0f b6 00             	movzbl (%rax),%eax
ffffffff80103d51:	0f b6 c0             	movzbl %al,%eax
ffffffff80103d54:	89 c6                	mov    %eax,%esi
ffffffff80103d56:	48 c7 c7 2c 9e 10 80 	mov    $0xffffffff80109e2c,%rdi
ffffffff80103d5d:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80103d62:	e8 3d c8 ff ff       	call   ffffffff801005a4 <cprintf>
  idtinit();       // load idt register
ffffffff80103d67:	e8 47 57 00 00       	call   ffffffff801094b3 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
ffffffff80103d6c:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80103d73:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80103d77:	48 05 d8 00 00 00    	add    $0xd8,%rax
ffffffff80103d7d:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80103d82:	48 89 c7             	mov    %rax,%rdi
ffffffff80103d85:	e8 b6 fe ff ff       	call   ffffffff80103c40 <xchg>
  scheduler();     // start running processes
ffffffff80103d8a:	e8 b6 18 00 00       	call   ffffffff80105645 <scheduler>

ffffffff80103d8f <startothers>:
void entry32mp(void);

// Start the non-boot (AP) processors.
static void
startothers(void)
{
ffffffff80103d8f:	55                   	push   %rbp
ffffffff80103d90:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103d93:	48 83 ec 20          	sub    $0x20,%rsp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
ffffffff80103d97:	bf 00 70 00 00       	mov    $0x7000,%edi
ffffffff80103d9c:	e8 87 fe ff ff       	call   ffffffff80103c28 <p2v>
ffffffff80103da1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  memmove(code, _binary_out_entryother_start, (uintp)_binary_out_entryother_size);
ffffffff80103da5:	48 c7 c0 72 00 00 00 	mov    $0x72,%rax
ffffffff80103dac:	89 c2                	mov    %eax,%edx
ffffffff80103dae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103db2:	48 c7 c6 e4 be 10 80 	mov    $0xffffffff8010bee4,%rsi
ffffffff80103db9:	48 89 c7             	mov    %rax,%rdi
ffffffff80103dbc:	e8 81 22 00 00       	call   ffffffff80106042 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
ffffffff80103dc1:	48 c7 45 f8 60 fc 10 	movq   $0xffffffff8010fc60,-0x8(%rbp)
ffffffff80103dc8:	80 
ffffffff80103dc9:	e9 a1 00 00 00       	jmp    ffffffff80103e6f <startothers+0xe0>
    if(c == cpus+cpunum())  // We've started already.
ffffffff80103dce:	e8 78 f8 ff ff       	call   ffffffff8010364b <cpunum>
ffffffff80103dd3:	48 63 d0             	movslq %eax,%rdx
ffffffff80103dd6:	48 89 d0             	mov    %rdx,%rax
ffffffff80103dd9:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80103ddd:	48 29 d0             	sub    %rdx,%rax
ffffffff80103de0:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80103de4:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff80103dea:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff80103dee:	74 76                	je     ffffffff80103e66 <startothers+0xd7>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
ffffffff80103df0:	e8 e4 f4 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80103df5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
#if X64
    *(uint32*)(code-4) = 0x8000; // just enough stack to get us to entry64mp
ffffffff80103df9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103dfd:	48 83 e8 04          	sub    $0x4,%rax
ffffffff80103e01:	c7 00 00 80 00 00    	movl   $0x8000,(%rax)
    *(uint32*)(code-8) = v2p(entry32mp);
ffffffff80103e07:	48 c7 c7 74 00 10 80 	mov    $0xffffffff80100074,%rdi
ffffffff80103e0e:	e8 fb fd ff ff       	call   ffffffff80103c0e <v2p>
ffffffff80103e13:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80103e17:	48 83 ea 08          	sub    $0x8,%rdx
ffffffff80103e1b:	89 02                	mov    %eax,(%rdx)
    *(uint64*)(code-16) = (uint64) (stack + KSTACKSIZE);
ffffffff80103e1d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103e21:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffffffff80103e28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103e2c:	48 83 e8 10          	sub    $0x10,%rax
ffffffff80103e30:	48 89 10             	mov    %rdx,(%rax)
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) v2p(entrypgdir);
#endif

    lapicstartap(c->apicid, v2p(code));
ffffffff80103e33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103e37:	48 89 c7             	mov    %rax,%rdi
ffffffff80103e3a:	e8 cf fd ff ff       	call   ffffffff80103c0e <v2p>
ffffffff80103e3f:	89 c2                	mov    %eax,%edx
ffffffff80103e41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103e45:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffffffff80103e49:	0f b6 c0             	movzbl %al,%eax
ffffffff80103e4c:	89 d6                	mov    %edx,%esi
ffffffff80103e4e:	89 c7                	mov    %eax,%edi
ffffffff80103e50:	e8 d7 f8 ff ff       	call   ffffffff8010372c <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
ffffffff80103e55:	90                   	nop
ffffffff80103e56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103e5a:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
ffffffff80103e60:	85 c0                	test   %eax,%eax
ffffffff80103e62:	74 f2                	je     ffffffff80103e56 <startothers+0xc7>
ffffffff80103e64:	eb 01                	jmp    ffffffff80103e67 <startothers+0xd8>
      continue;
ffffffff80103e66:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
ffffffff80103e67:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff80103e6e:	00 
ffffffff80103e6f:	8b 05 6f c5 00 00    	mov    0xc56f(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80103e75:	48 63 d0             	movslq %eax,%rdx
ffffffff80103e78:	48 89 d0             	mov    %rdx,%rax
ffffffff80103e7b:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80103e7f:	48 29 d0             	sub    %rdx,%rax
ffffffff80103e82:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80103e86:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff80103e8c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff80103e90:	0f 82 38 ff ff ff    	jb     ffffffff80103dce <startothers+0x3f>
      ;
  }
}
ffffffff80103e96:	90                   	nop
ffffffff80103e97:	90                   	nop
ffffffff80103e98:	c9                   	leave
ffffffff80103e99:	c3                   	ret

ffffffff80103e9a <p2v>:
ffffffff80103e9a:	55                   	push   %rbp
ffffffff80103e9b:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103e9e:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103ea2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80103ea6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103eaa:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
ffffffff80103eb0:	c9                   	leave
ffffffff80103eb1:	c3                   	ret

ffffffff80103eb2 <inb>:
{
ffffffff80103eb2:	55                   	push   %rbp
ffffffff80103eb3:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103eb6:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80103eba:	89 f8                	mov    %edi,%eax
ffffffff80103ebc:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffffffff80103ec0:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffffffff80103ec4:	89 c2                	mov    %eax,%edx
ffffffff80103ec6:	ec                   	in     (%dx),%al
ffffffff80103ec7:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffffffff80103eca:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffffffff80103ece:	c9                   	leave
ffffffff80103ecf:	c3                   	ret

ffffffff80103ed0 <outb>:
{
ffffffff80103ed0:	55                   	push   %rbp
ffffffff80103ed1:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103ed4:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80103ed8:	89 fa                	mov    %edi,%edx
ffffffff80103eda:	89 f0                	mov    %esi,%eax
ffffffff80103edc:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff80103ee0:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff80103ee3:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff80103ee7:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff80103eeb:	ee                   	out    %al,(%dx)
}
ffffffff80103eec:	90                   	nop
ffffffff80103eed:	c9                   	leave
ffffffff80103eee:	c3                   	ret

ffffffff80103eef <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
ffffffff80103eef:	55                   	push   %rbp
ffffffff80103ef0:	48 89 e5             	mov    %rsp,%rbp
  return bcpu-cpus;
ffffffff80103ef3:	48 8b 05 f6 c4 00 00 	mov    0xc4f6(%rip),%rax        # ffffffff801103f0 <bcpu>
ffffffff80103efa:	48 2d 60 fc 10 80    	sub    $0xffffffff8010fc60,%rax
ffffffff80103f00:	48 c1 f8 04          	sar    $0x4,%rax
ffffffff80103f04:	48 89 c2             	mov    %rax,%rdx
ffffffff80103f07:	48 b8 ef ee ee ee ee 	movabs $0xeeeeeeeeeeeeeeef,%rax
ffffffff80103f0e:	ee ee ee 
ffffffff80103f11:	48 0f af c2          	imul   %rdx,%rax
}
ffffffff80103f15:	5d                   	pop    %rbp
ffffffff80103f16:	c3                   	ret

ffffffff80103f17 <sum>:

static uchar
sum(uchar *addr, int len)
{
ffffffff80103f17:	55                   	push   %rbp
ffffffff80103f18:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103f1b:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80103f1f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80103f23:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, sum;
  
  sum = 0;
ffffffff80103f26:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i=0; i<len; i++)
ffffffff80103f2d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80103f34:	eb 1a                	jmp    ffffffff80103f50 <sum+0x39>
    sum += addr[i];
ffffffff80103f36:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103f39:	48 63 d0             	movslq %eax,%rdx
ffffffff80103f3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80103f40:	48 01 d0             	add    %rdx,%rax
ffffffff80103f43:	0f b6 00             	movzbl (%rax),%eax
ffffffff80103f46:	0f b6 c0             	movzbl %al,%eax
ffffffff80103f49:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i=0; i<len; i++)
ffffffff80103f4c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80103f50:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80103f53:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffffffff80103f56:	7c de                	jl     ffffffff80103f36 <sum+0x1f>
  return sum;
ffffffff80103f58:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffffffff80103f5b:	c9                   	leave
ffffffff80103f5c:	c3                   	ret

ffffffff80103f5d <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
ffffffff80103f5d:	55                   	push   %rbp
ffffffff80103f5e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103f61:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80103f65:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffffffff80103f68:	89 75 d8             	mov    %esi,-0x28(%rbp)
  uchar *e, *p, *addr;

  addr = p2v(a);
ffffffff80103f6b:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80103f6e:	48 89 c7             	mov    %rax,%rdi
ffffffff80103f71:	e8 24 ff ff ff       	call   ffffffff80103e9a <p2v>
ffffffff80103f76:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  e = addr+len;
ffffffff80103f7a:	8b 45 d8             	mov    -0x28(%rbp),%eax
ffffffff80103f7d:	48 63 d0             	movslq %eax,%rdx
ffffffff80103f80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103f84:	48 01 d0             	add    %rdx,%rax
ffffffff80103f87:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(p = addr; p < e; p += sizeof(struct mp))
ffffffff80103f8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80103f8f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80103f93:	eb 3c                	jmp    ffffffff80103fd1 <mpsearch1+0x74>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
ffffffff80103f95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103f99:	ba 04 00 00 00       	mov    $0x4,%edx
ffffffff80103f9e:	48 c7 c6 40 9e 10 80 	mov    $0xffffffff80109e40,%rsi
ffffffff80103fa5:	48 89 c7             	mov    %rax,%rdi
ffffffff80103fa8:	e8 26 20 00 00       	call   ffffffff80105fd3 <memcmp>
ffffffff80103fad:	85 c0                	test   %eax,%eax
ffffffff80103faf:	75 1b                	jne    ffffffff80103fcc <mpsearch1+0x6f>
ffffffff80103fb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103fb5:	be 10 00 00 00       	mov    $0x10,%esi
ffffffff80103fba:	48 89 c7             	mov    %rax,%rdi
ffffffff80103fbd:	e8 55 ff ff ff       	call   ffffffff80103f17 <sum>
ffffffff80103fc2:	84 c0                	test   %al,%al
ffffffff80103fc4:	75 06                	jne    ffffffff80103fcc <mpsearch1+0x6f>
      return (struct mp*)p;
ffffffff80103fc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103fca:	eb 14                	jmp    ffffffff80103fe0 <mpsearch1+0x83>
  for(p = addr; p < e; p += sizeof(struct mp))
ffffffff80103fcc:	48 83 45 f8 10       	addq   $0x10,-0x8(%rbp)
ffffffff80103fd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103fd5:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffffffff80103fd9:	72 ba                	jb     ffffffff80103f95 <mpsearch1+0x38>
  return 0;
ffffffff80103fdb:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80103fe0:	c9                   	leave
ffffffff80103fe1:	c3                   	ret

ffffffff80103fe2 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
ffffffff80103fe2:	55                   	push   %rbp
ffffffff80103fe3:	48 89 e5             	mov    %rsp,%rbp
ffffffff80103fe6:	48 83 ec 20          	sub    $0x20,%rsp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
ffffffff80103fea:	48 c7 45 f8 00 04 00 	movq   $0xffffffff80000400,-0x8(%rbp)
ffffffff80103ff1:	80 
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
ffffffff80103ff2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80103ff6:	48 83 c0 0f          	add    $0xf,%rax
ffffffff80103ffa:	0f b6 00             	movzbl (%rax),%eax
ffffffff80103ffd:	0f b6 c0             	movzbl %al,%eax
ffffffff80104000:	c1 e0 08             	shl    $0x8,%eax
ffffffff80104003:	89 c2                	mov    %eax,%edx
ffffffff80104005:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104009:	48 83 c0 0e          	add    $0xe,%rax
ffffffff8010400d:	0f b6 00             	movzbl (%rax),%eax
ffffffff80104010:	0f b6 c0             	movzbl %al,%eax
ffffffff80104013:	09 d0                	or     %edx,%eax
ffffffff80104015:	c1 e0 04             	shl    $0x4,%eax
ffffffff80104018:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffffffff8010401b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffffffff8010401f:	74 20                	je     ffffffff80104041 <mpsearch+0x5f>
    if((mp = mpsearch1(p, 1024)))
ffffffff80104021:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80104024:	be 00 04 00 00       	mov    $0x400,%esi
ffffffff80104029:	89 c7                	mov    %eax,%edi
ffffffff8010402b:	e8 2d ff ff ff       	call   ffffffff80103f5d <mpsearch1>
ffffffff80104030:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff80104034:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80104039:	74 54                	je     ffffffff8010408f <mpsearch+0xad>
      return mp;
ffffffff8010403b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010403f:	eb 5d                	jmp    ffffffff8010409e <mpsearch+0xbc>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
ffffffff80104041:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104045:	48 83 c0 14          	add    $0x14,%rax
ffffffff80104049:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010404c:	0f b6 c0             	movzbl %al,%eax
ffffffff8010404f:	c1 e0 08             	shl    $0x8,%eax
ffffffff80104052:	89 c2                	mov    %eax,%edx
ffffffff80104054:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104058:	48 83 c0 13          	add    $0x13,%rax
ffffffff8010405c:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010405f:	0f b6 c0             	movzbl %al,%eax
ffffffff80104062:	09 d0                	or     %edx,%eax
ffffffff80104064:	c1 e0 0a             	shl    $0xa,%eax
ffffffff80104067:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((mp = mpsearch1(p-1024, 1024)))
ffffffff8010406a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff8010406d:	2d 00 04 00 00       	sub    $0x400,%eax
ffffffff80104072:	be 00 04 00 00       	mov    $0x400,%esi
ffffffff80104077:	89 c7                	mov    %eax,%edi
ffffffff80104079:	e8 df fe ff ff       	call   ffffffff80103f5d <mpsearch1>
ffffffff8010407e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff80104082:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80104087:	74 06                	je     ffffffff8010408f <mpsearch+0xad>
      return mp;
ffffffff80104089:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010408d:	eb 0f                	jmp    ffffffff8010409e <mpsearch+0xbc>
  }
  return mpsearch1(0xF0000, 0x10000);
ffffffff8010408f:	be 00 00 01 00       	mov    $0x10000,%esi
ffffffff80104094:	bf 00 00 0f 00       	mov    $0xf0000,%edi
ffffffff80104099:	e8 bf fe ff ff       	call   ffffffff80103f5d <mpsearch1>
}
ffffffff8010409e:	c9                   	leave
ffffffff8010409f:	c3                   	ret

ffffffff801040a0 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
ffffffff801040a0:	55                   	push   %rbp
ffffffff801040a1:	48 89 e5             	mov    %rsp,%rbp
ffffffff801040a4:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801040a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
ffffffff801040ac:	e8 31 ff ff ff       	call   ffffffff80103fe2 <mpsearch>
ffffffff801040b1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801040b5:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801040ba:	74 0b                	je     ffffffff801040c7 <mpconfig+0x27>
ffffffff801040bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801040c0:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801040c3:	85 c0                	test   %eax,%eax
ffffffff801040c5:	75 0a                	jne    ffffffff801040d1 <mpconfig+0x31>
    return 0;
ffffffff801040c7:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801040cc:	e9 8a 00 00 00       	jmp    ffffffff8010415b <mpconfig+0xbb>
  conf = (struct mpconf*) p2v((uintp) mp->physaddr);
ffffffff801040d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801040d5:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801040d8:	89 c0                	mov    %eax,%eax
ffffffff801040da:	48 89 c7             	mov    %rax,%rdi
ffffffff801040dd:	e8 b8 fd ff ff       	call   ffffffff80103e9a <p2v>
ffffffff801040e2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(memcmp(conf, "PCMP", 4) != 0)
ffffffff801040e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801040ea:	ba 04 00 00 00       	mov    $0x4,%edx
ffffffff801040ef:	48 c7 c6 45 9e 10 80 	mov    $0xffffffff80109e45,%rsi
ffffffff801040f6:	48 89 c7             	mov    %rax,%rdi
ffffffff801040f9:	e8 d5 1e 00 00       	call   ffffffff80105fd3 <memcmp>
ffffffff801040fe:	85 c0                	test   %eax,%eax
ffffffff80104100:	74 07                	je     ffffffff80104109 <mpconfig+0x69>
    return 0;
ffffffff80104102:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104107:	eb 52                	jmp    ffffffff8010415b <mpconfig+0xbb>
  if(conf->version != 1 && conf->version != 4)
ffffffff80104109:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010410d:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffffffff80104111:	3c 01                	cmp    $0x1,%al
ffffffff80104113:	74 13                	je     ffffffff80104128 <mpconfig+0x88>
ffffffff80104115:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104119:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffffffff8010411d:	3c 04                	cmp    $0x4,%al
ffffffff8010411f:	74 07                	je     ffffffff80104128 <mpconfig+0x88>
    return 0;
ffffffff80104121:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104126:	eb 33                	jmp    ffffffff8010415b <mpconfig+0xbb>
  if(sum((uchar*)conf, conf->length) != 0)
ffffffff80104128:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010412c:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffffffff80104130:	0f b7 d0             	movzwl %ax,%edx
ffffffff80104133:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104137:	89 d6                	mov    %edx,%esi
ffffffff80104139:	48 89 c7             	mov    %rax,%rdi
ffffffff8010413c:	e8 d6 fd ff ff       	call   ffffffff80103f17 <sum>
ffffffff80104141:	84 c0                	test   %al,%al
ffffffff80104143:	74 07                	je     ffffffff8010414c <mpconfig+0xac>
    return 0;
ffffffff80104145:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010414a:	eb 0f                	jmp    ffffffff8010415b <mpconfig+0xbb>
  *pmp = mp;
ffffffff8010414c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104150:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80104154:	48 89 10             	mov    %rdx,(%rax)
  return conf;
ffffffff80104157:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffffffff8010415b:	c9                   	leave
ffffffff8010415c:	c3                   	ret

ffffffff8010415d <mpinit>:

void
mpinit(void)
{
ffffffff8010415d:	55                   	push   %rbp
ffffffff8010415e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104161:	48 83 ec 30          	sub    $0x30,%rsp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
ffffffff80104165:	48 c7 05 80 c2 00 00 	movq   $0xffffffff8010fc60,0xc280(%rip)        # ffffffff801103f0 <bcpu>
ffffffff8010416c:	60 fc 10 80 
  if((conf = mpconfig(&mp)) == 0)
ffffffff80104170:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffffffff80104174:	48 89 c7             	mov    %rax,%rdi
ffffffff80104177:	e8 24 ff ff ff       	call   ffffffff801040a0 <mpconfig>
ffffffff8010417c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80104180:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80104185:	0f 84 0e 02 00 00    	je     ffffffff80104399 <mpinit+0x23c>
    return;
  ismp = 1;
ffffffff8010418b:	c7 05 4b c2 00 00 01 	movl   $0x1,0xc24b(%rip)        # ffffffff801103e0 <ismp>
ffffffff80104192:	00 00 00 
  lapic = IO2V((uintp)conf->lapicaddr);
ffffffff80104195:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104199:	8b 40 24             	mov    0x24(%rax),%eax
ffffffff8010419c:	89 c2                	mov    %eax,%edx
ffffffff8010419e:	48 b8 00 00 00 42 fe 	movabs $0xfffffffe42000000,%rax
ffffffff801041a5:	ff ff ff 
ffffffff801041a8:	48 01 d0             	add    %rdx,%rax
ffffffff801041ab:	48 89 05 ce b9 00 00 	mov    %rax,0xb9ce(%rip)        # ffffffff8010fb80 <lapic>
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffffffff801041b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801041b6:	48 83 c0 2c          	add    $0x2c,%rax
ffffffff801041ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801041be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801041c2:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffffffff801041c6:	0f b7 d0             	movzwl %ax,%edx
ffffffff801041c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801041cd:	48 01 d0             	add    %rdx,%rax
ffffffff801041d0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff801041d4:	e9 51 01 00 00       	jmp    ffffffff8010432a <mpinit+0x1cd>
    switch(*p){
ffffffff801041d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801041dd:	0f b6 00             	movzbl (%rax),%eax
ffffffff801041e0:	0f b6 c0             	movzbl %al,%eax
ffffffff801041e3:	83 f8 04             	cmp    $0x4,%eax
ffffffff801041e6:	0f 8f 17 01 00 00    	jg     ffffffff80104303 <mpinit+0x1a6>
ffffffff801041ec:	83 f8 03             	cmp    $0x3,%eax
ffffffff801041ef:	0f 8d 07 01 00 00    	jge    ffffffff801042fc <mpinit+0x19f>
ffffffff801041f5:	83 f8 02             	cmp    $0x2,%eax
ffffffff801041f8:	0f 84 e1 00 00 00    	je     ffffffff801042df <mpinit+0x182>
ffffffff801041fe:	83 f8 02             	cmp    $0x2,%eax
ffffffff80104201:	0f 8f fc 00 00 00    	jg     ffffffff80104303 <mpinit+0x1a6>
ffffffff80104207:	85 c0                	test   %eax,%eax
ffffffff80104209:	74 0e                	je     ffffffff80104219 <mpinit+0xbc>
ffffffff8010420b:	83 f8 01             	cmp    $0x1,%eax
ffffffff8010420e:	0f 84 e8 00 00 00    	je     ffffffff801042fc <mpinit+0x19f>
ffffffff80104214:	e9 ea 00 00 00       	jmp    ffffffff80104303 <mpinit+0x1a6>
    case MPPROC:
      proc = (struct mpproc*)p;
ffffffff80104219:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010421d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      cprintf("mpinit ncpu=%d apicid=%d\n", ncpu, proc->apicid);
ffffffff80104221:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80104225:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffffffff80104229:	0f b6 d0             	movzbl %al,%edx
ffffffff8010422c:	8b 05 b2 c1 00 00    	mov    0xc1b2(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80104232:	89 c6                	mov    %eax,%esi
ffffffff80104234:	48 c7 c7 4a 9e 10 80 	mov    $0xffffffff80109e4a,%rdi
ffffffff8010423b:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104240:	e8 5f c3 ff ff       	call   ffffffff801005a4 <cprintf>
      if(proc->flags & MPBOOT)
ffffffff80104245:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80104249:	0f b6 40 03          	movzbl 0x3(%rax),%eax
ffffffff8010424d:	0f b6 c0             	movzbl %al,%eax
ffffffff80104250:	83 e0 02             	and    $0x2,%eax
ffffffff80104253:	85 c0                	test   %eax,%eax
ffffffff80104255:	74 24                	je     ffffffff8010427b <mpinit+0x11e>
        bcpu = &cpus[ncpu];
ffffffff80104257:	8b 05 87 c1 00 00    	mov    0xc187(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff8010425d:	48 63 d0             	movslq %eax,%rdx
ffffffff80104260:	48 89 d0             	mov    %rdx,%rax
ffffffff80104263:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80104267:	48 29 d0             	sub    %rdx,%rax
ffffffff8010426a:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff8010426e:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff80104274:	48 89 05 75 c1 00 00 	mov    %rax,0xc175(%rip)        # ffffffff801103f0 <bcpu>
      cpus[ncpu].id = ncpu;
ffffffff8010427b:	8b 15 63 c1 00 00    	mov    0xc163(%rip),%edx        # ffffffff801103e4 <ncpu>
ffffffff80104281:	8b 05 5d c1 00 00    	mov    0xc15d(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80104287:	89 d1                	mov    %edx,%ecx
ffffffff80104289:	48 63 d0             	movslq %eax,%rdx
ffffffff8010428c:	48 89 d0             	mov    %rdx,%rax
ffffffff8010428f:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80104293:	48 29 d0             	sub    %rdx,%rax
ffffffff80104296:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff8010429a:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff801042a0:	88 08                	mov    %cl,(%rax)
      cpus[ncpu].apicid = proc->apicid;
ffffffff801042a2:	8b 15 3c c1 00 00    	mov    0xc13c(%rip),%edx        # ffffffff801103e4 <ncpu>
ffffffff801042a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801042ac:	0f b6 48 01          	movzbl 0x1(%rax),%ecx
ffffffff801042b0:	48 63 d2             	movslq %edx,%rdx
ffffffff801042b3:	48 89 d0             	mov    %rdx,%rax
ffffffff801042b6:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801042ba:	48 29 d0             	sub    %rdx,%rax
ffffffff801042bd:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801042c1:	48 05 61 fc 10 80    	add    $0xffffffff8010fc61,%rax
ffffffff801042c7:	88 08                	mov    %cl,(%rax)
      ncpu++;
ffffffff801042c9:	8b 05 15 c1 00 00    	mov    0xc115(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff801042cf:	83 c0 01             	add    $0x1,%eax
ffffffff801042d2:	89 05 0c c1 00 00    	mov    %eax,0xc10c(%rip)        # ffffffff801103e4 <ncpu>
      p += sizeof(struct mpproc);
ffffffff801042d8:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
      continue;
ffffffff801042dd:	eb 4b                	jmp    ffffffff8010432a <mpinit+0x1cd>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
ffffffff801042df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801042e3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      ioapicid = ioapic->apicno;
ffffffff801042e7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801042eb:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffffffff801042ef:	88 05 f3 c0 00 00    	mov    %al,0xc0f3(%rip)        # ffffffff801103e8 <ioapicid>
      p += sizeof(struct mpioapic);
ffffffff801042f5:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffffffff801042fa:	eb 2e                	jmp    ffffffff8010432a <mpinit+0x1cd>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
ffffffff801042fc:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffffffff80104301:	eb 27                	jmp    ffffffff8010432a <mpinit+0x1cd>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
ffffffff80104303:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104307:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010430a:	0f b6 c0             	movzbl %al,%eax
ffffffff8010430d:	89 c6                	mov    %eax,%esi
ffffffff8010430f:	48 c7 c7 68 9e 10 80 	mov    $0xffffffff80109e68,%rdi
ffffffff80104316:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010431b:	e8 84 c2 ff ff       	call   ffffffff801005a4 <cprintf>
      ismp = 0;
ffffffff80104320:	c7 05 b6 c0 00 00 00 	movl   $0x0,0xc0b6(%rip)        # ffffffff801103e0 <ismp>
ffffffff80104327:	00 00 00 
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffffffff8010432a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010432e:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffffffff80104332:	0f 82 a1 fe ff ff    	jb     ffffffff801041d9 <mpinit+0x7c>
    }
  }
  if(!ismp){
ffffffff80104338:	8b 05 a2 c0 00 00    	mov    0xc0a2(%rip),%eax        # ffffffff801103e0 <ismp>
ffffffff8010433e:	85 c0                	test   %eax,%eax
ffffffff80104340:	75 1e                	jne    ffffffff80104360 <mpinit+0x203>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
ffffffff80104342:	c7 05 98 c0 00 00 01 	movl   $0x1,0xc098(%rip)        # ffffffff801103e4 <ncpu>
ffffffff80104349:	00 00 00 
    lapic = 0;
ffffffff8010434c:	48 c7 05 29 b8 00 00 	movq   $0x0,0xb829(%rip)        # ffffffff8010fb80 <lapic>
ffffffff80104353:	00 00 00 00 
    ioapicid = 0;
ffffffff80104357:	c6 05 8a c0 00 00 00 	movb   $0x0,0xc08a(%rip)        # ffffffff801103e8 <ioapicid>
    return;
ffffffff8010435e:	eb 3a                	jmp    ffffffff8010439a <mpinit+0x23d>
  }

  if(mp->imcrp){
ffffffff80104360:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80104364:	0f b6 40 0c          	movzbl 0xc(%rax),%eax
ffffffff80104368:	84 c0                	test   %al,%al
ffffffff8010436a:	74 2e                	je     ffffffff8010439a <mpinit+0x23d>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
ffffffff8010436c:	be 70 00 00 00       	mov    $0x70,%esi
ffffffff80104371:	bf 22 00 00 00       	mov    $0x22,%edi
ffffffff80104376:	e8 55 fb ff ff       	call   ffffffff80103ed0 <outb>
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
ffffffff8010437b:	bf 23 00 00 00       	mov    $0x23,%edi
ffffffff80104380:	e8 2d fb ff ff       	call   ffffffff80103eb2 <inb>
ffffffff80104385:	83 c8 01             	or     $0x1,%eax
ffffffff80104388:	0f b6 c0             	movzbl %al,%eax
ffffffff8010438b:	89 c6                	mov    %eax,%esi
ffffffff8010438d:	bf 23 00 00 00       	mov    $0x23,%edi
ffffffff80104392:	e8 39 fb ff ff       	call   ffffffff80103ed0 <outb>
ffffffff80104397:	eb 01                	jmp    ffffffff8010439a <mpinit+0x23d>
    return;
ffffffff80104399:	90                   	nop
  }
}
ffffffff8010439a:	c9                   	leave
ffffffff8010439b:	c3                   	ret

ffffffff8010439c <p2v>:
ffffffff8010439c:	55                   	push   %rbp
ffffffff8010439d:	48 89 e5             	mov    %rsp,%rbp
ffffffff801043a0:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801043a4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801043a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801043ac:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
ffffffff801043b2:	c9                   	leave
ffffffff801043b3:	c3                   	ret

ffffffff801043b4 <scan_rdsp>:
extern struct cpu cpus[NCPU];
extern int ismp;
extern int ncpu;
extern uchar ioapicid;

static struct acpi_rdsp *scan_rdsp(uint base, uint len) {
ffffffff801043b4:	55                   	push   %rbp
ffffffff801043b5:	48 89 e5             	mov    %rsp,%rbp
ffffffff801043b8:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801043bc:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff801043bf:	89 75 e8             	mov    %esi,-0x18(%rbp)
  uchar *p;
  for (p = p2v(base); len >= sizeof(struct acpi_rdsp); len -= 4, p += 4) {
ffffffff801043c2:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801043c5:	48 89 c7             	mov    %rax,%rdi
ffffffff801043c8:	e8 cf ff ff ff       	call   ffffffff8010439c <p2v>
ffffffff801043cd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801043d1:	eb 62                	jmp    ffffffff80104435 <scan_rdsp+0x81>
    if (memcmp(p, SIG_RDSP, 8) == 0) {
ffffffff801043d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801043d7:	ba 08 00 00 00       	mov    $0x8,%edx
ffffffff801043dc:	48 c7 c6 88 9e 10 80 	mov    $0xffffffff80109e88,%rsi
ffffffff801043e3:	48 89 c7             	mov    %rax,%rdi
ffffffff801043e6:	e8 e8 1b 00 00       	call   ffffffff80105fd3 <memcmp>
ffffffff801043eb:	85 c0                	test   %eax,%eax
ffffffff801043ed:	75 3d                	jne    ffffffff8010442c <scan_rdsp+0x78>
      uint sum, n;
      for (sum = 0, n = 0; n < 20; n++)
ffffffff801043ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffffffff801043f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
ffffffff801043fd:	eb 17                	jmp    ffffffff80104416 <scan_rdsp+0x62>
        sum += p[n];
ffffffff801043ff:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffffffff80104402:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104406:	48 01 d0             	add    %rdx,%rax
ffffffff80104409:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010440c:	0f b6 c0             	movzbl %al,%eax
ffffffff8010440f:	01 45 f4             	add    %eax,-0xc(%rbp)
      for (sum = 0, n = 0; n < 20; n++)
ffffffff80104412:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
ffffffff80104416:	83 7d f0 13          	cmpl   $0x13,-0x10(%rbp)
ffffffff8010441a:	76 e3                	jbe    ffffffff801043ff <scan_rdsp+0x4b>
      if ((sum & 0xff) == 0)
ffffffff8010441c:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff8010441f:	0f b6 c0             	movzbl %al,%eax
ffffffff80104422:	85 c0                	test   %eax,%eax
ffffffff80104424:	75 06                	jne    ffffffff8010442c <scan_rdsp+0x78>
        return (struct acpi_rdsp *) p;
ffffffff80104426:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010442a:	eb 14                	jmp    ffffffff80104440 <scan_rdsp+0x8c>
  for (p = p2v(base); len >= sizeof(struct acpi_rdsp); len -= 4, p += 4) {
ffffffff8010442c:	83 6d e8 04          	subl   $0x4,-0x18(%rbp)
ffffffff80104430:	48 83 45 f8 04       	addq   $0x4,-0x8(%rbp)
ffffffff80104435:	83 7d e8 23          	cmpl   $0x23,-0x18(%rbp)
ffffffff80104439:	77 98                	ja     ffffffff801043d3 <scan_rdsp+0x1f>
    }
  }
  return (struct acpi_rdsp *) 0;  
ffffffff8010443b:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80104440:	c9                   	leave
ffffffff80104441:	c3                   	ret

ffffffff80104442 <find_rdsp>:

static struct acpi_rdsp *find_rdsp(void) {
ffffffff80104442:	55                   	push   %rbp
ffffffff80104443:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104446:	48 83 ec 10          	sub    $0x10,%rsp
  struct acpi_rdsp *rdsp;
  uintp pa;
  pa = *((ushort*) P2V(0x40E)) << 4; // EBDA
ffffffff8010444a:	48 c7 c0 0e 04 00 80 	mov    $0xffffffff8000040e,%rax
ffffffff80104451:	0f b7 00             	movzwl (%rax),%eax
ffffffff80104454:	0f b7 c0             	movzwl %ax,%eax
ffffffff80104457:	c1 e0 04             	shl    $0x4,%eax
ffffffff8010445a:	48 98                	cltq
ffffffff8010445c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if (pa && (rdsp = scan_rdsp(pa, 1024)))
ffffffff80104460:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80104465:	74 21                	je     ffffffff80104488 <find_rdsp+0x46>
ffffffff80104467:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010446b:	be 00 04 00 00       	mov    $0x400,%esi
ffffffff80104470:	89 c7                	mov    %eax,%edi
ffffffff80104472:	e8 3d ff ff ff       	call   ffffffff801043b4 <scan_rdsp>
ffffffff80104477:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff8010447b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80104480:	74 06                	je     ffffffff80104488 <find_rdsp+0x46>
    return rdsp;
ffffffff80104482:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104486:	eb 0f                	jmp    ffffffff80104497 <find_rdsp+0x55>
  return scan_rdsp(0xE0000, 0x20000);
ffffffff80104488:	be 00 00 02 00       	mov    $0x20000,%esi
ffffffff8010448d:	bf 00 00 0e 00       	mov    $0xe0000,%edi
ffffffff80104492:	e8 1d ff ff ff       	call   ffffffff801043b4 <scan_rdsp>
} 
ffffffff80104497:	c9                   	leave
ffffffff80104498:	c3                   	ret

ffffffff80104499 <acpi_config_smp>:

static int acpi_config_smp(struct acpi_madt *madt) {
ffffffff80104499:	55                   	push   %rbp
ffffffff8010449a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010449d:	48 83 ec 50          	sub    $0x50,%rsp
ffffffff801044a1:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  uint32 lapic_addr;
  uint nioapic = 0;
ffffffff801044a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  uchar *p, *e;

  if (!madt)
ffffffff801044ac:	48 83 7d b8 00       	cmpq   $0x0,-0x48(%rbp)
ffffffff801044b1:	75 0a                	jne    ffffffff801044bd <acpi_config_smp+0x24>
    return -1;
ffffffff801044b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801044b8:	e9 0c 02 00 00       	jmp    ffffffff801046c9 <acpi_config_smp+0x230>
  if (madt->header.length < sizeof(struct acpi_madt))
ffffffff801044bd:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801044c1:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801044c4:	83 f8 2b             	cmp    $0x2b,%eax
ffffffff801044c7:	77 0a                	ja     ffffffff801044d3 <acpi_config_smp+0x3a>
    return -1;
ffffffff801044c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801044ce:	e9 f6 01 00 00       	jmp    ffffffff801046c9 <acpi_config_smp+0x230>

  lapic_addr = madt->lapic_addr_phys;
ffffffff801044d3:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801044d7:	8b 40 24             	mov    0x24(%rax),%eax
ffffffff801044da:	89 45 ec             	mov    %eax,-0x14(%rbp)

  p = madt->table;
ffffffff801044dd:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801044e1:	48 83 c0 2c          	add    $0x2c,%rax
ffffffff801044e5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  e = p + madt->header.length - sizeof(struct acpi_madt);
ffffffff801044e9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff801044ed:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff801044f0:	89 c0                	mov    %eax,%eax
ffffffff801044f2:	48 8d 50 d4          	lea    -0x2c(%rax),%rdx
ffffffff801044f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801044fa:	48 01 d0             	add    %rdx,%rax
ffffffff801044fd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

  while (p < e) {
ffffffff80104501:	e9 78 01 00 00       	jmp    ffffffff8010467e <acpi_config_smp+0x1e5>
    uint len;
    if ((e - p) < 2)
ffffffff80104506:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010450a:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
ffffffff8010450e:	48 83 f8 01          	cmp    $0x1,%rax
ffffffff80104512:	0f 8e 76 01 00 00    	jle    ffffffff8010468e <acpi_config_smp+0x1f5>
      break;
    len = p[1];
ffffffff80104518:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010451c:	48 83 c0 01          	add    $0x1,%rax
ffffffff80104520:	0f b6 00             	movzbl (%rax),%eax
ffffffff80104523:	0f b6 c0             	movzbl %al,%eax
ffffffff80104526:	89 45 dc             	mov    %eax,-0x24(%rbp)
    if ((e - p) < len)
ffffffff80104529:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010452d:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
ffffffff80104531:	48 89 c2             	mov    %rax,%rdx
ffffffff80104534:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80104537:	48 39 c2             	cmp    %rax,%rdx
ffffffff8010453a:	0f 8c 51 01 00 00    	jl     ffffffff80104691 <acpi_config_smp+0x1f8>
      break;
    switch (p[0]) {
ffffffff80104540:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104544:	0f b6 00             	movzbl (%rax),%eax
ffffffff80104547:	0f b6 c0             	movzbl %al,%eax
ffffffff8010454a:	85 c0                	test   %eax,%eax
ffffffff8010454c:	74 0e                	je     ffffffff8010455c <acpi_config_smp+0xc3>
ffffffff8010454e:	83 f8 01             	cmp    $0x1,%eax
ffffffff80104551:	0f 84 ac 00 00 00    	je     ffffffff80104603 <acpi_config_smp+0x16a>
ffffffff80104557:	e9 1b 01 00 00       	jmp    ffffffff80104677 <acpi_config_smp+0x1de>
    case TYPE_LAPIC: {
      struct madt_lapic *lapic = (void*) p;
ffffffff8010455c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104560:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
      if (len < sizeof(*lapic))
ffffffff80104564:	83 7d dc 07          	cmpl   $0x7,-0x24(%rbp)
ffffffff80104568:	0f 86 02 01 00 00    	jbe    ffffffff80104670 <acpi_config_smp+0x1d7>
        break;
      if (!(lapic->flags & APIC_LAPIC_ENABLED))
ffffffff8010456e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80104572:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80104575:	83 e0 01             	and    $0x1,%eax
ffffffff80104578:	85 c0                	test   %eax,%eax
ffffffff8010457a:	0f 84 f3 00 00 00    	je     ffffffff80104673 <acpi_config_smp+0x1da>
        break;
      cprintf("acpi: cpu#%d apicid %d\n", ncpu, lapic->apic_id);
ffffffff80104580:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80104584:	0f b6 40 03          	movzbl 0x3(%rax),%eax
ffffffff80104588:	0f b6 d0             	movzbl %al,%edx
ffffffff8010458b:	8b 05 53 be 00 00    	mov    0xbe53(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80104591:	89 c6                	mov    %eax,%esi
ffffffff80104593:	48 c7 c7 91 9e 10 80 	mov    $0xffffffff80109e91,%rdi
ffffffff8010459a:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010459f:	e8 00 c0 ff ff       	call   ffffffff801005a4 <cprintf>
      cpus[ncpu].id = ncpu;
ffffffff801045a4:	8b 15 3a be 00 00    	mov    0xbe3a(%rip),%edx        # ffffffff801103e4 <ncpu>
ffffffff801045aa:	8b 05 34 be 00 00    	mov    0xbe34(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff801045b0:	89 d1                	mov    %edx,%ecx
ffffffff801045b2:	48 63 d0             	movslq %eax,%rdx
ffffffff801045b5:	48 89 d0             	mov    %rdx,%rax
ffffffff801045b8:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801045bc:	48 29 d0             	sub    %rdx,%rax
ffffffff801045bf:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801045c3:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff801045c9:	88 08                	mov    %cl,(%rax)
      cpus[ncpu].apicid = lapic->apic_id;
ffffffff801045cb:	8b 15 13 be 00 00    	mov    0xbe13(%rip),%edx        # ffffffff801103e4 <ncpu>
ffffffff801045d1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff801045d5:	0f b6 48 03          	movzbl 0x3(%rax),%ecx
ffffffff801045d9:	48 63 d2             	movslq %edx,%rdx
ffffffff801045dc:	48 89 d0             	mov    %rdx,%rax
ffffffff801045df:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801045e3:	48 29 d0             	sub    %rdx,%rax
ffffffff801045e6:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff801045ea:	48 05 61 fc 10 80    	add    $0xffffffff8010fc61,%rax
ffffffff801045f0:	88 08                	mov    %cl,(%rax)
      ncpu++;
ffffffff801045f2:	8b 05 ec bd 00 00    	mov    0xbdec(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff801045f8:	83 c0 01             	add    $0x1,%eax
ffffffff801045fb:	89 05 e3 bd 00 00    	mov    %eax,0xbde3(%rip)        # ffffffff801103e4 <ncpu>
      break;
ffffffff80104601:	eb 74                	jmp    ffffffff80104677 <acpi_config_smp+0x1de>
    }
    case TYPE_IOAPIC: {
      struct madt_ioapic *ioapic = (void*) p;
ffffffff80104603:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104607:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
      if (len < sizeof(*ioapic))
ffffffff8010460b:	83 7d dc 0b          	cmpl   $0xb,-0x24(%rbp)
ffffffff8010460f:	76 65                	jbe    ffffffff80104676 <acpi_config_smp+0x1dd>
        break;
      cprintf("acpi: ioapic#%d @%x id=%d base=%d\n",
ffffffff80104611:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80104615:	8b 70 08             	mov    0x8(%rax),%esi
        nioapic, ioapic->addr, ioapic->id, ioapic->interrupt_base);
ffffffff80104618:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010461c:	0f b6 40 02          	movzbl 0x2(%rax),%eax
      cprintf("acpi: ioapic#%d @%x id=%d base=%d\n",
ffffffff80104620:	0f b6 c8             	movzbl %al,%ecx
ffffffff80104623:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80104627:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff8010462a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010462d:	41 89 f0             	mov    %esi,%r8d
ffffffff80104630:	89 c6                	mov    %eax,%esi
ffffffff80104632:	48 c7 c7 b0 9e 10 80 	mov    $0xffffffff80109eb0,%rdi
ffffffff80104639:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010463e:	e8 61 bf ff ff       	call   ffffffff801005a4 <cprintf>
      if (nioapic) {
ffffffff80104643:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80104647:	74 13                	je     ffffffff8010465c <acpi_config_smp+0x1c3>
        cprintf("warning: multiple ioapics are not supported");
ffffffff80104649:	48 c7 c7 d8 9e 10 80 	mov    $0xffffffff80109ed8,%rdi
ffffffff80104650:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104655:	e8 4a bf ff ff       	call   ffffffff801005a4 <cprintf>
ffffffff8010465a:	eb 0e                	jmp    ffffffff8010466a <acpi_config_smp+0x1d1>
      } else {
        ioapicid = ioapic->id;
ffffffff8010465c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80104660:	0f b6 40 02          	movzbl 0x2(%rax),%eax
ffffffff80104664:	88 05 7e bd 00 00    	mov    %al,0xbd7e(%rip)        # ffffffff801103e8 <ioapicid>
      }
      nioapic++;
ffffffff8010466a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
      break;
ffffffff8010466e:	eb 07                	jmp    ffffffff80104677 <acpi_config_smp+0x1de>
        break;
ffffffff80104670:	90                   	nop
ffffffff80104671:	eb 04                	jmp    ffffffff80104677 <acpi_config_smp+0x1de>
        break;
ffffffff80104673:	90                   	nop
ffffffff80104674:	eb 01                	jmp    ffffffff80104677 <acpi_config_smp+0x1de>
        break;
ffffffff80104676:	90                   	nop
    }
    }
    p += len;
ffffffff80104677:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff8010467a:	48 01 45 f0          	add    %rax,-0x10(%rbp)
  while (p < e) {
ffffffff8010467e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104682:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
ffffffff80104686:	0f 82 7a fe ff ff    	jb     ffffffff80104506 <acpi_config_smp+0x6d>
ffffffff8010468c:	eb 04                	jmp    ffffffff80104692 <acpi_config_smp+0x1f9>
      break;
ffffffff8010468e:	90                   	nop
ffffffff8010468f:	eb 01                	jmp    ffffffff80104692 <acpi_config_smp+0x1f9>
      break;
ffffffff80104691:	90                   	nop
  }

  if (ncpu) {
ffffffff80104692:	8b 05 4c bd 00 00    	mov    0xbd4c(%rip),%eax        # ffffffff801103e4 <ncpu>
ffffffff80104698:	85 c0                	test   %eax,%eax
ffffffff8010469a:	74 28                	je     ffffffff801046c4 <acpi_config_smp+0x22b>
    ismp = 1;
ffffffff8010469c:	c7 05 3a bd 00 00 01 	movl   $0x1,0xbd3a(%rip)        # ffffffff801103e0 <ismp>
ffffffff801046a3:	00 00 00 
    lapic = IO2V(((uintp)lapic_addr));
ffffffff801046a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801046a9:	48 ba 00 00 00 42 fe 	movabs $0xfffffffe42000000,%rdx
ffffffff801046b0:	ff ff ff 
ffffffff801046b3:	48 01 d0             	add    %rdx,%rax
ffffffff801046b6:	48 89 05 c3 b4 00 00 	mov    %rax,0xb4c3(%rip)        # ffffffff8010fb80 <lapic>
    return 0;
ffffffff801046bd:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801046c2:	eb 05                	jmp    ffffffff801046c9 <acpi_config_smp+0x230>
  }

  return -1;
ffffffff801046c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff801046c9:	c9                   	leave
ffffffff801046ca:	c3                   	ret

ffffffff801046cb <acpiinit>:
#define PHYSLIMIT 0x80000000
#else
#define PHYSLIMIT 0x0E000000
#endif

int acpiinit(void) {
ffffffff801046cb:	55                   	push   %rbp
ffffffff801046cc:	48 89 e5             	mov    %rsp,%rbp
ffffffff801046cf:	48 83 ec 30          	sub    $0x30,%rsp
  unsigned n, count;
  struct acpi_rdsp *rdsp;
  struct acpi_rsdt *rsdt;
  struct acpi_madt *madt = 0;
ffffffff801046d3:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffffffff801046da:	00 

  rdsp = find_rdsp();
ffffffff801046db:	e8 62 fd ff ff       	call   ffffffff80104442 <find_rdsp>
ffffffff801046e0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  if (rdsp->rsdt_addr_phys > PHYSLIMIT)
ffffffff801046e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801046e8:	8b 40 10             	mov    0x10(%rax),%eax
ffffffff801046eb:	3d 00 00 00 80       	cmp    $0x80000000,%eax
ffffffff801046f0:	0f 87 a3 00 00 00    	ja     ffffffff80104799 <acpiinit+0xce>
    goto notmapped;
  rsdt = p2v(rdsp->rsdt_addr_phys);
ffffffff801046f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801046fa:	8b 40 10             	mov    0x10(%rax),%eax
ffffffff801046fd:	89 c0                	mov    %eax,%eax
ffffffff801046ff:	48 89 c7             	mov    %rax,%rdi
ffffffff80104702:	e8 95 fc ff ff       	call   ffffffff8010439c <p2v>
ffffffff80104707:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  count = (rsdt->header.length - sizeof(*rsdt)) / 4;
ffffffff8010470b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010470f:	8b 40 04             	mov    0x4(%rax),%eax
ffffffff80104712:	89 c0                	mov    %eax,%eax
ffffffff80104714:	48 83 e8 24          	sub    $0x24,%rax
ffffffff80104718:	48 c1 e8 02          	shr    $0x2,%rax
ffffffff8010471c:	89 45 dc             	mov    %eax,-0x24(%rbp)
  for (n = 0; n < count; n++) {
ffffffff8010471f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80104726:	eb 5b                	jmp    ffffffff80104783 <acpiinit+0xb8>
    struct acpi_desc_header *hdr = p2v(rsdt->entry[n]);
ffffffff80104728:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010472c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010472f:	48 83 c2 08          	add    $0x8,%rdx
ffffffff80104733:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffffffff80104737:	89 c0                	mov    %eax,%eax
ffffffff80104739:	48 89 c7             	mov    %rax,%rdi
ffffffff8010473c:	e8 5b fc ff ff       	call   ffffffff8010439c <p2v>
ffffffff80104741:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if (rsdt->entry[n] > PHYSLIMIT)
ffffffff80104745:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104749:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010474c:	48 83 c2 08          	add    $0x8,%rdx
ffffffff80104750:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffffffff80104754:	3d 00 00 00 80       	cmp    $0x80000000,%eax
ffffffff80104759:	77 41                	ja     ffffffff8010479c <acpiinit+0xd1>
    memmove(creator, hdr->creator_id, 4); creator[4] = 0;
    cprintf("acpi: %s %s %s %x %s %x\n",
      sig, id, tableid, hdr->oem_revision,
      creator, hdr->creator_revision);
#endif
    if (!memcmp(hdr->signature, SIG_MADT, 4))
ffffffff8010475b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010475f:	ba 04 00 00 00       	mov    $0x4,%edx
ffffffff80104764:	48 c7 c6 04 9f 10 80 	mov    $0xffffffff80109f04,%rsi
ffffffff8010476b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010476e:	e8 60 18 00 00       	call   ffffffff80105fd3 <memcmp>
ffffffff80104773:	85 c0                	test   %eax,%eax
ffffffff80104775:	75 08                	jne    ffffffff8010477f <acpiinit+0xb4>
      madt = (void*) hdr;
ffffffff80104777:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010477b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for (n = 0; n < count; n++) {
ffffffff8010477f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80104783:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104786:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff80104789:	72 9d                	jb     ffffffff80104728 <acpiinit+0x5d>
  }

  return acpi_config_smp(madt);
ffffffff8010478b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010478f:	48 89 c7             	mov    %rax,%rdi
ffffffff80104792:	e8 02 fd ff ff       	call   ffffffff80104499 <acpi_config_smp>
ffffffff80104797:	eb 1f                	jmp    ffffffff801047b8 <acpiinit+0xed>
    goto notmapped;
ffffffff80104799:	90                   	nop
ffffffff8010479a:	eb 01                	jmp    ffffffff8010479d <acpiinit+0xd2>
      goto notmapped;
ffffffff8010479c:	90                   	nop

notmapped:
  cprintf("acpi: tables above 0x%x not mapped.\n", PHYSLIMIT);
ffffffff8010479d:	be 00 00 00 80       	mov    $0x80000000,%esi
ffffffff801047a2:	48 c7 c7 10 9f 10 80 	mov    $0xffffffff80109f10,%rdi
ffffffff801047a9:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801047ae:	e8 f1 bd ff ff       	call   ffffffff801005a4 <cprintf>
  return -1;
ffffffff801047b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff801047b8:	c9                   	leave
ffffffff801047b9:	c3                   	ret

ffffffff801047ba <outb>:
{
ffffffff801047ba:	55                   	push   %rbp
ffffffff801047bb:	48 89 e5             	mov    %rsp,%rbp
ffffffff801047be:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801047c2:	89 fa                	mov    %edi,%edx
ffffffff801047c4:	89 f0                	mov    %esi,%eax
ffffffff801047c6:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff801047ca:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff801047cd:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff801047d1:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff801047d5:	ee                   	out    %al,(%dx)
}
ffffffff801047d6:	90                   	nop
ffffffff801047d7:	c9                   	leave
ffffffff801047d8:	c3                   	ret

ffffffff801047d9 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
ffffffff801047d9:	55                   	push   %rbp
ffffffff801047da:	48 89 e5             	mov    %rsp,%rbp
ffffffff801047dd:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801047e1:	89 f8                	mov    %edi,%eax
ffffffff801047e3:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  irqmask = mask;
ffffffff801047e7:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffffffff801047eb:	66 89 05 4e 6d 00 00 	mov    %ax,0x6d4e(%rip)        # ffffffff8010b540 <irqmask>
  outb(IO_PIC1+1, mask);
ffffffff801047f2:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffffffff801047f6:	0f b6 c0             	movzbl %al,%eax
ffffffff801047f9:	89 c6                	mov    %eax,%esi
ffffffff801047fb:	bf 21 00 00 00       	mov    $0x21,%edi
ffffffff80104800:	e8 b5 ff ff ff       	call   ffffffff801047ba <outb>
  outb(IO_PIC2+1, mask >> 8);
ffffffff80104805:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffffffff80104809:	66 c1 e8 08          	shr    $0x8,%ax
ffffffff8010480d:	0f b6 c0             	movzbl %al,%eax
ffffffff80104810:	89 c6                	mov    %eax,%esi
ffffffff80104812:	bf a1 00 00 00       	mov    $0xa1,%edi
ffffffff80104817:	e8 9e ff ff ff       	call   ffffffff801047ba <outb>
}
ffffffff8010481c:	90                   	nop
ffffffff8010481d:	c9                   	leave
ffffffff8010481e:	c3                   	ret

ffffffff8010481f <picenable>:

void
picenable(int irq)
{
ffffffff8010481f:	55                   	push   %rbp
ffffffff80104820:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104823:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80104827:	89 7d fc             	mov    %edi,-0x4(%rbp)
  picsetmask(irqmask & ~(1<<irq));
ffffffff8010482a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010482d:	ba 01 00 00 00       	mov    $0x1,%edx
ffffffff80104832:	89 c1                	mov    %eax,%ecx
ffffffff80104834:	d3 e2                	shl    %cl,%edx
ffffffff80104836:	89 d0                	mov    %edx,%eax
ffffffff80104838:	f7 d0                	not    %eax
ffffffff8010483a:	89 c2                	mov    %eax,%edx
ffffffff8010483c:	0f b7 05 fd 6c 00 00 	movzwl 0x6cfd(%rip),%eax        # ffffffff8010b540 <irqmask>
ffffffff80104843:	21 d0                	and    %edx,%eax
ffffffff80104845:	0f b7 c0             	movzwl %ax,%eax
ffffffff80104848:	89 c7                	mov    %eax,%edi
ffffffff8010484a:	e8 8a ff ff ff       	call   ffffffff801047d9 <picsetmask>
}
ffffffff8010484f:	90                   	nop
ffffffff80104850:	c9                   	leave
ffffffff80104851:	c3                   	ret

ffffffff80104852 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
ffffffff80104852:	55                   	push   %rbp
ffffffff80104853:	48 89 e5             	mov    %rsp,%rbp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
ffffffff80104856:	be ff 00 00 00       	mov    $0xff,%esi
ffffffff8010485b:	bf 21 00 00 00       	mov    $0x21,%edi
ffffffff80104860:	e8 55 ff ff ff       	call   ffffffff801047ba <outb>
  outb(IO_PIC2+1, 0xFF);
ffffffff80104865:	be ff 00 00 00       	mov    $0xff,%esi
ffffffff8010486a:	bf a1 00 00 00       	mov    $0xa1,%edi
ffffffff8010486f:	e8 46 ff ff ff       	call   ffffffff801047ba <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
ffffffff80104874:	be 11 00 00 00       	mov    $0x11,%esi
ffffffff80104879:	bf 20 00 00 00       	mov    $0x20,%edi
ffffffff8010487e:	e8 37 ff ff ff       	call   ffffffff801047ba <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
ffffffff80104883:	be 20 00 00 00       	mov    $0x20,%esi
ffffffff80104888:	bf 21 00 00 00       	mov    $0x21,%edi
ffffffff8010488d:	e8 28 ff ff ff       	call   ffffffff801047ba <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
ffffffff80104892:	be 04 00 00 00       	mov    $0x4,%esi
ffffffff80104897:	bf 21 00 00 00       	mov    $0x21,%edi
ffffffff8010489c:	e8 19 ff ff ff       	call   ffffffff801047ba <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
ffffffff801048a1:	be 03 00 00 00       	mov    $0x3,%esi
ffffffff801048a6:	bf 21 00 00 00       	mov    $0x21,%edi
ffffffff801048ab:	e8 0a ff ff ff       	call   ffffffff801047ba <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
ffffffff801048b0:	be 11 00 00 00       	mov    $0x11,%esi
ffffffff801048b5:	bf a0 00 00 00       	mov    $0xa0,%edi
ffffffff801048ba:	e8 fb fe ff ff       	call   ffffffff801047ba <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
ffffffff801048bf:	be 28 00 00 00       	mov    $0x28,%esi
ffffffff801048c4:	bf a1 00 00 00       	mov    $0xa1,%edi
ffffffff801048c9:	e8 ec fe ff ff       	call   ffffffff801047ba <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
ffffffff801048ce:	be 02 00 00 00       	mov    $0x2,%esi
ffffffff801048d3:	bf a1 00 00 00       	mov    $0xa1,%edi
ffffffff801048d8:	e8 dd fe ff ff       	call   ffffffff801047ba <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
ffffffff801048dd:	be 03 00 00 00       	mov    $0x3,%esi
ffffffff801048e2:	bf a1 00 00 00       	mov    $0xa1,%edi
ffffffff801048e7:	e8 ce fe ff ff       	call   ffffffff801047ba <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
ffffffff801048ec:	be 68 00 00 00       	mov    $0x68,%esi
ffffffff801048f1:	bf 20 00 00 00       	mov    $0x20,%edi
ffffffff801048f6:	e8 bf fe ff ff       	call   ffffffff801047ba <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
ffffffff801048fb:	be 0a 00 00 00       	mov    $0xa,%esi
ffffffff80104900:	bf 20 00 00 00       	mov    $0x20,%edi
ffffffff80104905:	e8 b0 fe ff ff       	call   ffffffff801047ba <outb>

  outb(IO_PIC2, 0x68);             // OCW3
ffffffff8010490a:	be 68 00 00 00       	mov    $0x68,%esi
ffffffff8010490f:	bf a0 00 00 00       	mov    $0xa0,%edi
ffffffff80104914:	e8 a1 fe ff ff       	call   ffffffff801047ba <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
ffffffff80104919:	be 0a 00 00 00       	mov    $0xa,%esi
ffffffff8010491e:	bf a0 00 00 00       	mov    $0xa0,%edi
ffffffff80104923:	e8 92 fe ff ff       	call   ffffffff801047ba <outb>

  if(irqmask != 0xFFFF)
ffffffff80104928:	0f b7 05 11 6c 00 00 	movzwl 0x6c11(%rip),%eax        # ffffffff8010b540 <irqmask>
ffffffff8010492f:	66 83 f8 ff          	cmp    $0xffff,%ax
ffffffff80104933:	74 11                	je     ffffffff80104946 <picinit+0xf4>
    picsetmask(irqmask);
ffffffff80104935:	0f b7 05 04 6c 00 00 	movzwl 0x6c04(%rip),%eax        # ffffffff8010b540 <irqmask>
ffffffff8010493c:	0f b7 c0             	movzwl %ax,%eax
ffffffff8010493f:	89 c7                	mov    %eax,%edi
ffffffff80104941:	e8 93 fe ff ff       	call   ffffffff801047d9 <picsetmask>
}
ffffffff80104946:	90                   	nop
ffffffff80104947:	5d                   	pop    %rbp
ffffffff80104948:	c3                   	ret

ffffffff80104949 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
ffffffff80104949:	55                   	push   %rbp
ffffffff8010494a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010494d:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80104951:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80104955:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipe *p;

  p = 0;
ffffffff80104959:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffffffff80104960:	00 
  *f0 = *f1 = 0;
ffffffff80104961:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104965:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffffffff8010496c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104970:	48 8b 10             	mov    (%rax),%rdx
ffffffff80104973:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104977:	48 89 10             	mov    %rdx,(%rax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
ffffffff8010497a:	e8 11 cb ff ff       	call   ffffffff80101490 <filealloc>
ffffffff8010497f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80104983:	48 89 02             	mov    %rax,(%rdx)
ffffffff80104986:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010498a:	48 8b 00             	mov    (%rax),%rax
ffffffff8010498d:	48 85 c0             	test   %rax,%rax
ffffffff80104990:	0f 84 e6 00 00 00    	je     ffffffff80104a7c <pipealloc+0x133>
ffffffff80104996:	e8 f5 ca ff ff       	call   ffffffff80101490 <filealloc>
ffffffff8010499b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff8010499f:	48 89 02             	mov    %rax,(%rdx)
ffffffff801049a2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801049a6:	48 8b 00             	mov    (%rax),%rax
ffffffff801049a9:	48 85 c0             	test   %rax,%rax
ffffffff801049ac:	0f 84 ca 00 00 00    	je     ffffffff80104a7c <pipealloc+0x133>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
ffffffff801049b2:	e8 22 e9 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff801049b7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801049bb:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801049c0:	0f 84 b9 00 00 00    	je     ffffffff80104a7f <pipealloc+0x136>
    goto bad;
  p->readopen = 1;
ffffffff801049c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801049ca:	c7 80 70 02 00 00 01 	movl   $0x1,0x270(%rax)
ffffffff801049d1:	00 00 00 
  p->writeopen = 1;
ffffffff801049d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801049d8:	c7 80 74 02 00 00 01 	movl   $0x1,0x274(%rax)
ffffffff801049df:	00 00 00 
  p->nwrite = 0;
ffffffff801049e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801049e6:	c7 80 6c 02 00 00 00 	movl   $0x0,0x26c(%rax)
ffffffff801049ed:	00 00 00 
  p->nread = 0;
ffffffff801049f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801049f4:	c7 80 68 02 00 00 00 	movl   $0x0,0x268(%rax)
ffffffff801049fb:	00 00 00 
  initlock(&p->lock, "pipe");
ffffffff801049fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104a02:	48 c7 c6 35 9f 10 80 	mov    $0xffffffff80109f35,%rsi
ffffffff80104a09:	48 89 c7             	mov    %rax,%rdi
ffffffff80104a0c:	e8 9d 11 00 00       	call   ffffffff80105bae <initlock>
  (*f0)->type = FD_PIPE;
ffffffff80104a11:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104a15:	48 8b 00             	mov    (%rax),%rax
ffffffff80104a18:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f0)->readable = 1;
ffffffff80104a1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104a22:	48 8b 00             	mov    (%rax),%rax
ffffffff80104a25:	c6 40 08 01          	movb   $0x1,0x8(%rax)
  (*f0)->writable = 0;
ffffffff80104a29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104a2d:	48 8b 00             	mov    (%rax),%rax
ffffffff80104a30:	c6 40 09 00          	movb   $0x0,0x9(%rax)
  (*f0)->pipe = p;
ffffffff80104a34:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104a38:	48 8b 00             	mov    (%rax),%rax
ffffffff80104a3b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80104a3f:	48 89 50 10          	mov    %rdx,0x10(%rax)
  (*f1)->type = FD_PIPE;
ffffffff80104a43:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104a47:	48 8b 00             	mov    (%rax),%rax
ffffffff80104a4a:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f1)->readable = 0;
ffffffff80104a50:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104a54:	48 8b 00             	mov    (%rax),%rax
ffffffff80104a57:	c6 40 08 00          	movb   $0x0,0x8(%rax)
  (*f1)->writable = 1;
ffffffff80104a5b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104a5f:	48 8b 00             	mov    (%rax),%rax
ffffffff80104a62:	c6 40 09 01          	movb   $0x1,0x9(%rax)
  (*f1)->pipe = p;
ffffffff80104a66:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104a6a:	48 8b 00             	mov    (%rax),%rax
ffffffff80104a6d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80104a71:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return 0;
ffffffff80104a75:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104a7a:	eb 52                	jmp    ffffffff80104ace <pipealloc+0x185>
    goto bad;
ffffffff80104a7c:	90                   	nop
ffffffff80104a7d:	eb 01                	jmp    ffffffff80104a80 <pipealloc+0x137>
    goto bad;
ffffffff80104a7f:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
ffffffff80104a80:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80104a85:	74 0c                	je     ffffffff80104a93 <pipealloc+0x14a>
    kfree((char*)p);
ffffffff80104a87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104a8b:	48 89 c7             	mov    %rax,%rdi
ffffffff80104a8e:	e8 9c e7 ff ff       	call   ffffffff8010322f <kfree>
  if(*f0)
ffffffff80104a93:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104a97:	48 8b 00             	mov    (%rax),%rax
ffffffff80104a9a:	48 85 c0             	test   %rax,%rax
ffffffff80104a9d:	74 0f                	je     ffffffff80104aae <pipealloc+0x165>
    fileclose(*f0);
ffffffff80104a9f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104aa3:	48 8b 00             	mov    (%rax),%rax
ffffffff80104aa6:	48 89 c7             	mov    %rax,%rdi
ffffffff80104aa9:	e8 9f ca ff ff       	call   ffffffff8010154d <fileclose>
  if(*f1)
ffffffff80104aae:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104ab2:	48 8b 00             	mov    (%rax),%rax
ffffffff80104ab5:	48 85 c0             	test   %rax,%rax
ffffffff80104ab8:	74 0f                	je     ffffffff80104ac9 <pipealloc+0x180>
    fileclose(*f1);
ffffffff80104aba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104abe:	48 8b 00             	mov    (%rax),%rax
ffffffff80104ac1:	48 89 c7             	mov    %rax,%rdi
ffffffff80104ac4:	e8 84 ca ff ff       	call   ffffffff8010154d <fileclose>
  return -1;
ffffffff80104ac9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80104ace:	c9                   	leave
ffffffff80104acf:	c3                   	ret

ffffffff80104ad0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
ffffffff80104ad0:	55                   	push   %rbp
ffffffff80104ad1:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104ad4:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80104ad8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80104adc:	89 75 f4             	mov    %esi,-0xc(%rbp)
  acquire(&p->lock);
ffffffff80104adf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104ae3:	48 89 c7             	mov    %rax,%rdi
ffffffff80104ae6:	e8 f8 10 00 00       	call   ffffffff80105be3 <acquire>
  if(writable){
ffffffff80104aeb:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffffffff80104aef:	74 22                	je     ffffffff80104b13 <pipeclose+0x43>
    p->writeopen = 0;
ffffffff80104af1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104af5:	c7 80 74 02 00 00 00 	movl   $0x0,0x274(%rax)
ffffffff80104afc:	00 00 00 
    wakeup(&p->nread);
ffffffff80104aff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b03:	48 05 68 02 00 00    	add    $0x268,%rax
ffffffff80104b09:	48 89 c7             	mov    %rax,%rdi
ffffffff80104b0c:	e8 62 0e 00 00       	call   ffffffff80105973 <wakeup>
ffffffff80104b11:	eb 20                	jmp    ffffffff80104b33 <pipeclose+0x63>
  } else {
    p->readopen = 0;
ffffffff80104b13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b17:	c7 80 70 02 00 00 00 	movl   $0x0,0x270(%rax)
ffffffff80104b1e:	00 00 00 
    wakeup(&p->nwrite);
ffffffff80104b21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b25:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffffffff80104b2b:	48 89 c7             	mov    %rax,%rdi
ffffffff80104b2e:	e8 40 0e 00 00       	call   ffffffff80105973 <wakeup>
  }
  if(p->readopen == 0 && p->writeopen == 0){
ffffffff80104b33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b37:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffffffff80104b3d:	85 c0                	test   %eax,%eax
ffffffff80104b3f:	75 28                	jne    ffffffff80104b69 <pipeclose+0x99>
ffffffff80104b41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b45:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffffffff80104b4b:	85 c0                	test   %eax,%eax
ffffffff80104b4d:	75 1a                	jne    ffffffff80104b69 <pipeclose+0x99>
    release(&p->lock);
ffffffff80104b4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b53:	48 89 c7             	mov    %rax,%rdi
ffffffff80104b56:	e8 5f 11 00 00       	call   ffffffff80105cba <release>
    kfree((char*)p);
ffffffff80104b5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b5f:	48 89 c7             	mov    %rax,%rdi
ffffffff80104b62:	e8 c8 e6 ff ff       	call   ffffffff8010322f <kfree>
ffffffff80104b67:	eb 0d                	jmp    ffffffff80104b76 <pipeclose+0xa6>
  } else
    release(&p->lock);
ffffffff80104b69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104b6d:	48 89 c7             	mov    %rax,%rdi
ffffffff80104b70:	e8 45 11 00 00       	call   ffffffff80105cba <release>
}
ffffffff80104b75:	90                   	nop
ffffffff80104b76:	90                   	nop
ffffffff80104b77:	c9                   	leave
ffffffff80104b78:	c3                   	ret

ffffffff80104b79 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
ffffffff80104b79:	55                   	push   %rbp
ffffffff80104b7a:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104b7d:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80104b81:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80104b85:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80104b89:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffffffff80104b8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104b90:	48 89 c7             	mov    %rax,%rdi
ffffffff80104b93:	e8 4b 10 00 00       	call   ffffffff80105be3 <acquire>
  for(i = 0; i < n; i++){
ffffffff80104b98:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80104b9f:	e9 bc 00 00 00       	jmp    ffffffff80104c60 <pipewrite+0xe7>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
ffffffff80104ba4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104ba8:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffffffff80104bae:	85 c0                	test   %eax,%eax
ffffffff80104bb0:	74 12                	je     ffffffff80104bc4 <pipewrite+0x4b>
ffffffff80104bb2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80104bb9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80104bbd:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80104bc0:	85 c0                	test   %eax,%eax
ffffffff80104bc2:	74 16                	je     ffffffff80104bda <pipewrite+0x61>
        release(&p->lock);
ffffffff80104bc4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104bc8:	48 89 c7             	mov    %rax,%rdi
ffffffff80104bcb:	e8 ea 10 00 00       	call   ffffffff80105cba <release>
        return -1;
ffffffff80104bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80104bd5:	e9 af 00 00 00       	jmp    ffffffff80104c89 <pipewrite+0x110>
      }
      wakeup(&p->nread);
ffffffff80104bda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104bde:	48 05 68 02 00 00    	add    $0x268,%rax
ffffffff80104be4:	48 89 c7             	mov    %rax,%rdi
ffffffff80104be7:	e8 87 0d 00 00       	call   ffffffff80105973 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
ffffffff80104bec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104bf0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80104bf4:	48 81 c2 6c 02 00 00 	add    $0x26c,%rdx
ffffffff80104bfb:	48 89 c6             	mov    %rax,%rsi
ffffffff80104bfe:	48 89 d7             	mov    %rdx,%rdi
ffffffff80104c01:	e8 59 0c 00 00       	call   ffffffff8010585f <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
ffffffff80104c06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104c0a:	8b 90 6c 02 00 00    	mov    0x26c(%rax),%edx
ffffffff80104c10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104c14:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffffffff80104c1a:	05 00 02 00 00       	add    $0x200,%eax
ffffffff80104c1f:	39 c2                	cmp    %eax,%edx
ffffffff80104c21:	74 81                	je     ffffffff80104ba4 <pipewrite+0x2b>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
ffffffff80104c23:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104c26:	48 63 d0             	movslq %eax,%rdx
ffffffff80104c29:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104c2d:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
ffffffff80104c31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104c35:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffffffff80104c3b:	8d 48 01             	lea    0x1(%rax),%ecx
ffffffff80104c3e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80104c42:	89 8a 6c 02 00 00    	mov    %ecx,0x26c(%rdx)
ffffffff80104c48:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff80104c4d:	89 c1                	mov    %eax,%ecx
ffffffff80104c4f:	0f b6 16             	movzbl (%rsi),%edx
ffffffff80104c52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104c56:	89 c9                	mov    %ecx,%ecx
ffffffff80104c58:	88 54 08 68          	mov    %dl,0x68(%rax,%rcx,1)
  for(i = 0; i < n; i++){
ffffffff80104c5c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80104c60:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104c63:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff80104c66:	7c 9e                	jl     ffffffff80104c06 <pipewrite+0x8d>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
ffffffff80104c68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104c6c:	48 05 68 02 00 00    	add    $0x268,%rax
ffffffff80104c72:	48 89 c7             	mov    %rax,%rdi
ffffffff80104c75:	e8 f9 0c 00 00       	call   ffffffff80105973 <wakeup>
  release(&p->lock);
ffffffff80104c7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104c7e:	48 89 c7             	mov    %rax,%rdi
ffffffff80104c81:	e8 34 10 00 00       	call   ffffffff80105cba <release>
  return n;
ffffffff80104c86:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffffffff80104c89:	c9                   	leave
ffffffff80104c8a:	c3                   	ret

ffffffff80104c8b <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
ffffffff80104c8b:	55                   	push   %rbp
ffffffff80104c8c:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104c8f:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80104c93:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80104c97:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80104c9b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffffffff80104c9e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104ca2:	48 89 c7             	mov    %rax,%rdi
ffffffff80104ca5:	e8 39 0f 00 00       	call   ffffffff80105be3 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffffffff80104caa:	eb 42                	jmp    ffffffff80104cee <piperead+0x63>
    if(proc->killed){
ffffffff80104cac:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80104cb3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80104cb7:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80104cba:	85 c0                	test   %eax,%eax
ffffffff80104cbc:	74 16                	je     ffffffff80104cd4 <piperead+0x49>
      release(&p->lock);
ffffffff80104cbe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104cc2:	48 89 c7             	mov    %rax,%rdi
ffffffff80104cc5:	e8 f0 0f 00 00       	call   ffffffff80105cba <release>
      return -1;
ffffffff80104cca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80104ccf:	e9 c9 00 00 00       	jmp    ffffffff80104d9d <piperead+0x112>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
ffffffff80104cd4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104cd8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80104cdc:	48 81 c2 68 02 00 00 	add    $0x268,%rdx
ffffffff80104ce3:	48 89 c6             	mov    %rax,%rsi
ffffffff80104ce6:	48 89 d7             	mov    %rdx,%rdi
ffffffff80104ce9:	e8 71 0b 00 00       	call   ffffffff8010585f <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffffffff80104cee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104cf2:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffffffff80104cf8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104cfc:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffffffff80104d02:	39 c2                	cmp    %eax,%edx
ffffffff80104d04:	75 0e                	jne    ffffffff80104d14 <piperead+0x89>
ffffffff80104d06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d0a:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffffffff80104d10:	85 c0                	test   %eax,%eax
ffffffff80104d12:	75 98                	jne    ffffffff80104cac <piperead+0x21>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffffffff80104d14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80104d1b:	eb 54                	jmp    ffffffff80104d71 <piperead+0xe6>
    if(p->nread == p->nwrite)
ffffffff80104d1d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d21:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffffffff80104d27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d2b:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffffffff80104d31:	39 c2                	cmp    %eax,%edx
ffffffff80104d33:	74 46                	je     ffffffff80104d7b <piperead+0xf0>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
ffffffff80104d35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d39:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffffffff80104d3f:	8d 48 01             	lea    0x1(%rax),%ecx
ffffffff80104d42:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80104d46:	89 8a 68 02 00 00    	mov    %ecx,0x268(%rdx)
ffffffff80104d4c:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff80104d51:	89 c1                	mov    %eax,%ecx
ffffffff80104d53:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104d56:	48 63 d0             	movslq %eax,%rdx
ffffffff80104d59:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80104d5d:	48 01 c2             	add    %rax,%rdx
ffffffff80104d60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d64:	89 c9                	mov    %ecx,%ecx
ffffffff80104d66:	0f b6 44 08 68       	movzbl 0x68(%rax,%rcx,1),%eax
ffffffff80104d6b:	88 02                	mov    %al,(%rdx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffffffff80104d6d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80104d71:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80104d74:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffffffff80104d77:	7c a4                	jl     ffffffff80104d1d <piperead+0x92>
ffffffff80104d79:	eb 01                	jmp    ffffffff80104d7c <piperead+0xf1>
      break;
ffffffff80104d7b:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
ffffffff80104d7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d80:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffffffff80104d86:	48 89 c7             	mov    %rax,%rdi
ffffffff80104d89:	e8 e5 0b 00 00       	call   ffffffff80105973 <wakeup>
  release(&p->lock);
ffffffff80104d8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80104d92:	48 89 c7             	mov    %rax,%rdi
ffffffff80104d95:	e8 20 0f 00 00       	call   ffffffff80105cba <release>
  return i;
ffffffff80104d9a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff80104d9d:	c9                   	leave
ffffffff80104d9e:	c3                   	ret

ffffffff80104d9f <readeflags>:
{
ffffffff80104d9f:	55                   	push   %rbp
ffffffff80104da0:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104da3:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffffffff80104da7:	9c                   	pushf
ffffffff80104da8:	58                   	pop    %rax
ffffffff80104da9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffffffff80104dad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80104db1:	c9                   	leave
ffffffff80104db2:	c3                   	ret

ffffffff80104db3 <sti>:
{
ffffffff80104db3:	55                   	push   %rbp
ffffffff80104db4:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffffffff80104db7:	fb                   	sti
}
ffffffff80104db8:	90                   	nop
ffffffff80104db9:	5d                   	pop    %rbp
ffffffff80104dba:	c3                   	ret

ffffffff80104dbb <hlt>:
{
ffffffff80104dbb:	55                   	push   %rbp
ffffffff80104dbc:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("hlt");
ffffffff80104dbf:	f4                   	hlt
}
ffffffff80104dc0:	90                   	nop
ffffffff80104dc1:	5d                   	pop    %rbp
ffffffff80104dc2:	c3                   	ret

ffffffff80104dc3 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
ffffffff80104dc3:	55                   	push   %rbp
ffffffff80104dc4:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ptable.lock, "ptable");
ffffffff80104dc7:	48 c7 c6 3a 9f 10 80 	mov    $0xffffffff80109f3a,%rsi
ffffffff80104dce:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80104dd5:	e8 d4 0d 00 00       	call   ffffffff80105bae <initlock>
}
ffffffff80104dda:	90                   	nop
ffffffff80104ddb:	5d                   	pop    %rbp
ffffffff80104ddc:	c3                   	ret

ffffffff80104ddd <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
ffffffff80104ddd:	55                   	push   %rbp
ffffffff80104dde:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104de1:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
ffffffff80104de5:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80104dec:	e8 f2 0d 00 00       	call   ffffffff80105be3 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffffffff80104df1:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff80104df8:	80 
ffffffff80104df9:	eb 13                	jmp    ffffffff80104e0e <allocproc+0x31>
    if(p->state == UNUSED)
ffffffff80104dfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104dff:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80104e02:	85 c0                	test   %eax,%eax
ffffffff80104e04:	74 28                	je     ffffffff80104e2e <allocproc+0x51>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffffffff80104e06:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff80104e0d:	00 
ffffffff80104e0e:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff80104e15:	80 
ffffffff80104e16:	72 e3                	jb     ffffffff80104dfb <allocproc+0x1e>
      goto found;
  release(&ptable.lock);
ffffffff80104e18:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80104e1f:	e8 96 0e 00 00       	call   ffffffff80105cba <release>
  return 0;
ffffffff80104e24:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104e29:	e9 e3 00 00 00       	jmp    ffffffff80104f11 <allocproc+0x134>
      goto found;
ffffffff80104e2e:	90                   	nop

found:
  p->state = EMBRYO;
ffffffff80104e2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104e33:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
  p->pid = nextpid++;
ffffffff80104e3a:	8b 05 20 67 00 00    	mov    0x6720(%rip),%eax        # ffffffff8010b560 <nextpid>
ffffffff80104e40:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80104e43:	89 15 17 67 00 00    	mov    %edx,0x6717(%rip)        # ffffffff8010b560 <nextpid>
ffffffff80104e49:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80104e4d:	89 42 1c             	mov    %eax,0x1c(%rdx)
  p->ticks = 0;
ffffffff80104e50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104e54:	c7 80 e4 00 00 00 00 	movl   $0x0,0xe4(%rax)
ffffffff80104e5b:	00 00 00 
  release(&ptable.lock);
ffffffff80104e5e:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80104e65:	e8 50 0e 00 00       	call   ffffffff80105cba <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
ffffffff80104e6a:	e8 6a e4 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80104e6f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80104e73:	48 89 42 10          	mov    %rax,0x10(%rdx)
ffffffff80104e77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104e7b:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80104e7f:	48 85 c0             	test   %rax,%rax
ffffffff80104e82:	75 12                	jne    ffffffff80104e96 <allocproc+0xb9>
    p->state = UNUSED;
ffffffff80104e84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104e88:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return 0;
ffffffff80104e8f:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80104e94:	eb 7b                	jmp    ffffffff80104f11 <allocproc+0x134>
  }
  sp = p->kstack + KSTACKSIZE;
ffffffff80104e96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104e9a:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80104e9e:	48 05 00 10 00 00    	add    $0x1000,%rax
ffffffff80104ea4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
ffffffff80104ea8:	48 81 6d f0 b0 00 00 	subq   $0xb0,-0x10(%rbp)
ffffffff80104eaf:	00 
  p->tf = (struct trapframe*)sp;
ffffffff80104eb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104eb4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80104eb8:	48 89 50 28          	mov    %rdx,0x28(%rax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= sizeof(uintp);
ffffffff80104ebc:	48 83 6d f0 08       	subq   $0x8,-0x10(%rbp)
  *(uintp*)sp = (uintp)trapret;
ffffffff80104ec1:	48 c7 c2 44 79 10 80 	mov    $0xffffffff80107944,%rdx
ffffffff80104ec8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80104ecc:	48 89 10             	mov    %rdx,(%rax)

  sp -= sizeof *p->context;
ffffffff80104ecf:	48 83 6d f0 40       	subq   $0x40,-0x10(%rbp)
  p->context = (struct context*)sp;
ffffffff80104ed4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104ed8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80104edc:	48 89 50 30          	mov    %rdx,0x30(%rax)
  memset(p->context, 0, sizeof *p->context);
ffffffff80104ee0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104ee4:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff80104ee8:	ba 40 00 00 00       	mov    $0x40,%edx
ffffffff80104eed:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80104ef2:	48 89 c7             	mov    %rax,%rdi
ffffffff80104ef5:	e8 59 10 00 00       	call   ffffffff80105f53 <memset>
  p->context->eip = (uintp)forkret;
ffffffff80104efa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104efe:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff80104f02:	48 c7 c2 33 58 10 80 	mov    $0xffffffff80105833,%rdx
ffffffff80104f09:	48 89 50 38          	mov    %rdx,0x38(%rax)

  return p;
ffffffff80104f0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80104f11:	c9                   	leave
ffffffff80104f12:	c3                   	ret

ffffffff80104f13 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
ffffffff80104f13:	55                   	push   %rbp
ffffffff80104f14:	48 89 e5             	mov    %rsp,%rbp
ffffffff80104f17:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  extern char _binary_out_initcode_start[], _binary_out_initcode_size[];
  
  p = allocproc();
ffffffff80104f1b:	e8 bd fe ff ff       	call   ffffffff80104ddd <allocproc>
ffffffff80104f20:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  initproc = p;
ffffffff80104f24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104f28:	48 89 05 39 f1 00 00 	mov    %rax,0xf139(%rip)        # ffffffff80114068 <initproc>
  if((p->pgdir = setupkvm()) == 0)
ffffffff80104f2f:	e8 35 49 00 00       	call   ffffffff80109869 <setupkvm>
ffffffff80104f34:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80104f38:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffffffff80104f3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104f40:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80104f44:	48 85 c0             	test   %rax,%rax
ffffffff80104f47:	75 0c                	jne    ffffffff80104f55 <userinit+0x42>
    panic("userinit: out of memory?");
ffffffff80104f49:	48 c7 c7 41 9f 10 80 	mov    $0xffffffff80109f41,%rdi
ffffffff80104f50:	e8 da b9 ff ff       	call   ffffffff8010092f <panic>
  inituvm(p->pgdir, _binary_out_initcode_start, (uintp)_binary_out_initcode_size);
ffffffff80104f55:	48 c7 c0 3c 00 00 00 	mov    $0x3c,%rax
ffffffff80104f5c:	89 c2                	mov    %eax,%edx
ffffffff80104f5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104f62:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80104f66:	48 c7 c6 a8 be 10 80 	mov    $0xffffffff8010bea8,%rsi
ffffffff80104f6d:	48 89 c7             	mov    %rax,%rdi
ffffffff80104f70:	e8 4b 3b 00 00       	call   ffffffff80108ac0 <inituvm>
  p->sz = PGSIZE;
ffffffff80104f75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104f79:	48 c7 00 00 10 00 00 	movq   $0x1000,(%rax)
  memset(p->tf, 0, sizeof(*p->tf));
ffffffff80104f80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104f84:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80104f88:	ba b0 00 00 00       	mov    $0xb0,%edx
ffffffff80104f8d:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80104f92:	48 89 c7             	mov    %rax,%rdi
ffffffff80104f95:	e8 b9 0f 00 00       	call   ffffffff80105f53 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
ffffffff80104f9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104f9e:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80104fa2:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
ffffffff80104fa9:	23 00 00 00 
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
ffffffff80104fad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104fb1:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80104fb5:	48 c7 80 a8 00 00 00 	movq   $0x2b,0xa8(%rax)
ffffffff80104fbc:	2b 00 00 00 
#ifndef X64
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
#endif
  p->tf->eflags = FL_IF;
ffffffff80104fc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104fc4:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80104fc8:	48 c7 80 98 00 00 00 	movq   $0x200,0x98(%rax)
ffffffff80104fcf:	00 02 00 00 
  p->tf->esp = PGSIZE;
ffffffff80104fd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104fd7:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80104fdb:	48 c7 80 a0 00 00 00 	movq   $0x1000,0xa0(%rax)
ffffffff80104fe2:	00 10 00 00 
  p->tf->eip = 0;  // beginning of initcode.S
ffffffff80104fe6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104fea:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80104fee:	48 c7 80 88 00 00 00 	movq   $0x0,0x88(%rax)
ffffffff80104ff5:	00 00 00 00 

  safestrcpy(p->name, "initcode", sizeof(p->name));
ffffffff80104ff9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80104ffd:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffffffff80105003:	ba 10 00 00 00       	mov    $0x10,%edx
ffffffff80105008:	48 c7 c6 5a 9f 10 80 	mov    $0xffffffff80109f5a,%rsi
ffffffff8010500f:	48 89 c7             	mov    %rax,%rdi
ffffffff80105012:	e8 d7 11 00 00       	call   ffffffff801061ee <safestrcpy>
  p->cwd = namei("/");
ffffffff80105017:	48 c7 c7 63 9f 10 80 	mov    $0xffffffff80109f63,%rdi
ffffffff8010501e:	e8 40 db ff ff       	call   ffffffff80102b63 <namei>
ffffffff80105023:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80105027:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  p->state = RUNNABLE;
ffffffff8010502e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105032:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
}
ffffffff80105039:	90                   	nop
ffffffff8010503a:	c9                   	leave
ffffffff8010503b:	c3                   	ret

ffffffff8010503c <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
ffffffff8010503c:	55                   	push   %rbp
ffffffff8010503d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105040:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80105044:	89 7d ec             	mov    %edi,-0x14(%rbp)
  uint sz;
  
  sz = proc->sz;
ffffffff80105047:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010504e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105052:	48 8b 00             	mov    (%rax),%rax
ffffffff80105055:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(n > 0){
ffffffff80105058:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff8010505c:	7e 34                	jle    ffffffff80105092 <growproc+0x56>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
ffffffff8010505e:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80105061:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80105064:	01 c2                	add    %eax,%edx
ffffffff80105066:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010506d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105071:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80105075:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffffffff80105078:	89 ce                	mov    %ecx,%esi
ffffffff8010507a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010507d:	e8 c6 3b 00 00       	call   ffffffff80108c48 <allocuvm>
ffffffff80105082:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80105085:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80105089:	75 44                	jne    ffffffff801050cf <growproc+0x93>
      return -1;
ffffffff8010508b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80105090:	eb 66                	jmp    ffffffff801050f8 <growproc+0xbc>
  } else if(n < 0){
ffffffff80105092:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff80105096:	79 37                	jns    ffffffff801050cf <growproc+0x93>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
ffffffff80105098:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff8010509b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010509e:	01 d0                	add    %edx,%eax
ffffffff801050a0:	89 c2                	mov    %eax,%edx
ffffffff801050a2:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffffffff801050a5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801050ac:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801050b0:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff801050b4:	48 89 ce             	mov    %rcx,%rsi
ffffffff801050b7:	48 89 c7             	mov    %rax,%rdi
ffffffff801050ba:	e8 5d 3c 00 00       	call   ffffffff80108d1c <deallocuvm>
ffffffff801050bf:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff801050c2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801050c6:	75 07                	jne    ffffffff801050cf <growproc+0x93>
      return -1;
ffffffff801050c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801050cd:	eb 29                	jmp    ffffffff801050f8 <growproc+0xbc>
  }
  proc->sz = sz;
ffffffff801050cf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801050d6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801050da:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801050dd:	48 89 10             	mov    %rdx,(%rax)
  switchuvm(proc);
ffffffff801050e0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801050e7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801050eb:	48 89 c7             	mov    %rax,%rdi
ffffffff801050ee:	e8 43 4a 00 00       	call   ffffffff80109b36 <switchuvm>
  return 0;
ffffffff801050f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801050f8:	c9                   	leave
ffffffff801050f9:	c3                   	ret

ffffffff801050fa <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
ffffffff801050fa:	55                   	push   %rbp
ffffffff801050fb:	48 89 e5             	mov    %rsp,%rbp
ffffffff801050fe:	53                   	push   %rbx
ffffffff801050ff:	48 83 ec 28          	sub    $0x28,%rsp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
ffffffff80105103:	e8 d5 fc ff ff       	call   ffffffff80104ddd <allocproc>
ffffffff80105108:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffffffff8010510c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffffffff80105111:	75 0a                	jne    ffffffff8010511d <fork+0x23>
    return -1;
ffffffff80105113:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80105118:	e9 5f 02 00 00       	jmp    ffffffff8010537c <fork+0x282>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
ffffffff8010511d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105124:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105128:	48 8b 00             	mov    (%rax),%rax
ffffffff8010512b:	89 c2                	mov    %eax,%edx
ffffffff8010512d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105134:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105138:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff8010513c:	89 d6                	mov    %edx,%esi
ffffffff8010513e:	48 89 c7             	mov    %rax,%rdi
ffffffff80105141:	e8 ba 3d 00 00       	call   ffffffff80108f00 <copyuvm>
ffffffff80105146:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff8010514a:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffffffff8010514e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105152:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80105156:	48 85 c0             	test   %rax,%rax
ffffffff80105159:	75 31                	jne    ffffffff8010518c <fork+0x92>
    kfree(np->kstack);
ffffffff8010515b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010515f:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80105163:	48 89 c7             	mov    %rax,%rdi
ffffffff80105166:	e8 c4 e0 ff ff       	call   ffffffff8010322f <kfree>
    np->kstack = 0;
ffffffff8010516b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010516f:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffffffff80105176:	00 
    np->state = UNUSED;
ffffffff80105177:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010517b:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return -1;
ffffffff80105182:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80105187:	e9 f0 01 00 00       	jmp    ffffffff8010537c <fork+0x282>
  }
  np->sz = proc->sz;
ffffffff8010518c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105193:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105197:	48 8b 10             	mov    (%rax),%rdx
ffffffff8010519a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010519e:	48 89 10             	mov    %rdx,(%rax)
  np->parent = proc;
ffffffff801051a1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801051a8:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffffffff801051ac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801051b0:	48 89 50 20          	mov    %rdx,0x20(%rax)
  *np->tf = *proc->tf;
ffffffff801051b4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801051bb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801051bf:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffffffff801051c3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801051c7:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff801051cb:	48 8b 0a             	mov    (%rdx),%rcx
ffffffff801051ce:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
ffffffff801051d2:	48 89 08             	mov    %rcx,(%rax)
ffffffff801051d5:	48 89 58 08          	mov    %rbx,0x8(%rax)
ffffffff801051d9:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
ffffffff801051dd:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
ffffffff801051e1:	48 89 48 10          	mov    %rcx,0x10(%rax)
ffffffff801051e5:	48 89 58 18          	mov    %rbx,0x18(%rax)
ffffffff801051e9:	48 8b 4a 20          	mov    0x20(%rdx),%rcx
ffffffff801051ed:	48 8b 5a 28          	mov    0x28(%rdx),%rbx
ffffffff801051f1:	48 89 48 20          	mov    %rcx,0x20(%rax)
ffffffff801051f5:	48 89 58 28          	mov    %rbx,0x28(%rax)
ffffffff801051f9:	48 8b 4a 30          	mov    0x30(%rdx),%rcx
ffffffff801051fd:	48 8b 5a 38          	mov    0x38(%rdx),%rbx
ffffffff80105201:	48 89 48 30          	mov    %rcx,0x30(%rax)
ffffffff80105205:	48 89 58 38          	mov    %rbx,0x38(%rax)
ffffffff80105209:	48 8b 4a 40          	mov    0x40(%rdx),%rcx
ffffffff8010520d:	48 8b 5a 48          	mov    0x48(%rdx),%rbx
ffffffff80105211:	48 89 48 40          	mov    %rcx,0x40(%rax)
ffffffff80105215:	48 89 58 48          	mov    %rbx,0x48(%rax)
ffffffff80105219:	48 8b 4a 50          	mov    0x50(%rdx),%rcx
ffffffff8010521d:	48 8b 5a 58          	mov    0x58(%rdx),%rbx
ffffffff80105221:	48 89 48 50          	mov    %rcx,0x50(%rax)
ffffffff80105225:	48 89 58 58          	mov    %rbx,0x58(%rax)
ffffffff80105229:	48 8b 4a 60          	mov    0x60(%rdx),%rcx
ffffffff8010522d:	48 8b 5a 68          	mov    0x68(%rdx),%rbx
ffffffff80105231:	48 89 48 60          	mov    %rcx,0x60(%rax)
ffffffff80105235:	48 89 58 68          	mov    %rbx,0x68(%rax)
ffffffff80105239:	48 8b 4a 70          	mov    0x70(%rdx),%rcx
ffffffff8010523d:	48 8b 5a 78          	mov    0x78(%rdx),%rbx
ffffffff80105241:	48 89 48 70          	mov    %rcx,0x70(%rax)
ffffffff80105245:	48 89 58 78          	mov    %rbx,0x78(%rax)
ffffffff80105249:	48 8b 8a 80 00 00 00 	mov    0x80(%rdx),%rcx
ffffffff80105250:	48 8b 9a 88 00 00 00 	mov    0x88(%rdx),%rbx
ffffffff80105257:	48 89 88 80 00 00 00 	mov    %rcx,0x80(%rax)
ffffffff8010525e:	48 89 98 88 00 00 00 	mov    %rbx,0x88(%rax)
ffffffff80105265:	48 8b 8a 90 00 00 00 	mov    0x90(%rdx),%rcx
ffffffff8010526c:	48 8b 9a 98 00 00 00 	mov    0x98(%rdx),%rbx
ffffffff80105273:	48 89 88 90 00 00 00 	mov    %rcx,0x90(%rax)
ffffffff8010527a:	48 89 98 98 00 00 00 	mov    %rbx,0x98(%rax)
ffffffff80105281:	48 8b 8a a0 00 00 00 	mov    0xa0(%rdx),%rcx
ffffffff80105288:	48 8b 9a a8 00 00 00 	mov    0xa8(%rdx),%rbx
ffffffff8010528f:	48 89 88 a0 00 00 00 	mov    %rcx,0xa0(%rax)
ffffffff80105296:	48 89 98 a8 00 00 00 	mov    %rbx,0xa8(%rax)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
ffffffff8010529d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801052a1:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff801052a5:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  for(i = 0; i < NOFILE; i++)
ffffffff801052ac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffffffff801052b3:	eb 58                	jmp    ffffffff8010530d <fork+0x213>
    if(proc->ofile[i])
ffffffff801052b5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801052bc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801052c0:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff801052c3:	48 63 d2             	movslq %edx,%rdx
ffffffff801052c6:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801052ca:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff801052cf:	48 85 c0             	test   %rax,%rax
ffffffff801052d2:	74 35                	je     ffffffff80105309 <fork+0x20f>
      np->ofile[i] = filedup(proc->ofile[i]);
ffffffff801052d4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801052db:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801052df:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff801052e2:	48 63 d2             	movslq %edx,%rdx
ffffffff801052e5:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801052e9:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff801052ee:	48 89 c7             	mov    %rax,%rdi
ffffffff801052f1:	e8 05 c2 ff ff       	call   ffffffff801014fb <filedup>
ffffffff801052f6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff801052fa:	8b 4d ec             	mov    -0x14(%rbp),%ecx
ffffffff801052fd:	48 63 c9             	movslq %ecx,%rcx
ffffffff80105300:	48 83 c1 08          	add    $0x8,%rcx
ffffffff80105304:	48 89 44 ca 08       	mov    %rax,0x8(%rdx,%rcx,8)
  for(i = 0; i < NOFILE; i++)
ffffffff80105309:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffffffff8010530d:	83 7d ec 0f          	cmpl   $0xf,-0x14(%rbp)
ffffffff80105311:	7e a2                	jle    ffffffff801052b5 <fork+0x1bb>
  np->cwd = idup(proc->cwd);
ffffffff80105313:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010531a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010531e:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffffffff80105325:	48 89 c7             	mov    %rax,%rdi
ffffffff80105328:	e8 30 cb ff ff       	call   ffffffff80101e5d <idup>
ffffffff8010532d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff80105331:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)
 
  pid = np->pid;
ffffffff80105338:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010533c:	8b 40 1c             	mov    0x1c(%rax),%eax
ffffffff8010533f:	89 45 dc             	mov    %eax,-0x24(%rbp)
  np->state = RUNNABLE;
ffffffff80105342:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105346:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
ffffffff8010534d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105354:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105358:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffffffff8010535f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105363:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffffffff80105369:	ba 10 00 00 00       	mov    $0x10,%edx
ffffffff8010536e:	48 89 ce             	mov    %rcx,%rsi
ffffffff80105371:	48 89 c7             	mov    %rax,%rdi
ffffffff80105374:	e8 75 0e 00 00       	call   ffffffff801061ee <safestrcpy>
  return pid;
ffffffff80105379:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffffffff8010537c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffffffff80105380:	c9                   	leave
ffffffff80105381:	c3                   	ret

ffffffff80105382 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
ffffffff80105382:	55                   	push   %rbp
ffffffff80105383:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105386:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int fd;

  if(proc == initproc)
ffffffff8010538a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105391:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffffffff80105395:	48 8b 05 cc ec 00 00 	mov    0xeccc(%rip),%rax        # ffffffff80114068 <initproc>
ffffffff8010539c:	48 39 c2             	cmp    %rax,%rdx
ffffffff8010539f:	75 0c                	jne    ffffffff801053ad <exit+0x2b>
    panic("init exiting");
ffffffff801053a1:	48 c7 c7 65 9f 10 80 	mov    $0xffffffff80109f65,%rdi
ffffffff801053a8:	e8 82 b5 ff ff       	call   ffffffff8010092f <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
ffffffff801053ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffffffff801053b4:	eb 63                	jmp    ffffffff80105419 <exit+0x97>
    if(proc->ofile[fd]){
ffffffff801053b6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801053bd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801053c1:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff801053c4:	48 63 d2             	movslq %edx,%rdx
ffffffff801053c7:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801053cb:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff801053d0:	48 85 c0             	test   %rax,%rax
ffffffff801053d3:	74 40                	je     ffffffff80105415 <exit+0x93>
      fileclose(proc->ofile[fd]);
ffffffff801053d5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801053dc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801053e0:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff801053e3:	48 63 d2             	movslq %edx,%rdx
ffffffff801053e6:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801053ea:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff801053ef:	48 89 c7             	mov    %rax,%rdi
ffffffff801053f2:	e8 56 c1 ff ff       	call   ffffffff8010154d <fileclose>
      proc->ofile[fd] = 0;
ffffffff801053f7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801053fe:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105402:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80105405:	48 63 d2             	movslq %edx,%rdx
ffffffff80105408:	48 83 c2 08          	add    $0x8,%rdx
ffffffff8010540c:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffffffff80105413:	00 00 
  for(fd = 0; fd < NOFILE; fd++){
ffffffff80105415:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffffffff80105419:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
ffffffff8010541d:	7e 97                	jle    ffffffff801053b6 <exit+0x34>
    }
  }

  iput(proc->cwd);
ffffffff8010541f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105426:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010542a:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffffffff80105431:	48 89 c7             	mov    %rax,%rdi
ffffffff80105434:	e8 42 cc ff ff       	call   ffffffff8010207b <iput>
  proc->cwd = 0;
ffffffff80105439:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105440:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105444:	48 c7 80 c8 00 00 00 	movq   $0x0,0xc8(%rax)
ffffffff8010544b:	00 00 00 00 
  proc->inuse = 0;
ffffffff8010544f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105456:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010545a:	c7 80 e0 00 00 00 00 	movl   $0x0,0xe0(%rax)
ffffffff80105461:	00 00 00 

  acquire(&ptable.lock);
ffffffff80105464:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff8010546b:	e8 73 07 00 00       	call   ffffffff80105be3 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
ffffffff80105470:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105477:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010547b:	48 8b 40 20          	mov    0x20(%rax),%rax
ffffffff8010547f:	48 89 c7             	mov    %rax,%rdi
ffffffff80105482:	e8 9b 04 00 00       	call   ffffffff80105922 <wakeup1>


  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105487:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff8010548e:	80 
ffffffff8010548f:	eb 4a                	jmp    ffffffff801054db <exit+0x159>
    if(p->parent == proc){
ffffffff80105491:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105495:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffffffff80105499:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801054a0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801054a4:	48 39 c2             	cmp    %rax,%rdx
ffffffff801054a7:	75 2a                	jne    ffffffff801054d3 <exit+0x151>
      p->parent = initproc;
ffffffff801054a9:	48 8b 15 b8 eb 00 00 	mov    0xebb8(%rip),%rdx        # ffffffff80114068 <initproc>
ffffffff801054b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801054b4:	48 89 50 20          	mov    %rdx,0x20(%rax)
      if(p->state == ZOMBIE)
ffffffff801054b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801054bc:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff801054bf:	83 f8 05             	cmp    $0x5,%eax
ffffffff801054c2:	75 0f                	jne    ffffffff801054d3 <exit+0x151>
        wakeup1(initproc);
ffffffff801054c4:	48 8b 05 9d eb 00 00 	mov    0xeb9d(%rip),%rax        # ffffffff80114068 <initproc>
ffffffff801054cb:	48 89 c7             	mov    %rax,%rdi
ffffffff801054ce:	e8 4f 04 00 00       	call   ffffffff80105922 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff801054d3:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff801054da:	00 
ffffffff801054db:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff801054e2:	80 
ffffffff801054e3:	72 ac                	jb     ffffffff80105491 <exit+0x10f>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
ffffffff801054e5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801054ec:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801054f0:	c7 40 18 05 00 00 00 	movl   $0x5,0x18(%rax)
   sched();
ffffffff801054f7:	e8 2d 02 00 00       	call   ffffffff80105729 <sched>
  panic("zombie exit");
ffffffff801054fc:	48 c7 c7 72 9f 10 80 	mov    $0xffffffff80109f72,%rdi
ffffffff80105503:	e8 27 b4 ff ff       	call   ffffffff8010092f <panic>

ffffffff80105508 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
ffffffff80105508:	55                   	push   %rbp
ffffffff80105509:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010550c:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
ffffffff80105510:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105517:	e8 c7 06 00 00       	call   ffffffff80105be3 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
ffffffff8010551c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105523:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff8010552a:	80 
ffffffff8010552b:	e9 bb 00 00 00       	jmp    ffffffff801055eb <wait+0xe3>
      if(p->parent != proc)
ffffffff80105530:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105534:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffffffff80105538:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010553f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105543:	48 39 c2             	cmp    %rax,%rdx
ffffffff80105546:	0f 85 96 00 00 00    	jne    ffffffff801055e2 <wait+0xda>
        continue;
      havekids = 1;
ffffffff8010554c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
      if(p->state == ZOMBIE){
ffffffff80105553:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105557:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff8010555a:	83 f8 05             	cmp    $0x5,%eax
ffffffff8010555d:	0f 85 80 00 00 00    	jne    ffffffff801055e3 <wait+0xdb>
        // Found one.
        pid = p->pid;
ffffffff80105563:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105567:	8b 40 1c             	mov    0x1c(%rax),%eax
ffffffff8010556a:	89 45 f0             	mov    %eax,-0x10(%rbp)
        kfree(p->kstack);
ffffffff8010556d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105571:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80105575:	48 89 c7             	mov    %rax,%rdi
ffffffff80105578:	e8 b2 dc ff ff       	call   ffffffff8010322f <kfree>
        p->kstack = 0;
ffffffff8010557d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105581:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffffffff80105588:	00 
        freevm(p->pgdir);
ffffffff80105589:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010558d:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80105591:	48 89 c7             	mov    %rax,%rdi
ffffffff80105594:	e8 66 38 00 00       	call   ffffffff80108dff <freevm>
        p->state = UNUSED;
ffffffff80105599:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010559d:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        p->pid = 0;
ffffffff801055a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801055a8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%rax)
        p->parent = 0;
ffffffff801055af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801055b3:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffffffff801055ba:	00 
        p->name[0] = 0;
ffffffff801055bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801055bf:	c6 80 d0 00 00 00 00 	movb   $0x0,0xd0(%rax)
        p->killed = 0;
ffffffff801055c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801055ca:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%rax)
        release(&ptable.lock);
ffffffff801055d1:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801055d8:	e8 dd 06 00 00       	call   ffffffff80105cba <release>
        return pid;
ffffffff801055dd:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff801055e0:	eb 61                	jmp    ffffffff80105643 <wait+0x13b>
        continue;
ffffffff801055e2:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff801055e3:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff801055ea:	00 
ffffffff801055eb:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff801055f2:	80 
ffffffff801055f3:	0f 82 37 ff ff ff    	jb     ffffffff80105530 <wait+0x28>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
ffffffff801055f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffffffff801055fd:	74 12                	je     ffffffff80105611 <wait+0x109>
ffffffff801055ff:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105606:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010560a:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff8010560d:	85 c0                	test   %eax,%eax
ffffffff8010560f:	74 13                	je     ffffffff80105624 <wait+0x11c>
      release(&ptable.lock);
ffffffff80105611:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105618:	e8 9d 06 00 00       	call   ffffffff80105cba <release>
      return -1;
ffffffff8010561d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80105622:	eb 1f                	jmp    ffffffff80105643 <wait+0x13b>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
ffffffff80105624:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010562b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010562f:	48 c7 c6 00 04 11 80 	mov    $0xffffffff80110400,%rsi
ffffffff80105636:	48 89 c7             	mov    %rax,%rdi
ffffffff80105639:	e8 21 02 00 00       	call   ffffffff8010585f <sleep>
    havekids = 0;
ffffffff8010563e:	e9 d9 fe ff ff       	jmp    ffffffff8010551c <wait+0x14>
  }
}
ffffffff80105643:	c9                   	leave
ffffffff80105644:	c3                   	ret

ffffffff80105645 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
ffffffff80105645:	55                   	push   %rbp
ffffffff80105646:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105649:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p = 0;
ffffffff8010564d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffffffff80105654:	00 

  for(;;){
    // Enable interrupts on this processor.
    sti();
ffffffff80105655:	e8 59 f7 ff ff       	call   ffffffff80104db3 <sti>

    // no runnable processes? (did we hit the end of the table last time?)
    // if so, wait for irq before trying again.
    if (p == &ptable.proc[NPROC])
ffffffff8010565a:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff80105661:	80 
ffffffff80105662:	75 05                	jne    ffffffff80105669 <scheduler+0x24>
      hlt();
ffffffff80105664:	e8 52 f7 ff ff       	call   ffffffff80104dbb <hlt>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
ffffffff80105669:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105670:	e8 6e 05 00 00       	call   ffffffff80105be3 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105675:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff8010567c:	80 
ffffffff8010567d:	e9 88 00 00 00       	jmp    ffffffff8010570a <scheduler+0xc5>
      if(p->state != RUNNABLE)
ffffffff80105682:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105686:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105689:	83 f8 03             	cmp    $0x3,%eax
ffffffff8010568c:	75 73                	jne    ffffffff80105701 <scheduler+0xbc>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
ffffffff8010568e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105695:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80105699:	64 48 89 10          	mov    %rdx,%fs:(%rax)
      switchuvm(p);
ffffffff8010569d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801056a1:	48 89 c7             	mov    %rax,%rdi
ffffffff801056a4:	e8 8d 44 00 00       	call   ffffffff80109b36 <switchuvm>
      p->state = RUNNING;
ffffffff801056a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801056ad:	c7 40 18 04 00 00 00 	movl   $0x4,0x18(%rax)
      p->inuse = 1;
ffffffff801056b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801056b8:	c7 80 e0 00 00 00 01 	movl   $0x1,0xe0(%rax)
ffffffff801056bf:	00 00 00 

      swtch(&cpu->scheduler, proc->context);
ffffffff801056c2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801056c9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801056cd:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff801056d1:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffffffff801056d8:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffffffff801056dc:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801056e0:	48 89 c6             	mov    %rax,%rsi
ffffffff801056e3:	48 89 d7             	mov    %rdx,%rdi
ffffffff801056e6:	e8 98 0b 00 00       	call   ffffffff80106283 <swtch>
    
      switchkvm();
ffffffff801056eb:	e8 28 44 00 00       	call   ffffffff80109b18 <switchkvm>
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
ffffffff801056f0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801056f7:	64 48 c7 00 00 00 00 	movq   $0x0,%fs:(%rax)
ffffffff801056fe:	00 
ffffffff801056ff:	eb 01                	jmp    ffffffff80105702 <scheduler+0xbd>
        continue;
ffffffff80105701:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105702:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff80105709:	00 
ffffffff8010570a:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff80105711:	80 
ffffffff80105712:	0f 82 6a ff ff ff    	jb     ffffffff80105682 <scheduler+0x3d>
    }
    release(&ptable.lock);
ffffffff80105718:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff8010571f:	e8 96 05 00 00       	call   ffffffff80105cba <release>
    sti();
ffffffff80105724:	e9 2c ff ff ff       	jmp    ffffffff80105655 <scheduler+0x10>

ffffffff80105729 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
ffffffff80105729:	55                   	push   %rbp
ffffffff8010572a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010572d:	48 83 ec 10          	sub    $0x10,%rsp
  int intena;

  if(!holding(&ptable.lock))
ffffffff80105731:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105738:	e8 9d 06 00 00       	call   ffffffff80105dda <holding>
ffffffff8010573d:	85 c0                	test   %eax,%eax
ffffffff8010573f:	75 0c                	jne    ffffffff8010574d <sched+0x24>
    panic("sched ptable.lock");
ffffffff80105741:	48 c7 c7 7e 9f 10 80 	mov    $0xffffffff80109f7e,%rdi
ffffffff80105748:	e8 e2 b1 ff ff       	call   ffffffff8010092f <panic>
  if(cpu->ncli != 1)
ffffffff8010574d:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105754:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105758:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
ffffffff8010575e:	83 f8 01             	cmp    $0x1,%eax
ffffffff80105761:	74 0c                	je     ffffffff8010576f <sched+0x46>
    panic("sched locks");
ffffffff80105763:	48 c7 c7 90 9f 10 80 	mov    $0xffffffff80109f90,%rdi
ffffffff8010576a:	e8 c0 b1 ff ff       	call   ffffffff8010092f <panic>
  if(proc->state == RUNNING)
ffffffff8010576f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105776:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010577a:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff8010577d:	83 f8 04             	cmp    $0x4,%eax
ffffffff80105780:	75 0c                	jne    ffffffff8010578e <sched+0x65>
    panic("sched running");
ffffffff80105782:	48 c7 c7 9c 9f 10 80 	mov    $0xffffffff80109f9c,%rdi
ffffffff80105789:	e8 a1 b1 ff ff       	call   ffffffff8010092f <panic>
  if(readeflags()&FL_IF)
ffffffff8010578e:	e8 0c f6 ff ff       	call   ffffffff80104d9f <readeflags>
ffffffff80105793:	25 00 02 00 00       	and    $0x200,%eax
ffffffff80105798:	48 85 c0             	test   %rax,%rax
ffffffff8010579b:	74 0c                	je     ffffffff801057a9 <sched+0x80>
    panic("sched interruptible");
ffffffff8010579d:	48 c7 c7 aa 9f 10 80 	mov    $0xffffffff80109faa,%rdi
ffffffff801057a4:	e8 86 b1 ff ff       	call   ffffffff8010092f <panic>
  intena = cpu->intena;
ffffffff801057a9:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff801057b0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801057b4:	8b 80 e0 00 00 00    	mov    0xe0(%rax),%eax
ffffffff801057ba:	89 45 fc             	mov    %eax,-0x4(%rbp)
  swtch(&proc->context, cpu->scheduler);
ffffffff801057bd:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff801057c4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801057c8:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff801057cc:	48 c7 c2 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rdx
ffffffff801057d3:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffffffff801057d7:	48 83 c2 30          	add    $0x30,%rdx
ffffffff801057db:	48 89 c6             	mov    %rax,%rsi
ffffffff801057de:	48 89 d7             	mov    %rdx,%rdi
ffffffff801057e1:	e8 9d 0a 00 00       	call   ffffffff80106283 <swtch>
  cpu->intena = intena;
ffffffff801057e6:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff801057ed:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801057f1:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801057f4:	89 90 e0 00 00 00    	mov    %edx,0xe0(%rax)
}
ffffffff801057fa:	90                   	nop
ffffffff801057fb:	c9                   	leave
ffffffff801057fc:	c3                   	ret

ffffffff801057fd <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
ffffffff801057fd:	55                   	push   %rbp
ffffffff801057fe:	48 89 e5             	mov    %rsp,%rbp
  acquire(&ptable.lock);  //DOC: yieldlock
ffffffff80105801:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105808:	e8 d6 03 00 00       	call   ffffffff80105be3 <acquire>
  proc->state = RUNNABLE;
ffffffff8010580d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105814:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105818:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  sched();
ffffffff8010581f:	e8 05 ff ff ff       	call   ffffffff80105729 <sched>
  release(&ptable.lock);
ffffffff80105824:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff8010582b:	e8 8a 04 00 00       	call   ffffffff80105cba <release>
}
ffffffff80105830:	90                   	nop
ffffffff80105831:	5d                   	pop    %rbp
ffffffff80105832:	c3                   	ret

ffffffff80105833 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
ffffffff80105833:	55                   	push   %rbp
ffffffff80105834:	48 89 e5             	mov    %rsp,%rbp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
ffffffff80105837:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff8010583e:	e8 77 04 00 00       	call   ffffffff80105cba <release>

  if (first) {
ffffffff80105843:	8b 05 1b 5d 00 00    	mov    0x5d1b(%rip),%eax        # ffffffff8010b564 <first.1>
ffffffff80105849:	85 c0                	test   %eax,%eax
ffffffff8010584b:	74 0f                	je     ffffffff8010585c <forkret+0x29>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
ffffffff8010584d:	c7 05 0d 5d 00 00 00 	movl   $0x0,0x5d0d(%rip)        # ffffffff8010b564 <first.1>
ffffffff80105854:	00 00 00 
    initlog();
ffffffff80105857:	e8 b0 df ff ff       	call   ffffffff8010380c <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
ffffffff8010585c:	90                   	nop
ffffffff8010585d:	5d                   	pop    %rbp
ffffffff8010585e:	c3                   	ret

ffffffff8010585f <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
ffffffff8010585f:	55                   	push   %rbp
ffffffff80105860:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105863:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80105867:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010586b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(proc == 0)
ffffffff8010586f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80105876:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010587a:	48 85 c0             	test   %rax,%rax
ffffffff8010587d:	75 0c                	jne    ffffffff8010588b <sleep+0x2c>
    panic("sleep");
ffffffff8010587f:	48 c7 c7 be 9f 10 80 	mov    $0xffffffff80109fbe,%rdi
ffffffff80105886:	e8 a4 b0 ff ff       	call   ffffffff8010092f <panic>

  if(lk == 0)
ffffffff8010588b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80105890:	75 0c                	jne    ffffffff8010589e <sleep+0x3f>
    panic("sleep without lk");
ffffffff80105892:	48 c7 c7 c4 9f 10 80 	mov    $0xffffffff80109fc4,%rdi
ffffffff80105899:	e8 91 b0 ff ff       	call   ffffffff8010092f <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
ffffffff8010589e:	48 81 7d f0 00 04 11 	cmpq   $0xffffffff80110400,-0x10(%rbp)
ffffffff801058a5:	80 
ffffffff801058a6:	74 18                	je     ffffffff801058c0 <sleep+0x61>
    acquire(&ptable.lock);  //DOC: sleeplock1
ffffffff801058a8:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801058af:	e8 2f 03 00 00       	call   ffffffff80105be3 <acquire>
    release(lk);
ffffffff801058b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801058b8:	48 89 c7             	mov    %rax,%rdi
ffffffff801058bb:	e8 fa 03 00 00       	call   ffffffff80105cba <release>
  }

  // Go to sleep.
  proc->chan = chan;
ffffffff801058c0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801058c7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801058cb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801058cf:	48 89 50 38          	mov    %rdx,0x38(%rax)
  proc->state = SLEEPING;
ffffffff801058d3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801058da:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801058de:	c7 40 18 02 00 00 00 	movl   $0x2,0x18(%rax)
  sched();
ffffffff801058e5:	e8 3f fe ff ff       	call   ffffffff80105729 <sched>

  // Tidy up.
  proc->chan = 0;
ffffffff801058ea:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801058f1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801058f5:	48 c7 40 38 00 00 00 	movq   $0x0,0x38(%rax)
ffffffff801058fc:	00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
ffffffff801058fd:	48 81 7d f0 00 04 11 	cmpq   $0xffffffff80110400,-0x10(%rbp)
ffffffff80105904:	80 
ffffffff80105905:	74 18                	je     ffffffff8010591f <sleep+0xc0>
    release(&ptable.lock);
ffffffff80105907:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff8010590e:	e8 a7 03 00 00       	call   ffffffff80105cba <release>
    acquire(lk);
ffffffff80105913:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105917:	48 89 c7             	mov    %rax,%rdi
ffffffff8010591a:	e8 c4 02 00 00       	call   ffffffff80105be3 <acquire>
  }
}
ffffffff8010591f:	90                   	nop
ffffffff80105920:	c9                   	leave
ffffffff80105921:	c3                   	ret

ffffffff80105922 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
ffffffff80105922:	55                   	push   %rbp
ffffffff80105923:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105926:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff8010592a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffffffff8010592e:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff80105935:	80 
ffffffff80105936:	eb 2d                	jmp    ffffffff80105965 <wakeup1+0x43>
    if(p->state == SLEEPING && p->chan == chan)
ffffffff80105938:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010593c:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff8010593f:	83 f8 02             	cmp    $0x2,%eax
ffffffff80105942:	75 19                	jne    ffffffff8010595d <wakeup1+0x3b>
ffffffff80105944:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105948:	48 8b 40 38          	mov    0x38(%rax),%rax
ffffffff8010594c:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffffffff80105950:	75 0b                	jne    ffffffff8010595d <wakeup1+0x3b>
      p->state = RUNNABLE;
ffffffff80105952:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105956:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffffffff8010595d:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff80105964:	00 
ffffffff80105965:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff8010596c:	80 
ffffffff8010596d:	72 c9                	jb     ffffffff80105938 <wakeup1+0x16>
}
ffffffff8010596f:	90                   	nop
ffffffff80105970:	90                   	nop
ffffffff80105971:	c9                   	leave
ffffffff80105972:	c3                   	ret

ffffffff80105973 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
ffffffff80105973:	55                   	push   %rbp
ffffffff80105974:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105977:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010597b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ptable.lock);
ffffffff8010597f:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105986:	e8 58 02 00 00       	call   ffffffff80105be3 <acquire>
  wakeup1(chan);
ffffffff8010598b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010598f:	48 89 c7             	mov    %rax,%rdi
ffffffff80105992:	e8 8b ff ff ff       	call   ffffffff80105922 <wakeup1>
  release(&ptable.lock);
ffffffff80105997:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff8010599e:	e8 17 03 00 00       	call   ffffffff80105cba <release>
}
ffffffff801059a3:	90                   	nop
ffffffff801059a4:	c9                   	leave
ffffffff801059a5:	c3                   	ret

ffffffff801059a6 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
ffffffff801059a6:	55                   	push   %rbp
ffffffff801059a7:	48 89 e5             	mov    %rsp,%rbp
ffffffff801059aa:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801059ae:	89 7d ec             	mov    %edi,-0x14(%rbp)
  struct proc *p;

  acquire(&ptable.lock);
ffffffff801059b1:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801059b8:	e8 26 02 00 00       	call   ffffffff80105be3 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff801059bd:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff801059c4:	80 
ffffffff801059c5:	eb 49                	jmp    ffffffff80105a10 <kill+0x6a>
    if(p->pid == pid){
ffffffff801059c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801059cb:	8b 40 1c             	mov    0x1c(%rax),%eax
ffffffff801059ce:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffffffff801059d1:	75 35                	jne    ffffffff80105a08 <kill+0x62>
      p->killed = 1;
ffffffff801059d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801059d7:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
ffffffff801059de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801059e2:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff801059e5:	83 f8 02             	cmp    $0x2,%eax
ffffffff801059e8:	75 0b                	jne    ffffffff801059f5 <kill+0x4f>
        p->state = RUNNABLE;
ffffffff801059ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801059ee:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
      release(&ptable.lock);
ffffffff801059f5:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801059fc:	e8 b9 02 00 00       	call   ffffffff80105cba <release>
      return 0;
ffffffff80105a01:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105a06:	eb 23                	jmp    ffffffff80105a2b <kill+0x85>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105a08:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff80105a0f:	00 
ffffffff80105a10:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff80105a17:	80 
ffffffff80105a18:	72 ad                	jb     ffffffff801059c7 <kill+0x21>
    }
  }
  release(&ptable.lock);
ffffffff80105a1a:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80105a21:	e8 94 02 00 00       	call   ffffffff80105cba <release>
  return -1;
ffffffff80105a26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80105a2b:	c9                   	leave
ffffffff80105a2c:	c3                   	ret

ffffffff80105a2d <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
ffffffff80105a2d:	55                   	push   %rbp
ffffffff80105a2e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105a31:	48 83 ec 70          	sub    $0x70,%rsp
  int i;
  struct proc *p;
  char *state;
  uintp pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105a35:	48 c7 45 f0 68 04 11 	movq   $0xffffffff80110468,-0x10(%rbp)
ffffffff80105a3c:	80 
ffffffff80105a3d:	e9 ff 00 00 00       	jmp    ffffffff80105b41 <procdump+0x114>
    if(p->state == UNUSED)
ffffffff80105a42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105a46:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105a49:	85 c0                	test   %eax,%eax
ffffffff80105a4b:	0f 84 e7 00 00 00    	je     ffffffff80105b38 <procdump+0x10b>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
ffffffff80105a51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105a55:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105a58:	83 f8 05             	cmp    $0x5,%eax
ffffffff80105a5b:	77 2d                	ja     ffffffff80105a8a <procdump+0x5d>
ffffffff80105a5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105a61:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105a64:	89 c0                	mov    %eax,%eax
ffffffff80105a66:	48 8b 04 c5 80 b5 10 	mov    -0x7fef4a80(,%rax,8),%rax
ffffffff80105a6d:	80 
ffffffff80105a6e:	48 85 c0             	test   %rax,%rax
ffffffff80105a71:	74 17                	je     ffffffff80105a8a <procdump+0x5d>
      state = states[p->state];
ffffffff80105a73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105a77:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105a7a:	89 c0                	mov    %eax,%eax
ffffffff80105a7c:	48 8b 04 c5 80 b5 10 	mov    -0x7fef4a80(,%rax,8),%rax
ffffffff80105a83:	80 
ffffffff80105a84:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff80105a88:	eb 08                	jmp    ffffffff80105a92 <procdump+0x65>
    else
      state = "???";
ffffffff80105a8a:	48 c7 45 e8 d5 9f 10 	movq   $0xffffffff80109fd5,-0x18(%rbp)
ffffffff80105a91:	80 
    cprintf("%d %s %s", p->pid, state, p->name);
ffffffff80105a92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105a96:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffffffff80105a9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105aa1:	8b 40 1c             	mov    0x1c(%rax),%eax
ffffffff80105aa4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80105aa8:	89 c6                	mov    %eax,%esi
ffffffff80105aaa:	48 c7 c7 d9 9f 10 80 	mov    $0xffffffff80109fd9,%rdi
ffffffff80105ab1:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105ab6:	e8 e9 aa ff ff       	call   ffffffff801005a4 <cprintf>
    if(p->state == SLEEPING){
ffffffff80105abb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105abf:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80105ac2:	83 f8 02             	cmp    $0x2,%eax
ffffffff80105ac5:	75 5e                	jne    ffffffff80105b25 <procdump+0xf8>
      getstackpcs((uintp*)p->context->ebp, pc);
ffffffff80105ac7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80105acb:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff80105acf:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff80105ad3:	48 89 c2             	mov    %rax,%rdx
ffffffff80105ad6:	48 8d 45 90          	lea    -0x70(%rbp),%rax
ffffffff80105ada:	48 89 c6             	mov    %rax,%rsi
ffffffff80105add:	48 89 d7             	mov    %rdx,%rdi
ffffffff80105ae0:	e8 5b 02 00 00       	call   ffffffff80105d40 <getstackpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
ffffffff80105ae5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80105aec:	eb 22                	jmp    ffffffff80105b10 <procdump+0xe3>
        cprintf(" %p", pc[i]);
ffffffff80105aee:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80105af1:	48 98                	cltq
ffffffff80105af3:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffffffff80105af8:	48 89 c6             	mov    %rax,%rsi
ffffffff80105afb:	48 c7 c7 e2 9f 10 80 	mov    $0xffffffff80109fe2,%rdi
ffffffff80105b02:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105b07:	e8 98 aa ff ff       	call   ffffffff801005a4 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
ffffffff80105b0c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80105b10:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffffffff80105b14:	7f 0f                	jg     ffffffff80105b25 <procdump+0xf8>
ffffffff80105b16:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80105b19:	48 98                	cltq
ffffffff80105b1b:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffffffff80105b20:	48 85 c0             	test   %rax,%rax
ffffffff80105b23:	75 c9                	jne    ffffffff80105aee <procdump+0xc1>
    }
    cprintf("\n");
ffffffff80105b25:	48 c7 c7 e6 9f 10 80 	mov    $0xffffffff80109fe6,%rdi
ffffffff80105b2c:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105b31:	e8 6e aa ff ff       	call   ffffffff801005a4 <cprintf>
ffffffff80105b36:	eb 01                	jmp    ffffffff80105b39 <procdump+0x10c>
      continue;
ffffffff80105b38:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff80105b39:	48 81 45 f0 f0 00 00 	addq   $0xf0,-0x10(%rbp)
ffffffff80105b40:	00 
ffffffff80105b41:	48 81 7d f0 68 40 11 	cmpq   $0xffffffff80114068,-0x10(%rbp)
ffffffff80105b48:	80 
ffffffff80105b49:	0f 82 f3 fe ff ff    	jb     ffffffff80105a42 <procdump+0x15>
  }

    cprintf("\n\n");
ffffffff80105b4f:	48 c7 c7 e8 9f 10 80 	mov    $0xffffffff80109fe8,%rdi
ffffffff80105b56:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105b5b:	e8 44 aa ff ff       	call   ffffffff801005a4 <cprintf>
}
ffffffff80105b60:	90                   	nop
ffffffff80105b61:	c9                   	leave
ffffffff80105b62:	c3                   	ret

ffffffff80105b63 <readeflags>:
{
ffffffff80105b63:	55                   	push   %rbp
ffffffff80105b64:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105b67:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffffffff80105b6b:	9c                   	pushf
ffffffff80105b6c:	58                   	pop    %rax
ffffffff80105b6d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffffffff80105b71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80105b75:	c9                   	leave
ffffffff80105b76:	c3                   	ret

ffffffff80105b77 <cli>:
{
ffffffff80105b77:	55                   	push   %rbp
ffffffff80105b78:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("cli");
ffffffff80105b7b:	fa                   	cli
}
ffffffff80105b7c:	90                   	nop
ffffffff80105b7d:	5d                   	pop    %rbp
ffffffff80105b7e:	c3                   	ret

ffffffff80105b7f <sti>:
{
ffffffff80105b7f:	55                   	push   %rbp
ffffffff80105b80:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffffffff80105b83:	fb                   	sti
}
ffffffff80105b84:	90                   	nop
ffffffff80105b85:	5d                   	pop    %rbp
ffffffff80105b86:	c3                   	ret

ffffffff80105b87 <xchg>:
{
ffffffff80105b87:	55                   	push   %rbp
ffffffff80105b88:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105b8b:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80105b8f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80105b93:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  asm volatile("lock; xchgl %0, %1" :
ffffffff80105b97:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80105b9b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105b9f:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffffffff80105ba3:	f0 87 02             	lock xchg %eax,(%rdx)
ffffffff80105ba6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  return result;
ffffffff80105ba9:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff80105bac:	c9                   	leave
ffffffff80105bad:	c3                   	ret

ffffffff80105bae <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
ffffffff80105bae:	55                   	push   %rbp
ffffffff80105baf:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105bb2:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80105bb6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80105bba:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  lk->name = name;
ffffffff80105bbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105bc2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80105bc6:	48 89 50 08          	mov    %rdx,0x8(%rax)
  lk->locked = 0;
ffffffff80105bca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105bce:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->cpu = 0;
ffffffff80105bd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105bd8:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffffffff80105bdf:	00 
}
ffffffff80105be0:	90                   	nop
ffffffff80105be1:	c9                   	leave
ffffffff80105be2:	c3                   	ret

ffffffff80105be3 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
ffffffff80105be3:	55                   	push   %rbp
ffffffff80105be4:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105be7:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80105beb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  pushcli(); // disable interrupts to avoid deadlock.
ffffffff80105bef:	e8 22 02 00 00       	call   ffffffff80105e16 <pushcli>
  if(holding(lk)) {
ffffffff80105bf4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105bf8:	48 89 c7             	mov    %rax,%rdi
ffffffff80105bfb:	e8 da 01 00 00       	call   ffffffff80105dda <holding>
ffffffff80105c00:	85 c0                	test   %eax,%eax
ffffffff80105c02:	74 73                	je     ffffffff80105c77 <acquire+0x94>
    int i;
    cprintf("lock '%s':\n", lk->name);
ffffffff80105c04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105c08:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80105c0c:	48 89 c6             	mov    %rax,%rsi
ffffffff80105c0f:	48 c7 c7 15 a0 10 80 	mov    $0xffffffff8010a015,%rdi
ffffffff80105c16:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105c1b:	e8 84 a9 ff ff       	call   ffffffff801005a4 <cprintf>
    for (i = 0; i < 10; i++)
ffffffff80105c20:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80105c27:	eb 2b                	jmp    ffffffff80105c54 <acquire+0x71>
      cprintf(" %p", lk->pcs[i]);
ffffffff80105c29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105c2d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80105c30:	48 63 d2             	movslq %edx,%rdx
ffffffff80105c33:	48 83 c2 02          	add    $0x2,%rdx
ffffffff80105c37:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff80105c3c:	48 89 c6             	mov    %rax,%rsi
ffffffff80105c3f:	48 c7 c7 21 a0 10 80 	mov    $0xffffffff8010a021,%rdi
ffffffff80105c46:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105c4b:	e8 54 a9 ff ff       	call   ffffffff801005a4 <cprintf>
    for (i = 0; i < 10; i++)
ffffffff80105c50:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80105c54:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffffffff80105c58:	7e cf                	jle    ffffffff80105c29 <acquire+0x46>
    cprintf("\n");
ffffffff80105c5a:	48 c7 c7 25 a0 10 80 	mov    $0xffffffff8010a025,%rdi
ffffffff80105c61:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80105c66:	e8 39 a9 ff ff       	call   ffffffff801005a4 <cprintf>
    panic("acquire");
ffffffff80105c6b:	48 c7 c7 27 a0 10 80 	mov    $0xffffffff8010a027,%rdi
ffffffff80105c72:	e8 b8 ac ff ff       	call   ffffffff8010092f <panic>
  }

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
ffffffff80105c77:	90                   	nop
ffffffff80105c78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105c7c:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80105c81:	48 89 c7             	mov    %rax,%rdi
ffffffff80105c84:	e8 fe fe ff ff       	call   ffffffff80105b87 <xchg>
ffffffff80105c89:	85 c0                	test   %eax,%eax
ffffffff80105c8b:	75 eb                	jne    ffffffff80105c78 <acquire+0x95>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
ffffffff80105c8d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105c91:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffffffff80105c98:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffffffff80105c9c:	48 89 50 10          	mov    %rdx,0x10(%rax)
  getcallerpcs(&lk, lk->pcs);
ffffffff80105ca0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105ca4:	48 8d 50 18          	lea    0x18(%rax),%rdx
ffffffff80105ca8:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff80105cac:	48 89 d6             	mov    %rdx,%rsi
ffffffff80105caf:	48 89 c7             	mov    %rax,%rdi
ffffffff80105cb2:	e8 5c 00 00 00       	call   ffffffff80105d13 <getcallerpcs>
}
ffffffff80105cb7:	90                   	nop
ffffffff80105cb8:	c9                   	leave
ffffffff80105cb9:	c3                   	ret

ffffffff80105cba <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
ffffffff80105cba:	55                   	push   %rbp
ffffffff80105cbb:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105cbe:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80105cc2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holding(lk))
ffffffff80105cc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105cca:	48 89 c7             	mov    %rax,%rdi
ffffffff80105ccd:	e8 08 01 00 00       	call   ffffffff80105dda <holding>
ffffffff80105cd2:	85 c0                	test   %eax,%eax
ffffffff80105cd4:	75 0c                	jne    ffffffff80105ce2 <release+0x28>
    panic("release");
ffffffff80105cd6:	48 c7 c7 2f a0 10 80 	mov    $0xffffffff8010a02f,%rdi
ffffffff80105cdd:	e8 4d ac ff ff       	call   ffffffff8010092f <panic>

  lk->pcs[0] = 0;
ffffffff80105ce2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105ce6:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffffffff80105ced:	00 
  lk->cpu = 0;
ffffffff80105cee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105cf2:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffffffff80105cf9:	00 
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
ffffffff80105cfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105cfe:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80105d03:	48 89 c7             	mov    %rax,%rdi
ffffffff80105d06:	e8 7c fe ff ff       	call   ffffffff80105b87 <xchg>

  popcli();
ffffffff80105d0b:	e8 56 01 00 00       	call   ffffffff80105e66 <popcli>
}
ffffffff80105d10:	90                   	nop
ffffffff80105d11:	c9                   	leave
ffffffff80105d12:	c3                   	ret

ffffffff80105d13 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uintp pcs[])
{
ffffffff80105d13:	55                   	push   %rbp
ffffffff80105d14:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105d17:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80105d1b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80105d1f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uintp *ebp;
#if X64
  asm volatile("mov %%rbp, %0" : "=r" (ebp));  
ffffffff80105d23:	48 89 e8             	mov    %rbp,%rax
ffffffff80105d26:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
#else
  ebp = (uintp*)v - 2;
#endif
  getstackpcs(ebp, pcs);
ffffffff80105d2a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff80105d2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105d32:	48 89 d6             	mov    %rdx,%rsi
ffffffff80105d35:	48 89 c7             	mov    %rax,%rdi
ffffffff80105d38:	e8 03 00 00 00       	call   ffffffff80105d40 <getstackpcs>
}
ffffffff80105d3d:	90                   	nop
ffffffff80105d3e:	c9                   	leave
ffffffff80105d3f:	c3                   	ret

ffffffff80105d40 <getstackpcs>:

void
getstackpcs(uintp *ebp, uintp pcs[])
{
ffffffff80105d40:	55                   	push   %rbp
ffffffff80105d41:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105d44:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80105d48:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80105d4c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  
  for(i = 0; i < 10; i++){
ffffffff80105d50:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80105d57:	eb 50                	jmp    ffffffff80105da9 <getstackpcs+0x69>
    if(ebp == 0 || ebp < (uintp*)KERNBASE || ebp == (uintp*)0xffffffff)
ffffffff80105d59:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80105d5e:	74 70                	je     ffffffff80105dd0 <getstackpcs+0x90>
ffffffff80105d60:	48 b8 ff ff ff 7f ff 	movabs $0xffffffff7fffffff,%rax
ffffffff80105d67:	ff ff ff 
ffffffff80105d6a:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffffffff80105d6e:	73 60                	jae    ffffffff80105dd0 <getstackpcs+0x90>
ffffffff80105d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80105d75:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffffffff80105d79:	74 55                	je     ffffffff80105dd0 <getstackpcs+0x90>
      break;
    pcs[i] = ebp[1];     // saved %eip
ffffffff80105d7b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80105d7e:	48 98                	cltq
ffffffff80105d80:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80105d87:	00 
ffffffff80105d88:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105d8c:	48 01 c2             	add    %rax,%rdx
ffffffff80105d8f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105d93:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80105d97:	48 89 02             	mov    %rax,(%rdx)
    ebp = (uintp*)ebp[0]; // saved %ebp
ffffffff80105d9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105d9e:	48 8b 00             	mov    (%rax),%rax
ffffffff80105da1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(i = 0; i < 10; i++){
ffffffff80105da5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80105da9:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffffffff80105dad:	7e aa                	jle    ffffffff80105d59 <getstackpcs+0x19>
  }
  for(; i < 10; i++)
ffffffff80105daf:	eb 1f                	jmp    ffffffff80105dd0 <getstackpcs+0x90>
    pcs[i] = 0;
ffffffff80105db1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80105db4:	48 98                	cltq
ffffffff80105db6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80105dbd:	00 
ffffffff80105dbe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105dc2:	48 01 d0             	add    %rdx,%rax
ffffffff80105dc5:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; i < 10; i++)
ffffffff80105dcc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80105dd0:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffffffff80105dd4:	7e db                	jle    ffffffff80105db1 <getstackpcs+0x71>
}
ffffffff80105dd6:	90                   	nop
ffffffff80105dd7:	90                   	nop
ffffffff80105dd8:	c9                   	leave
ffffffff80105dd9:	c3                   	ret

ffffffff80105dda <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
ffffffff80105dda:	55                   	push   %rbp
ffffffff80105ddb:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105dde:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80105de2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return lock->locked && lock->cpu == cpu;
ffffffff80105de6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105dea:	8b 00                	mov    (%rax),%eax
ffffffff80105dec:	85 c0                	test   %eax,%eax
ffffffff80105dee:	74 1f                	je     ffffffff80105e0f <holding+0x35>
ffffffff80105df0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105df4:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffffffff80105df8:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105dff:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105e03:	48 39 c2             	cmp    %rax,%rdx
ffffffff80105e06:	75 07                	jne    ffffffff80105e0f <holding+0x35>
ffffffff80105e08:	b8 01 00 00 00       	mov    $0x1,%eax
ffffffff80105e0d:	eb 05                	jmp    ffffffff80105e14 <holding+0x3a>
ffffffff80105e0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80105e14:	c9                   	leave
ffffffff80105e15:	c3                   	ret

ffffffff80105e16 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
ffffffff80105e16:	55                   	push   %rbp
ffffffff80105e17:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105e1a:	48 83 ec 10          	sub    $0x10,%rsp
  int eflags;
  
  eflags = readeflags();
ffffffff80105e1e:	e8 40 fd ff ff       	call   ffffffff80105b63 <readeflags>
ffffffff80105e23:	89 45 fc             	mov    %eax,-0x4(%rbp)
  cli();
ffffffff80105e26:	e8 4c fd ff ff       	call   ffffffff80105b77 <cli>
  if(cpu->ncli++ == 0)
ffffffff80105e2b:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105e32:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffffffff80105e36:	8b 82 dc 00 00 00    	mov    0xdc(%rdx),%eax
ffffffff80105e3c:	8d 48 01             	lea    0x1(%rax),%ecx
ffffffff80105e3f:	89 8a dc 00 00 00    	mov    %ecx,0xdc(%rdx)
ffffffff80105e45:	85 c0                	test   %eax,%eax
ffffffff80105e47:	75 1a                	jne    ffffffff80105e63 <pushcli+0x4d>
    cpu->intena = eflags & FL_IF;
ffffffff80105e49:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105e50:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105e54:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80105e57:	81 e2 00 02 00 00    	and    $0x200,%edx
ffffffff80105e5d:	89 90 e0 00 00 00    	mov    %edx,0xe0(%rax)
}
ffffffff80105e63:	90                   	nop
ffffffff80105e64:	c9                   	leave
ffffffff80105e65:	c3                   	ret

ffffffff80105e66 <popcli>:

void
popcli(void)
{
ffffffff80105e66:	55                   	push   %rbp
ffffffff80105e67:	48 89 e5             	mov    %rsp,%rbp
  if(readeflags()&FL_IF)
ffffffff80105e6a:	e8 f4 fc ff ff       	call   ffffffff80105b63 <readeflags>
ffffffff80105e6f:	25 00 02 00 00       	and    $0x200,%eax
ffffffff80105e74:	48 85 c0             	test   %rax,%rax
ffffffff80105e77:	74 0c                	je     ffffffff80105e85 <popcli+0x1f>
    panic("popcli - interruptible");
ffffffff80105e79:	48 c7 c7 37 a0 10 80 	mov    $0xffffffff8010a037,%rdi
ffffffff80105e80:	e8 aa aa ff ff       	call   ffffffff8010092f <panic>
  if(--cpu->ncli < 0)
ffffffff80105e85:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105e8c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105e90:	8b 90 dc 00 00 00    	mov    0xdc(%rax),%edx
ffffffff80105e96:	83 ea 01             	sub    $0x1,%edx
ffffffff80105e99:	89 90 dc 00 00 00    	mov    %edx,0xdc(%rax)
ffffffff80105e9f:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
ffffffff80105ea5:	85 c0                	test   %eax,%eax
ffffffff80105ea7:	79 0c                	jns    ffffffff80105eb5 <popcli+0x4f>
    panic("popcli");
ffffffff80105ea9:	48 c7 c7 4e a0 10 80 	mov    $0xffffffff8010a04e,%rdi
ffffffff80105eb0:	e8 7a aa ff ff       	call   ffffffff8010092f <panic>
  if(cpu->ncli == 0 && cpu->intena)
ffffffff80105eb5:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105ebc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105ec0:	8b 80 dc 00 00 00    	mov    0xdc(%rax),%eax
ffffffff80105ec6:	85 c0                	test   %eax,%eax
ffffffff80105ec8:	75 1a                	jne    ffffffff80105ee4 <popcli+0x7e>
ffffffff80105eca:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80105ed1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80105ed5:	8b 80 e0 00 00 00    	mov    0xe0(%rax),%eax
ffffffff80105edb:	85 c0                	test   %eax,%eax
ffffffff80105edd:	74 05                	je     ffffffff80105ee4 <popcli+0x7e>
    sti();
ffffffff80105edf:	e8 9b fc ff ff       	call   ffffffff80105b7f <sti>
}
ffffffff80105ee4:	90                   	nop
ffffffff80105ee5:	5d                   	pop    %rbp
ffffffff80105ee6:	c3                   	ret

ffffffff80105ee7 <stosb>:
{
ffffffff80105ee7:	55                   	push   %rbp
ffffffff80105ee8:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105eeb:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80105eef:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80105ef3:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffffffff80105ef6:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
ffffffff80105ef9:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff80105efd:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffffffff80105f00:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80105f03:	48 89 ce             	mov    %rcx,%rsi
ffffffff80105f06:	48 89 f7             	mov    %rsi,%rdi
ffffffff80105f09:	89 d1                	mov    %edx,%ecx
ffffffff80105f0b:	fc                   	cld
ffffffff80105f0c:	f3 aa                	rep stos %al,%es:(%rdi)
ffffffff80105f0e:	89 ca                	mov    %ecx,%edx
ffffffff80105f10:	48 89 fe             	mov    %rdi,%rsi
ffffffff80105f13:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffffffff80105f17:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
ffffffff80105f1a:	90                   	nop
ffffffff80105f1b:	c9                   	leave
ffffffff80105f1c:	c3                   	ret

ffffffff80105f1d <stosl>:
{
ffffffff80105f1d:	55                   	push   %rbp
ffffffff80105f1e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105f21:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80105f25:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80105f29:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffffffff80105f2c:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosl" :
ffffffff80105f2f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff80105f33:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffffffff80105f36:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80105f39:	48 89 ce             	mov    %rcx,%rsi
ffffffff80105f3c:	48 89 f7             	mov    %rsi,%rdi
ffffffff80105f3f:	89 d1                	mov    %edx,%ecx
ffffffff80105f41:	fc                   	cld
ffffffff80105f42:	f3 ab                	rep stos %eax,%es:(%rdi)
ffffffff80105f44:	89 ca                	mov    %ecx,%edx
ffffffff80105f46:	48 89 fe             	mov    %rdi,%rsi
ffffffff80105f49:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffffffff80105f4d:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
ffffffff80105f50:	90                   	nop
ffffffff80105f51:	c9                   	leave
ffffffff80105f52:	c3                   	ret

ffffffff80105f53 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
ffffffff80105f53:	55                   	push   %rbp
ffffffff80105f54:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105f57:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80105f5b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80105f5f:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffffffff80105f62:	89 55 f0             	mov    %edx,-0x10(%rbp)
  if ((uintp)dst%4 == 0 && n%4 == 0){
ffffffff80105f65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105f69:	83 e0 03             	and    $0x3,%eax
ffffffff80105f6c:	48 85 c0             	test   %rax,%rax
ffffffff80105f6f:	75 48                	jne    ffffffff80105fb9 <memset+0x66>
ffffffff80105f71:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff80105f74:	83 e0 03             	and    $0x3,%eax
ffffffff80105f77:	85 c0                	test   %eax,%eax
ffffffff80105f79:	75 3e                	jne    ffffffff80105fb9 <memset+0x66>
    c &= 0xFF;
ffffffff80105f7b:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
ffffffff80105f82:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffffffff80105f85:	c1 e8 02             	shr    $0x2,%eax
ffffffff80105f88:	89 c6                	mov    %eax,%esi
ffffffff80105f8a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80105f8d:	c1 e0 18             	shl    $0x18,%eax
ffffffff80105f90:	89 c2                	mov    %eax,%edx
ffffffff80105f92:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80105f95:	c1 e0 10             	shl    $0x10,%eax
ffffffff80105f98:	09 c2                	or     %eax,%edx
ffffffff80105f9a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80105f9d:	c1 e0 08             	shl    $0x8,%eax
ffffffff80105fa0:	09 d0                	or     %edx,%eax
ffffffff80105fa2:	0b 45 f4             	or     -0xc(%rbp),%eax
ffffffff80105fa5:	89 c1                	mov    %eax,%ecx
ffffffff80105fa7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105fab:	89 f2                	mov    %esi,%edx
ffffffff80105fad:	89 ce                	mov    %ecx,%esi
ffffffff80105faf:	48 89 c7             	mov    %rax,%rdi
ffffffff80105fb2:	e8 66 ff ff ff       	call   ffffffff80105f1d <stosl>
ffffffff80105fb7:	eb 14                	jmp    ffffffff80105fcd <memset+0x7a>
  } else
    stosb(dst, c, n);
ffffffff80105fb9:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffffffff80105fbc:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffffffff80105fbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105fc3:	89 ce                	mov    %ecx,%esi
ffffffff80105fc5:	48 89 c7             	mov    %rax,%rdi
ffffffff80105fc8:	e8 1a ff ff ff       	call   ffffffff80105ee7 <stosb>
  return dst;
ffffffff80105fcd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80105fd1:	c9                   	leave
ffffffff80105fd2:	c3                   	ret

ffffffff80105fd3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
ffffffff80105fd3:	55                   	push   %rbp
ffffffff80105fd4:	48 89 e5             	mov    %rsp,%rbp
ffffffff80105fd7:	48 83 ec 28          	sub    $0x28,%rsp
ffffffff80105fdb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80105fdf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80105fe3:	89 55 dc             	mov    %edx,-0x24(%rbp)
  const uchar *s1, *s2;
  
  s1 = v1;
ffffffff80105fe6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80105fea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  s2 = v2;
ffffffff80105fee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80105ff2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0){
ffffffff80105ff6:	eb 34                	jmp    ffffffff8010602c <memcmp+0x59>
    if(*s1 != *s2)
ffffffff80105ff8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80105ffc:	0f b6 10             	movzbl (%rax),%edx
ffffffff80105fff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106003:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106006:	38 c2                	cmp    %al,%dl
ffffffff80106008:	74 18                	je     ffffffff80106022 <memcmp+0x4f>
      return *s1 - *s2;
ffffffff8010600a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010600e:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106011:	0f b6 d0             	movzbl %al,%edx
ffffffff80106014:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106018:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010601b:	0f b6 c0             	movzbl %al,%eax
ffffffff8010601e:	29 c2                	sub    %eax,%edx
ffffffff80106020:	eb 1c                	jmp    ffffffff8010603e <memcmp+0x6b>
    s1++, s2++;
ffffffff80106022:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffffffff80106027:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n-- > 0){
ffffffff8010602c:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff8010602f:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff80106032:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffffffff80106035:	85 c0                	test   %eax,%eax
ffffffff80106037:	75 bf                	jne    ffffffff80105ff8 <memcmp+0x25>
  }

  return 0;
ffffffff80106039:	ba 00 00 00 00       	mov    $0x0,%edx
}
ffffffff8010603e:	89 d0                	mov    %edx,%eax
ffffffff80106040:	c9                   	leave
ffffffff80106041:	c3                   	ret

ffffffff80106042 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
ffffffff80106042:	55                   	push   %rbp
ffffffff80106043:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106046:	48 83 ec 28          	sub    $0x28,%rsp
ffffffff8010604a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff8010604e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80106052:	89 55 dc             	mov    %edx,-0x24(%rbp)
  const char *s;
  char *d;

  s = src;
ffffffff80106055:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80106059:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  d = dst;
ffffffff8010605d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106061:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(s < d && s + n > d){
ffffffff80106065:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106069:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffffffff8010606d:	73 63                	jae    ffffffff801060d2 <memmove+0x90>
ffffffff8010606f:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffffffff80106072:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106076:	48 01 d0             	add    %rdx,%rax
ffffffff80106079:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffffffff8010607d:	73 53                	jae    ffffffff801060d2 <memmove+0x90>
    s += n;
ffffffff8010607f:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80106082:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    d += n;
ffffffff80106086:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80106089:	48 01 45 f0          	add    %rax,-0x10(%rbp)
    while(n-- > 0)
ffffffff8010608d:	eb 17                	jmp    ffffffff801060a6 <memmove+0x64>
      *--d = *--s;
ffffffff8010608f:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
ffffffff80106094:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
ffffffff80106099:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010609d:	0f b6 10             	movzbl (%rax),%edx
ffffffff801060a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801060a4:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffffffff801060a6:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801060a9:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff801060ac:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffffffff801060af:	85 c0                	test   %eax,%eax
ffffffff801060b1:	75 dc                	jne    ffffffff8010608f <memmove+0x4d>
  if(s < d && s + n > d){
ffffffff801060b3:	eb 2a                	jmp    ffffffff801060df <memmove+0x9d>
  } else
    while(n-- > 0)
      *d++ = *s++;
ffffffff801060b5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801060b9:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffffffff801060bd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801060c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801060c5:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffffffff801060c9:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
ffffffff801060cd:	0f b6 12             	movzbl (%rdx),%edx
ffffffff801060d0:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffffffff801060d2:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801060d5:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff801060d8:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffffffff801060db:	85 c0                	test   %eax,%eax
ffffffff801060dd:	75 d6                	jne    ffffffff801060b5 <memmove+0x73>

  return dst;
ffffffff801060df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffffffff801060e3:	c9                   	leave
ffffffff801060e4:	c3                   	ret

ffffffff801060e5 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
ffffffff801060e5:	55                   	push   %rbp
ffffffff801060e6:	48 89 e5             	mov    %rsp,%rbp
ffffffff801060e9:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff801060ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801060f1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff801060f5:	89 55 ec             	mov    %edx,-0x14(%rbp)
  return memmove(dst, src, n);
ffffffff801060f8:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff801060fb:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffffffff801060ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106103:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106106:	48 89 c7             	mov    %rax,%rdi
ffffffff80106109:	e8 34 ff ff ff       	call   ffffffff80106042 <memmove>
}
ffffffff8010610e:	c9                   	leave
ffffffff8010610f:	c3                   	ret

ffffffff80106110 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
ffffffff80106110:	55                   	push   %rbp
ffffffff80106111:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106114:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80106118:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010611c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80106120:	89 55 ec             	mov    %edx,-0x14(%rbp)
  while(n > 0 && *p && *p == *q)
ffffffff80106123:	eb 0e                	jmp    ffffffff80106133 <strncmp+0x23>
    n--, p++, q++;
ffffffff80106125:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
ffffffff80106129:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffffffff8010612e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n > 0 && *p && *p == *q)
ffffffff80106133:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff80106137:	74 1d                	je     ffffffff80106156 <strncmp+0x46>
ffffffff80106139:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010613d:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106140:	84 c0                	test   %al,%al
ffffffff80106142:	74 12                	je     ffffffff80106156 <strncmp+0x46>
ffffffff80106144:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106148:	0f b6 10             	movzbl (%rax),%edx
ffffffff8010614b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010614f:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106152:	38 c2                	cmp    %al,%dl
ffffffff80106154:	74 cf                	je     ffffffff80106125 <strncmp+0x15>
  if(n == 0)
ffffffff80106156:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff8010615a:	75 07                	jne    ffffffff80106163 <strncmp+0x53>
    return 0;
ffffffff8010615c:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80106161:	eb 16                	jmp    ffffffff80106179 <strncmp+0x69>
  return (uchar)*p - (uchar)*q;
ffffffff80106163:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106167:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010616a:	0f b6 d0             	movzbl %al,%edx
ffffffff8010616d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106171:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106174:	0f b6 c0             	movzbl %al,%eax
ffffffff80106177:	29 c2                	sub    %eax,%edx
}
ffffffff80106179:	89 d0                	mov    %edx,%eax
ffffffff8010617b:	c9                   	leave
ffffffff8010617c:	c3                   	ret

ffffffff8010617d <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
ffffffff8010617d:	55                   	push   %rbp
ffffffff8010617e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106181:	48 83 ec 28          	sub    $0x28,%rsp
ffffffff80106185:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80106189:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff8010618d:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os;
  
  os = s;
ffffffff80106190:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106194:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(n-- > 0 && (*s++ = *t++) != 0)
ffffffff80106198:	90                   	nop
ffffffff80106199:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff8010619c:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff8010619f:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffffffff801061a2:	85 c0                	test   %eax,%eax
ffffffff801061a4:	7e 35                	jle    ffffffff801061db <strncpy+0x5e>
ffffffff801061a6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff801061aa:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffffffff801061ae:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffffffff801061b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801061b6:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffffffff801061ba:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffffffff801061be:	0f b6 12             	movzbl (%rdx),%edx
ffffffff801061c1:	88 10                	mov    %dl,(%rax)
ffffffff801061c3:	0f b6 00             	movzbl (%rax),%eax
ffffffff801061c6:	84 c0                	test   %al,%al
ffffffff801061c8:	75 cf                	jne    ffffffff80106199 <strncpy+0x1c>
    ;
  while(n-- > 0)
ffffffff801061ca:	eb 0f                	jmp    ffffffff801061db <strncpy+0x5e>
    *s++ = 0;
ffffffff801061cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801061d0:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffffffff801061d4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffffffff801061d8:	c6 00 00             	movb   $0x0,(%rax)
  while(n-- > 0)
ffffffff801061db:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff801061de:	8d 50 ff             	lea    -0x1(%rax),%edx
ffffffff801061e1:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffffffff801061e4:	85 c0                	test   %eax,%eax
ffffffff801061e6:	7f e4                	jg     ffffffff801061cc <strncpy+0x4f>
  return os;
ffffffff801061e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff801061ec:	c9                   	leave
ffffffff801061ed:	c3                   	ret

ffffffff801061ee <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
ffffffff801061ee:	55                   	push   %rbp
ffffffff801061ef:	48 89 e5             	mov    %rsp,%rbp
ffffffff801061f2:	48 83 ec 28          	sub    $0x28,%rsp
ffffffff801061f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801061fa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff801061fe:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os;
  
  os = s;
ffffffff80106201:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106205:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n <= 0)
ffffffff80106209:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffffffff8010620d:	7f 06                	jg     ffffffff80106215 <safestrcpy+0x27>
    return os;
ffffffff8010620f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106213:	eb 3a                	jmp    ffffffff8010624f <safestrcpy+0x61>
  while(--n > 0 && (*s++ = *t++) != 0)
ffffffff80106215:	90                   	nop
ffffffff80106216:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
ffffffff8010621a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffffffff8010621e:	7e 24                	jle    ffffffff80106244 <safestrcpy+0x56>
ffffffff80106220:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff80106224:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffffffff80106228:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffffffff8010622c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106230:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffffffff80106234:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffffffff80106238:	0f b6 12             	movzbl (%rdx),%edx
ffffffff8010623b:	88 10                	mov    %dl,(%rax)
ffffffff8010623d:	0f b6 00             	movzbl (%rax),%eax
ffffffff80106240:	84 c0                	test   %al,%al
ffffffff80106242:	75 d2                	jne    ffffffff80106216 <safestrcpy+0x28>
    ;
  *s = 0;
ffffffff80106244:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106248:	c6 00 00             	movb   $0x0,(%rax)
  return os;
ffffffff8010624b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff8010624f:	c9                   	leave
ffffffff80106250:	c3                   	ret

ffffffff80106251 <strlen>:

int
strlen(const char *s)
{
ffffffff80106251:	55                   	push   %rbp
ffffffff80106252:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106255:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80106259:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
ffffffff8010625d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80106264:	eb 04                	jmp    ffffffff8010626a <strlen+0x19>
ffffffff80106266:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff8010626a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010626d:	48 63 d0             	movslq %eax,%rdx
ffffffff80106270:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80106274:	48 01 d0             	add    %rdx,%rax
ffffffff80106277:	0f b6 00             	movzbl (%rax),%eax
ffffffff8010627a:	84 c0                	test   %al,%al
ffffffff8010627c:	75 e8                	jne    ffffffff80106266 <strlen+0x15>
    ;
  return n;
ffffffff8010627e:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff80106281:	c9                   	leave
ffffffff80106282:	c3                   	ret

ffffffff80106283 <swtch>:
# and then load register context from new.

.globl swtch
swtch:
  # Save old callee-save registers
  push %rbp
ffffffff80106283:	55                   	push   %rbp
  push %rbx
ffffffff80106284:	53                   	push   %rbx
  push %r11
ffffffff80106285:	41 53                	push   %r11
  push %r12
ffffffff80106287:	41 54                	push   %r12
  push %r13
ffffffff80106289:	41 55                	push   %r13
  push %r14
ffffffff8010628b:	41 56                	push   %r14
  push %r15
ffffffff8010628d:	41 57                	push   %r15

  # Switch stacks
  mov %rsp, (%rdi)
ffffffff8010628f:	48 89 27             	mov    %rsp,(%rdi)
  mov %rsi, %rsp
ffffffff80106292:	48 89 f4             	mov    %rsi,%rsp

  # Load new callee-save registers
  pop %r15
ffffffff80106295:	41 5f                	pop    %r15
  pop %r14
ffffffff80106297:	41 5e                	pop    %r14
  pop %r13
ffffffff80106299:	41 5d                	pop    %r13
  pop %r12
ffffffff8010629b:	41 5c                	pop    %r12
  pop %r11
ffffffff8010629d:	41 5b                	pop    %r11
  pop %rbx
ffffffff8010629f:	5b                   	pop    %rbx
  pop %rbp
ffffffff801062a0:	5d                   	pop    %rbp

  ret #??
ffffffff801062a1:	c3                   	ret

ffffffff801062a2 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uintp addr, int *ip)
{
ffffffff801062a2:	55                   	push   %rbp
ffffffff801062a3:	48 89 e5             	mov    %rsp,%rbp
ffffffff801062a6:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff801062aa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801062ae:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr >= proc->sz || addr+sizeof(int) > proc->sz)
ffffffff801062b2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801062b9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801062bd:	48 8b 00             	mov    (%rax),%rax
ffffffff801062c0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff801062c4:	73 1b                	jae    ffffffff801062e1 <fetchint+0x3f>
ffffffff801062c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801062ca:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffffffff801062ce:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801062d5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801062d9:	48 8b 00             	mov    (%rax),%rax
ffffffff801062dc:	48 39 d0             	cmp    %rdx,%rax
ffffffff801062df:	73 07                	jae    ffffffff801062e8 <fetchint+0x46>
    return -1;
ffffffff801062e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801062e6:	eb 11                	jmp    ffffffff801062f9 <fetchint+0x57>
  *ip = *(int*)(addr);
ffffffff801062e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801062ec:	8b 10                	mov    (%rax),%edx
ffffffff801062ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801062f2:	89 10                	mov    %edx,(%rax)
  return 0;
ffffffff801062f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801062f9:	c9                   	leave
ffffffff801062fa:	c3                   	ret

ffffffff801062fb <fetchuintp>:

int
fetchuintp(uintp addr, uintp *ip)
{
ffffffff801062fb:	55                   	push   %rbp
ffffffff801062fc:	48 89 e5             	mov    %rsp,%rbp
ffffffff801062ff:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80106303:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80106307:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr >= proc->sz || addr+sizeof(uintp) > proc->sz)
ffffffff8010630b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106312:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106316:	48 8b 00             	mov    (%rax),%rax
ffffffff80106319:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff8010631d:	73 1b                	jae    ffffffff8010633a <fetchuintp+0x3f>
ffffffff8010631f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106323:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffffffff80106327:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010632e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106332:	48 8b 00             	mov    (%rax),%rax
ffffffff80106335:	48 39 d0             	cmp    %rdx,%rax
ffffffff80106338:	73 07                	jae    ffffffff80106341 <fetchuintp+0x46>
    return -1;
ffffffff8010633a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010633f:	eb 13                	jmp    ffffffff80106354 <fetchuintp+0x59>
  *ip = *(uintp*)(addr);
ffffffff80106341:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106345:	48 8b 10             	mov    (%rax),%rdx
ffffffff80106348:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010634c:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffffffff8010634f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80106354:	c9                   	leave
ffffffff80106355:	c3                   	ret

ffffffff80106356 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uintp addr, char **pp)
{
ffffffff80106356:	55                   	push   %rbp
ffffffff80106357:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010635a:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff8010635e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80106362:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s, *ep;

  if(addr >= proc->sz)
ffffffff80106366:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010636d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106371:	48 8b 00             	mov    (%rax),%rax
ffffffff80106374:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffffffff80106378:	72 07                	jb     ffffffff80106381 <fetchstr+0x2b>
    return -1;
ffffffff8010637a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010637f:	eb 5b                	jmp    ffffffff801063dc <fetchstr+0x86>
  *pp = (char*)addr;
ffffffff80106381:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80106385:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80106389:	48 89 10             	mov    %rdx,(%rax)
  ep = (char*)proc->sz;
ffffffff8010638c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106393:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106397:	48 8b 00             	mov    (%rax),%rax
ffffffff8010639a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(s = *pp; s < ep; s++)
ffffffff8010639e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801063a2:	48 8b 00             	mov    (%rax),%rax
ffffffff801063a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801063a9:	eb 22                	jmp    ffffffff801063cd <fetchstr+0x77>
    if(*s == 0)
ffffffff801063ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801063af:	0f b6 00             	movzbl (%rax),%eax
ffffffff801063b2:	84 c0                	test   %al,%al
ffffffff801063b4:	75 12                	jne    ffffffff801063c8 <fetchstr+0x72>
      return s - *pp;
ffffffff801063b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801063ba:	48 8b 00             	mov    (%rax),%rax
ffffffff801063bd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801063c1:	48 29 c2             	sub    %rax,%rdx
ffffffff801063c4:	89 d0                	mov    %edx,%eax
ffffffff801063c6:	eb 14                	jmp    ffffffff801063dc <fetchstr+0x86>
  for(s = *pp; s < ep; s++)
ffffffff801063c8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffffffff801063cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801063d1:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffffffff801063d5:	72 d4                	jb     ffffffff801063ab <fetchstr+0x55>
  return -1;
ffffffff801063d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff801063dc:	c9                   	leave
ffffffff801063dd:	c3                   	ret

ffffffff801063de <fetcharg>:

#if X64
// arguments passed in registers on x64
static uintp
fetcharg(int n)
{
ffffffff801063de:	55                   	push   %rbp
ffffffff801063df:	48 89 e5             	mov    %rsp,%rbp
ffffffff801063e2:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801063e6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  switch (n) {
ffffffff801063e9:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffffffff801063ed:	0f 87 8b 00 00 00    	ja     ffffffff8010647e <fetcharg+0xa0>
ffffffff801063f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801063f6:	48 8b 04 c5 58 a0 10 	mov    -0x7fef5fa8(,%rax,8),%rax
ffffffff801063fd:	80 
ffffffff801063fe:	ff e0                	jmp    *%rax
  case 0: return proc->tf->rdi;
ffffffff80106400:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106407:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010640b:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff8010640f:	48 8b 40 30          	mov    0x30(%rax),%rax
ffffffff80106413:	eb 69                	jmp    ffffffff8010647e <fetcharg+0xa0>
  case 1: return proc->tf->rsi;
ffffffff80106415:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010641c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106420:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106424:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106428:	eb 54                	jmp    ffffffff8010647e <fetcharg+0xa0>
  case 2: return proc->tf->rdx;
ffffffff8010642a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106431:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106435:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106439:	48 8b 40 18          	mov    0x18(%rax),%rax
ffffffff8010643d:	eb 3f                	jmp    ffffffff8010647e <fetcharg+0xa0>
  case 3: return proc->tf->rcx;
ffffffff8010643f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106446:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010644a:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff8010644e:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80106452:	eb 2a                	jmp    ffffffff8010647e <fetcharg+0xa0>
  case 4: return proc->tf->r8;
ffffffff80106454:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010645b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010645f:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106463:	48 8b 40 38          	mov    0x38(%rax),%rax
ffffffff80106467:	eb 15                	jmp    ffffffff8010647e <fetcharg+0xa0>
  case 5: return proc->tf->r9;
ffffffff80106469:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106470:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106474:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106478:	48 8b 40 40          	mov    0x40(%rax),%rax
ffffffff8010647c:	eb 00                	jmp    ffffffff8010647e <fetcharg+0xa0>
  }
}
ffffffff8010647e:	c9                   	leave
ffffffff8010647f:	c3                   	ret

ffffffff80106480 <argint>:

int
argint(int n, int *ip)
{
ffffffff80106480:	55                   	push   %rbp
ffffffff80106481:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106484:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80106488:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff8010648b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffffffff8010648f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80106492:	89 c7                	mov    %eax,%edi
ffffffff80106494:	e8 45 ff ff ff       	call   ffffffff801063de <fetcharg>
ffffffff80106499:	89 c2                	mov    %eax,%edx
ffffffff8010649b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010649f:	89 10                	mov    %edx,(%rax)
  return 0;
ffffffff801064a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801064a6:	c9                   	leave
ffffffff801064a7:	c3                   	ret

ffffffff801064a8 <arguintp>:

int
arguintp(int n, uintp *ip)
{
ffffffff801064a8:	55                   	push   %rbp
ffffffff801064a9:	48 89 e5             	mov    %rsp,%rbp
ffffffff801064ac:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff801064b0:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffffffff801064b3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffffffff801064b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801064ba:	89 c7                	mov    %eax,%edi
ffffffff801064bc:	e8 1d ff ff ff       	call   ffffffff801063de <fetcharg>
ffffffff801064c1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff801064c5:	48 89 02             	mov    %rax,(%rdx)
  return 0;
ffffffff801064c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801064cd:	c9                   	leave
ffffffff801064ce:	c3                   	ret

ffffffff801064cf <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
ffffffff801064cf:	55                   	push   %rbp
ffffffff801064d0:	48 89 e5             	mov    %rsp,%rbp
ffffffff801064d3:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801064d7:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff801064da:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff801064de:	89 55 e8             	mov    %edx,-0x18(%rbp)
  uintp i;

  if(arguintp(n, &i) < 0)
ffffffff801064e1:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffffffff801064e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff801064e8:	48 89 d6             	mov    %rdx,%rsi
ffffffff801064eb:	89 c7                	mov    %eax,%edi
ffffffff801064ed:	e8 b6 ff ff ff       	call   ffffffff801064a8 <arguintp>
ffffffff801064f2:	85 c0                	test   %eax,%eax
ffffffff801064f4:	79 07                	jns    ffffffff801064fd <argptr+0x2e>
    return -1;
ffffffff801064f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801064fb:	eb 51                	jmp    ffffffff8010654e <argptr+0x7f>
  if(i >= proc->sz || i+size > proc->sz)
ffffffff801064fd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106504:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106508:	48 8b 00             	mov    (%rax),%rax
ffffffff8010650b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff8010650f:	48 39 c2             	cmp    %rax,%rdx
ffffffff80106512:	73 20                	jae    ffffffff80106534 <argptr+0x65>
ffffffff80106514:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffffffff80106517:	48 63 d0             	movslq %eax,%rdx
ffffffff8010651a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010651e:	48 01 c2             	add    %rax,%rdx
ffffffff80106521:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106528:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010652c:	48 8b 00             	mov    (%rax),%rax
ffffffff8010652f:	48 39 d0             	cmp    %rdx,%rax
ffffffff80106532:	73 07                	jae    ffffffff8010653b <argptr+0x6c>
    return -1;
ffffffff80106534:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106539:	eb 13                	jmp    ffffffff8010654e <argptr+0x7f>
  *pp = (char*)i;
ffffffff8010653b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010653f:	48 89 c2             	mov    %rax,%rdx
ffffffff80106542:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80106546:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffffffff80106549:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff8010654e:	c9                   	leave
ffffffff8010654f:	c3                   	ret

ffffffff80106550 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
ffffffff80106550:	55                   	push   %rbp
ffffffff80106551:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106554:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80106558:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff8010655b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uintp addr;
  if(arguintp(n, &addr) < 0)
ffffffff8010655f:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffffffff80106563:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80106566:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106569:	89 c7                	mov    %eax,%edi
ffffffff8010656b:	e8 38 ff ff ff       	call   ffffffff801064a8 <arguintp>
ffffffff80106570:	85 c0                	test   %eax,%eax
ffffffff80106572:	79 07                	jns    ffffffff8010657b <argstr+0x2b>
    return -1;
ffffffff80106574:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106579:	eb 13                	jmp    ffffffff8010658e <argstr+0x3e>
  return fetchstr(addr, pp);
ffffffff8010657b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010657f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff80106583:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106586:	48 89 c7             	mov    %rax,%rdi
ffffffff80106589:	e8 c8 fd ff ff       	call   ffffffff80106356 <fetchstr>
}
ffffffff8010658e:	c9                   	leave
ffffffff8010658f:	c3                   	ret

ffffffff80106590 <syscall>:
//Πίνακας που μετράει πόσες φορές εκτελέστηκε το κάθε syscall
int syscallsCount[SYSCALLCROWD] = {0};

void
syscall(void)
{
ffffffff80106590:	55                   	push   %rbp
ffffffff80106591:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106594:	48 83 ec 10          	sub    $0x10,%rsp
  int num;

  num = proc->tf->eax;
ffffffff80106598:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010659f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801065a3:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff801065a7:	48 8b 00             	mov    (%rax),%rax
ffffffff801065aa:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
ffffffff801065ad:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801065b1:	7e 64                	jle    ffffffff80106617 <syscall+0x87>
ffffffff801065b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801065b6:	83 f8 1c             	cmp    $0x1c,%eax
ffffffff801065b9:	77 5c                	ja     ffffffff80106617 <syscall+0x87>
ffffffff801065bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801065be:	48 98                	cltq
ffffffff801065c0:	48 8b 04 c5 c0 b5 10 	mov    -0x7fef4a40(,%rax,8),%rax
ffffffff801065c7:	80 
ffffffff801065c8:	48 85 c0             	test   %rax,%rax
ffffffff801065cb:	74 4a                	je     ffffffff80106617 <syscall+0x87>
    proc->tf->eax = syscalls[num]();
ffffffff801065cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801065d0:	48 98                	cltq
ffffffff801065d2:	48 8b 04 c5 c0 b5 10 	mov    -0x7fef4a40(,%rax,8),%rax
ffffffff801065d9:	80 
ffffffff801065da:	ff d0                	call   *%rax
ffffffff801065dc:	89 c2                	mov    %eax,%edx
ffffffff801065de:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801065e5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801065e9:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff801065ed:	48 63 d2             	movslq %edx,%rdx
ffffffff801065f0:	48 89 10             	mov    %rdx,(%rax)
    syscallsCount[num-1] += 1;
ffffffff801065f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801065f6:	83 e8 01             	sub    $0x1,%eax
ffffffff801065f9:	48 98                	cltq
ffffffff801065fb:	8b 04 85 80 40 11 80 	mov    -0x7feebf80(,%rax,4),%eax
ffffffff80106602:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106605:	8d 4a ff             	lea    -0x1(%rdx),%ecx
ffffffff80106608:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff8010660b:	48 63 c1             	movslq %ecx,%rax
ffffffff8010660e:	89 14 85 80 40 11 80 	mov    %edx,-0x7feebf80(,%rax,4)
ffffffff80106615:	eb 52                	jmp    ffffffff80106669 <syscall+0xd9>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
ffffffff80106617:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010661e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106622:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffffffff80106629:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106630:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80106634:	8b 40 1c             	mov    0x1c(%rax),%eax
    cprintf("%d %s: unknown sys call %d\n",
ffffffff80106637:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010663a:	89 d1                	mov    %edx,%ecx
ffffffff8010663c:	48 89 f2             	mov    %rsi,%rdx
ffffffff8010663f:	89 c6                	mov    %eax,%esi
ffffffff80106641:	48 c7 c7 88 a0 10 80 	mov    $0xffffffff8010a088,%rdi
ffffffff80106648:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010664d:	e8 52 9f ff ff       	call   ffffffff801005a4 <cprintf>
    proc->tf->eax = -1;
ffffffff80106652:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80106659:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010665d:	48 8b 40 28          	mov    0x28(%rax),%rax
ffffffff80106661:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
  }
}
ffffffff80106668:	90                   	nop
ffffffff80106669:	90                   	nop
ffffffff8010666a:	c9                   	leave
ffffffff8010666b:	c3                   	ret

ffffffff8010666c <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
ffffffff8010666c:	55                   	push   %rbp
ffffffff8010666d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106670:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80106674:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff80106677:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff8010667b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
ffffffff8010667f:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
ffffffff80106683:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80106686:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106689:	89 c7                	mov    %eax,%edi
ffffffff8010668b:	e8 f0 fd ff ff       	call   ffffffff80106480 <argint>
ffffffff80106690:	85 c0                	test   %eax,%eax
ffffffff80106692:	79 07                	jns    ffffffff8010669b <argfd+0x2f>
    return -1;
ffffffff80106694:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106699:	eb 62                	jmp    ffffffff801066fd <argfd+0x91>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
ffffffff8010669b:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff8010669e:	85 c0                	test   %eax,%eax
ffffffff801066a0:	78 2d                	js     ffffffff801066cf <argfd+0x63>
ffffffff801066a2:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff801066a5:	83 f8 0f             	cmp    $0xf,%eax
ffffffff801066a8:	7f 25                	jg     ffffffff801066cf <argfd+0x63>
ffffffff801066aa:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801066b1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801066b5:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff801066b8:	48 63 d2             	movslq %edx,%rdx
ffffffff801066bb:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801066bf:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff801066c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801066c8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801066cd:	75 07                	jne    ffffffff801066d6 <argfd+0x6a>
    return -1;
ffffffff801066cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801066d4:	eb 27                	jmp    ffffffff801066fd <argfd+0x91>
  if(pfd)
ffffffff801066d6:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffffffff801066db:	74 09                	je     ffffffff801066e6 <argfd+0x7a>
    *pfd = fd;
ffffffff801066dd:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff801066e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801066e4:	89 10                	mov    %edx,(%rax)
  if(pf)
ffffffff801066e6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffffffff801066eb:	74 0b                	je     ffffffff801066f8 <argfd+0x8c>
    *pf = f;
ffffffff801066ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801066f1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801066f5:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffffffff801066f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801066fd:	c9                   	leave
ffffffff801066fe:	c3                   	ret

ffffffff801066ff <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
ffffffff801066ff:	55                   	push   %rbp
ffffffff80106700:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106703:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80106707:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
ffffffff8010670b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80106712:	eb 46                	jmp    ffffffff8010675a <fdalloc+0x5b>
    if(proc->ofile[fd] == 0){
ffffffff80106714:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010671b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010671f:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106722:	48 63 d2             	movslq %edx,%rdx
ffffffff80106725:	48 83 c2 08          	add    $0x8,%rdx
ffffffff80106729:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffffffff8010672e:	48 85 c0             	test   %rax,%rax
ffffffff80106731:	75 23                	jne    ffffffff80106756 <fdalloc+0x57>
      proc->ofile[fd] = f;
ffffffff80106733:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010673a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010673e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106741:	48 63 d2             	movslq %edx,%rdx
ffffffff80106744:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffffffff80106748:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff8010674c:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
      return fd;
ffffffff80106751:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80106754:	eb 0f                	jmp    ffffffff80106765 <fdalloc+0x66>
  for(fd = 0; fd < NOFILE; fd++){
ffffffff80106756:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff8010675a:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffffffff8010675e:	7e b4                	jle    ffffffff80106714 <fdalloc+0x15>
    }
  }
  return -1;
ffffffff80106760:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80106765:	c9                   	leave
ffffffff80106766:	c3                   	ret

ffffffff80106767 <sys_dup>:

int
sys_dup(void)
{
ffffffff80106767:	55                   	push   %rbp
ffffffff80106768:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010676b:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
ffffffff8010676f:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff80106773:	48 89 c2             	mov    %rax,%rdx
ffffffff80106776:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff8010677b:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80106780:	e8 e7 fe ff ff       	call   ffffffff8010666c <argfd>
ffffffff80106785:	85 c0                	test   %eax,%eax
ffffffff80106787:	79 07                	jns    ffffffff80106790 <sys_dup+0x29>
    return -1;
ffffffff80106789:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010678e:	eb 2b                	jmp    ffffffff801067bb <sys_dup+0x54>
  if((fd=fdalloc(f)) < 0)
ffffffff80106790:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106794:	48 89 c7             	mov    %rax,%rdi
ffffffff80106797:	e8 63 ff ff ff       	call   ffffffff801066ff <fdalloc>
ffffffff8010679c:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff8010679f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff801067a3:	79 07                	jns    ffffffff801067ac <sys_dup+0x45>
    return -1;
ffffffff801067a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801067aa:	eb 0f                	jmp    ffffffff801067bb <sys_dup+0x54>
  filedup(f);
ffffffff801067ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801067b0:	48 89 c7             	mov    %rax,%rdi
ffffffff801067b3:	e8 43 ad ff ff       	call   ffffffff801014fb <filedup>
  return fd;
ffffffff801067b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff801067bb:	c9                   	leave
ffffffff801067bc:	c3                   	ret

ffffffff801067bd <sys_read>:

int
sys_read(void)
{
ffffffff801067bd:	55                   	push   %rbp
ffffffff801067be:	48 89 e5             	mov    %rsp,%rbp
ffffffff801067c1:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffffffff801067c5:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffffffff801067c9:	48 89 c2             	mov    %rax,%rdx
ffffffff801067cc:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801067d1:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801067d6:	e8 91 fe ff ff       	call   ffffffff8010666c <argfd>
ffffffff801067db:	85 c0                	test   %eax,%eax
ffffffff801067dd:	78 2d                	js     ffffffff8010680c <sys_read+0x4f>
ffffffff801067df:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffffffff801067e3:	48 89 c6             	mov    %rax,%rsi
ffffffff801067e6:	bf 02 00 00 00       	mov    $0x2,%edi
ffffffff801067eb:	e8 90 fc ff ff       	call   ffffffff80106480 <argint>
ffffffff801067f0:	85 c0                	test   %eax,%eax
ffffffff801067f2:	78 18                	js     ffffffff8010680c <sys_read+0x4f>
ffffffff801067f4:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff801067f7:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff801067fb:	48 89 c6             	mov    %rax,%rsi
ffffffff801067fe:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80106803:	e8 c7 fc ff ff       	call   ffffffff801064cf <argptr>
ffffffff80106808:	85 c0                	test   %eax,%eax
ffffffff8010680a:	79 07                	jns    ffffffff80106813 <sys_read+0x56>
    return -1;
ffffffff8010680c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106811:	eb 16                	jmp    ffffffff80106829 <sys_read+0x6c>
  return fileread(f, p, n);
ffffffff80106813:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80106816:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffffffff8010681a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010681e:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106821:	48 89 c7             	mov    %rax,%rdi
ffffffff80106824:	e8 7a ae ff ff       	call   ffffffff801016a3 <fileread>
}
ffffffff80106829:	c9                   	leave
ffffffff8010682a:	c3                   	ret

ffffffff8010682b <sys_write>:

int
sys_write(void)
{
ffffffff8010682b:	55                   	push   %rbp
ffffffff8010682c:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010682f:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffffffff80106833:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffffffff80106837:	48 89 c2             	mov    %rax,%rdx
ffffffff8010683a:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff8010683f:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80106844:	e8 23 fe ff ff       	call   ffffffff8010666c <argfd>
ffffffff80106849:	85 c0                	test   %eax,%eax
ffffffff8010684b:	78 2d                	js     ffffffff8010687a <sys_write+0x4f>
ffffffff8010684d:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffffffff80106851:	48 89 c6             	mov    %rax,%rsi
ffffffff80106854:	bf 02 00 00 00       	mov    $0x2,%edi
ffffffff80106859:	e8 22 fc ff ff       	call   ffffffff80106480 <argint>
ffffffff8010685e:	85 c0                	test   %eax,%eax
ffffffff80106860:	78 18                	js     ffffffff8010687a <sys_write+0x4f>
ffffffff80106862:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80106865:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff80106869:	48 89 c6             	mov    %rax,%rsi
ffffffff8010686c:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80106871:	e8 59 fc ff ff       	call   ffffffff801064cf <argptr>
ffffffff80106876:	85 c0                	test   %eax,%eax
ffffffff80106878:	79 07                	jns    ffffffff80106881 <sys_write+0x56>
    return -1;
ffffffff8010687a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff8010687f:	eb 16                	jmp    ffffffff80106897 <sys_write+0x6c>
  return filewrite(f, p, n);
ffffffff80106881:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80106884:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffffffff80106888:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010688c:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010688f:	48 89 c7             	mov    %rax,%rdi
ffffffff80106892:	e8 d4 ae ff ff       	call   ffffffff8010176b <filewrite>
}
ffffffff80106897:	c9                   	leave
ffffffff80106898:	c3                   	ret

ffffffff80106899 <sys_close>:

int
sys_close(void)
{
ffffffff80106899:	55                   	push   %rbp
ffffffff8010689a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010689d:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
ffffffff801068a1:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
ffffffff801068a5:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffffffff801068a9:	48 89 c6             	mov    %rax,%rsi
ffffffff801068ac:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801068b1:	e8 b6 fd ff ff       	call   ffffffff8010666c <argfd>
ffffffff801068b6:	85 c0                	test   %eax,%eax
ffffffff801068b8:	79 07                	jns    ffffffff801068c1 <sys_close+0x28>
    return -1;
ffffffff801068ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801068bf:	eb 2f                	jmp    ffffffff801068f0 <sys_close+0x57>
  proc->ofile[fd] = 0;
ffffffff801068c1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801068c8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801068cc:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff801068cf:	48 63 d2             	movslq %edx,%rdx
ffffffff801068d2:	48 83 c2 08          	add    $0x8,%rdx
ffffffff801068d6:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffffffff801068dd:	00 00 
  fileclose(f);
ffffffff801068df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801068e3:	48 89 c7             	mov    %rax,%rdi
ffffffff801068e6:	e8 62 ac ff ff       	call   ffffffff8010154d <fileclose>
  return 0;
ffffffff801068eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801068f0:	c9                   	leave
ffffffff801068f1:	c3                   	ret

ffffffff801068f2 <sys_fstat>:

int
sys_fstat(void)
{
ffffffff801068f2:	55                   	push   %rbp
ffffffff801068f3:	48 89 e5             	mov    %rsp,%rbp
ffffffff801068f6:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
ffffffff801068fa:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffffffff801068fe:	48 89 c2             	mov    %rax,%rdx
ffffffff80106901:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80106906:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff8010690b:	e8 5c fd ff ff       	call   ffffffff8010666c <argfd>
ffffffff80106910:	85 c0                	test   %eax,%eax
ffffffff80106912:	78 1a                	js     ffffffff8010692e <sys_fstat+0x3c>
ffffffff80106914:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff80106918:	ba 14 00 00 00       	mov    $0x14,%edx
ffffffff8010691d:	48 89 c6             	mov    %rax,%rsi
ffffffff80106920:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80106925:	e8 a5 fb ff ff       	call   ffffffff801064cf <argptr>
ffffffff8010692a:	85 c0                	test   %eax,%eax
ffffffff8010692c:	79 07                	jns    ffffffff80106935 <sys_fstat+0x43>
    return -1;
ffffffff8010692e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106933:	eb 13                	jmp    ffffffff80106948 <sys_fstat+0x56>
  return filestat(f, st);
ffffffff80106935:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff80106939:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010693d:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106940:	48 89 c7             	mov    %rax,%rdi
ffffffff80106943:	e8 fb ac ff ff       	call   ffffffff80101643 <filestat>
}
ffffffff80106948:	c9                   	leave
ffffffff80106949:	c3                   	ret

ffffffff8010694a <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
ffffffff8010694a:	55                   	push   %rbp
ffffffff8010694b:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010694e:	48 83 ec 30          	sub    $0x30,%rsp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
ffffffff80106952:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffffffff80106956:	48 89 c6             	mov    %rax,%rsi
ffffffff80106959:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff8010695e:	e8 ed fb ff ff       	call   ffffffff80106550 <argstr>
ffffffff80106963:	85 c0                	test   %eax,%eax
ffffffff80106965:	78 15                	js     ffffffff8010697c <sys_link+0x32>
ffffffff80106967:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
ffffffff8010696b:	48 89 c6             	mov    %rax,%rsi
ffffffff8010696e:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80106973:	e8 d8 fb ff ff       	call   ffffffff80106550 <argstr>
ffffffff80106978:	85 c0                	test   %eax,%eax
ffffffff8010697a:	79 0a                	jns    ffffffff80106986 <sys_link+0x3c>
    return -1;
ffffffff8010697c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106981:	e9 6a 01 00 00       	jmp    ffffffff80106af0 <sys_link+0x1a6>
  if((ip = namei(old)) == 0)
ffffffff80106986:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010698a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010698d:	e8 d1 c1 ff ff       	call   ffffffff80102b63 <namei>
ffffffff80106992:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80106996:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff8010699b:	75 0a                	jne    ffffffff801069a7 <sys_link+0x5d>
    return -1;
ffffffff8010699d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801069a2:	e9 49 01 00 00       	jmp    ffffffff80106af0 <sys_link+0x1a6>

  begin_trans();
ffffffff801069a7:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801069ac:	e8 96 d0 ff ff       	call   ffffffff80103a47 <begin_trans>

  ilock(ip);
ffffffff801069b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801069b5:	48 89 c7             	mov    %rax,%rdi
ffffffff801069b8:	e8 db b4 ff ff       	call   ffffffff80101e98 <ilock>
  if(ip->type == T_DIR){
ffffffff801069bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801069c1:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff801069c5:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff801069c9:	75 20                	jne    ffffffff801069eb <sys_link+0xa1>
    iunlockput(ip);
ffffffff801069cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801069cf:	48 89 c7             	mov    %rax,%rdi
ffffffff801069d2:	e8 89 b7 ff ff       	call   ffffffff80102160 <iunlockput>
    commit_trans();
ffffffff801069d7:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801069dc:	e8 ae d0 ff ff       	call   ffffffff80103a8f <commit_trans>
    return -1;
ffffffff801069e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801069e6:	e9 05 01 00 00       	jmp    ffffffff80106af0 <sys_link+0x1a6>
  }

  ip->nlink++;
ffffffff801069eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801069ef:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff801069f3:	83 c0 01             	add    $0x1,%eax
ffffffff801069f6:	89 c2                	mov    %eax,%edx
ffffffff801069f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801069fc:	66 89 50 16          	mov    %dx,0x16(%rax)
  iupdate(ip);
ffffffff80106a00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106a04:	48 89 c7             	mov    %rax,%rdi
ffffffff80106a07:	e8 8e b2 ff ff       	call   ffffffff80101c9a <iupdate>
  iunlock(ip);
ffffffff80106a0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106a10:	48 89 c7             	mov    %rax,%rdi
ffffffff80106a13:	e8 f1 b5 ff ff       	call   ffffffff80102009 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
ffffffff80106a18:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80106a1c:	48 8d 55 e2          	lea    -0x1e(%rbp),%rdx
ffffffff80106a20:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106a23:	48 89 c7             	mov    %rax,%rdi
ffffffff80106a26:	e8 5b c1 ff ff       	call   ffffffff80102b86 <nameiparent>
ffffffff80106a2b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80106a2f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80106a34:	74 71                	je     ffffffff80106aa7 <sys_link+0x15d>
    goto bad;
  ilock(dp);
ffffffff80106a36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106a3a:	48 89 c7             	mov    %rax,%rdi
ffffffff80106a3d:	e8 56 b4 ff ff       	call   ffffffff80101e98 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
ffffffff80106a42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106a46:	8b 10                	mov    (%rax),%edx
ffffffff80106a48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106a4c:	8b 00                	mov    (%rax),%eax
ffffffff80106a4e:	39 c2                	cmp    %eax,%edx
ffffffff80106a50:	75 1e                	jne    ffffffff80106a70 <sys_link+0x126>
ffffffff80106a52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106a56:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff80106a59:	48 8d 4d e2          	lea    -0x1e(%rbp),%rcx
ffffffff80106a5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106a61:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106a64:	48 89 c7             	mov    %rax,%rdi
ffffffff80106a67:	e8 04 be ff ff       	call   ffffffff80102870 <dirlink>
ffffffff80106a6c:	85 c0                	test   %eax,%eax
ffffffff80106a6e:	79 0e                	jns    ffffffff80106a7e <sys_link+0x134>
    iunlockput(dp);
ffffffff80106a70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106a74:	48 89 c7             	mov    %rax,%rdi
ffffffff80106a77:	e8 e4 b6 ff ff       	call   ffffffff80102160 <iunlockput>
    goto bad;
ffffffff80106a7c:	eb 2a                	jmp    ffffffff80106aa8 <sys_link+0x15e>
  }
  iunlockput(dp);
ffffffff80106a7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106a82:	48 89 c7             	mov    %rax,%rdi
ffffffff80106a85:	e8 d6 b6 ff ff       	call   ffffffff80102160 <iunlockput>
  iput(ip);
ffffffff80106a8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106a8e:	48 89 c7             	mov    %rax,%rdi
ffffffff80106a91:	e8 e5 b5 ff ff       	call   ffffffff8010207b <iput>

  commit_trans();
ffffffff80106a96:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106a9b:	e8 ef cf ff ff       	call   ffffffff80103a8f <commit_trans>

  return 0;
ffffffff80106aa0:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106aa5:	eb 49                	jmp    ffffffff80106af0 <sys_link+0x1a6>
    goto bad;
ffffffff80106aa7:	90                   	nop

bad:
  ilock(ip);
ffffffff80106aa8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106aac:	48 89 c7             	mov    %rax,%rdi
ffffffff80106aaf:	e8 e4 b3 ff ff       	call   ffffffff80101e98 <ilock>
  ip->nlink--;
ffffffff80106ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106ab8:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80106abc:	83 e8 01             	sub    $0x1,%eax
ffffffff80106abf:	89 c2                	mov    %eax,%edx
ffffffff80106ac1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106ac5:	66 89 50 16          	mov    %dx,0x16(%rax)
  iupdate(ip);
ffffffff80106ac9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106acd:	48 89 c7             	mov    %rax,%rdi
ffffffff80106ad0:	e8 c5 b1 ff ff       	call   ffffffff80101c9a <iupdate>
  iunlockput(ip);
ffffffff80106ad5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106ad9:	48 89 c7             	mov    %rax,%rdi
ffffffff80106adc:	e8 7f b6 ff ff       	call   ffffffff80102160 <iunlockput>
  commit_trans();
ffffffff80106ae1:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106ae6:	e8 a4 cf ff ff       	call   ffffffff80103a8f <commit_trans>
  return -1;
ffffffff80106aeb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80106af0:	c9                   	leave
ffffffff80106af1:	c3                   	ret

ffffffff80106af2 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
ffffffff80106af2:	55                   	push   %rbp
ffffffff80106af3:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106af6:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80106afa:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffffffff80106afe:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffffffff80106b05:	eb 42                	jmp    ffffffff80106b49 <isdirempty+0x57>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffffffff80106b07:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106b0a:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffffffff80106b0e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80106b12:	b9 10 00 00 00       	mov    $0x10,%ecx
ffffffff80106b17:	48 89 c7             	mov    %rax,%rdi
ffffffff80106b1a:	e8 21 b9 ff ff       	call   ffffffff80102440 <readi>
ffffffff80106b1f:	83 f8 10             	cmp    $0x10,%eax
ffffffff80106b22:	74 0c                	je     ffffffff80106b30 <isdirempty+0x3e>
      panic("isdirempty: readi");
ffffffff80106b24:	48 c7 c7 a4 a0 10 80 	mov    $0xffffffff8010a0a4,%rdi
ffffffff80106b2b:	e8 ff 9d ff ff       	call   ffffffff8010092f <panic>
    if(de.inum != 0)
ffffffff80106b30:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffffffff80106b34:	66 85 c0             	test   %ax,%ax
ffffffff80106b37:	74 07                	je     ffffffff80106b40 <isdirempty+0x4e>
      return 0;
ffffffff80106b39:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106b3e:	eb 1c                	jmp    ffffffff80106b5c <isdirempty+0x6a>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffffffff80106b40:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80106b43:	83 c0 10             	add    $0x10,%eax
ffffffff80106b46:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80106b49:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80106b4d:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80106b50:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80106b53:	39 c2                	cmp    %eax,%edx
ffffffff80106b55:	72 b0                	jb     ffffffff80106b07 <isdirempty+0x15>
  }
  return 1;
ffffffff80106b57:	b8 01 00 00 00       	mov    $0x1,%eax
}
ffffffff80106b5c:	c9                   	leave
ffffffff80106b5d:	c3                   	ret

ffffffff80106b5e <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
ffffffff80106b5e:	55                   	push   %rbp
ffffffff80106b5f:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106b62:	48 83 ec 40          	sub    $0x40,%rsp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
ffffffff80106b66:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
ffffffff80106b6a:	48 89 c6             	mov    %rax,%rsi
ffffffff80106b6d:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80106b72:	e8 d9 f9 ff ff       	call   ffffffff80106550 <argstr>
ffffffff80106b77:	85 c0                	test   %eax,%eax
ffffffff80106b79:	79 0a                	jns    ffffffff80106b85 <sys_unlink+0x27>
    return -1;
ffffffff80106b7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106b80:	e9 c5 01 00 00       	jmp    ffffffff80106d4a <sys_unlink+0x1ec>
  if((dp = nameiparent(path, name)) == 0)
ffffffff80106b85:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80106b89:	48 8d 55 d2          	lea    -0x2e(%rbp),%rdx
ffffffff80106b8d:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106b90:	48 89 c7             	mov    %rax,%rdi
ffffffff80106b93:	e8 ee bf ff ff       	call   ffffffff80102b86 <nameiparent>
ffffffff80106b98:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80106b9c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80106ba1:	75 0a                	jne    ffffffff80106bad <sys_unlink+0x4f>
    return -1;
ffffffff80106ba3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106ba8:	e9 9d 01 00 00       	jmp    ffffffff80106d4a <sys_unlink+0x1ec>

  begin_trans();
ffffffff80106bad:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106bb2:	e8 90 ce ff ff       	call   ffffffff80103a47 <begin_trans>

  ilock(dp);
ffffffff80106bb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106bbb:	48 89 c7             	mov    %rax,%rdi
ffffffff80106bbe:	e8 d5 b2 ff ff       	call   ffffffff80101e98 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
ffffffff80106bc3:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffffffff80106bc7:	48 c7 c6 b6 a0 10 80 	mov    $0xffffffff8010a0b6,%rsi
ffffffff80106bce:	48 89 c7             	mov    %rax,%rdi
ffffffff80106bd1:	e8 9f bb ff ff       	call   ffffffff80102775 <namecmp>
ffffffff80106bd6:	85 c0                	test   %eax,%eax
ffffffff80106bd8:	0f 84 4d 01 00 00    	je     ffffffff80106d2b <sys_unlink+0x1cd>
ffffffff80106bde:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffffffff80106be2:	48 c7 c6 b8 a0 10 80 	mov    $0xffffffff8010a0b8,%rsi
ffffffff80106be9:	48 89 c7             	mov    %rax,%rdi
ffffffff80106bec:	e8 84 bb ff ff       	call   ffffffff80102775 <namecmp>
ffffffff80106bf1:	85 c0                	test   %eax,%eax
ffffffff80106bf3:	0f 84 32 01 00 00    	je     ffffffff80106d2b <sys_unlink+0x1cd>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
ffffffff80106bf9:	48 8d 55 c4          	lea    -0x3c(%rbp),%rdx
ffffffff80106bfd:	48 8d 4d d2          	lea    -0x2e(%rbp),%rcx
ffffffff80106c01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106c05:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106c08:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c0b:	e8 8f bb ff ff       	call   ffffffff8010279f <dirlookup>
ffffffff80106c10:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80106c14:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80106c19:	0f 84 0f 01 00 00    	je     ffffffff80106d2e <sys_unlink+0x1d0>
    goto bad;
  ilock(ip);
ffffffff80106c1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106c23:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c26:	e8 6d b2 ff ff       	call   ffffffff80101e98 <ilock>

  if(ip->nlink < 1)
ffffffff80106c2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106c2f:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80106c33:	66 85 c0             	test   %ax,%ax
ffffffff80106c36:	7f 0c                	jg     ffffffff80106c44 <sys_unlink+0xe6>
    panic("unlink: nlink < 1");
ffffffff80106c38:	48 c7 c7 bb a0 10 80 	mov    $0xffffffff8010a0bb,%rdi
ffffffff80106c3f:	e8 eb 9c ff ff       	call   ffffffff8010092f <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
ffffffff80106c44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106c48:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80106c4c:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff80106c50:	75 21                	jne    ffffffff80106c73 <sys_unlink+0x115>
ffffffff80106c52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106c56:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c59:	e8 94 fe ff ff       	call   ffffffff80106af2 <isdirempty>
ffffffff80106c5e:	85 c0                	test   %eax,%eax
ffffffff80106c60:	75 11                	jne    ffffffff80106c73 <sys_unlink+0x115>
    iunlockput(ip);
ffffffff80106c62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106c66:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c69:	e8 f2 b4 ff ff       	call   ffffffff80102160 <iunlockput>
    goto bad;
ffffffff80106c6e:	e9 bc 00 00 00       	jmp    ffffffff80106d2f <sys_unlink+0x1d1>
  }

  memset(&de, 0, sizeof(de));
ffffffff80106c73:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffffffff80106c77:	ba 10 00 00 00       	mov    $0x10,%edx
ffffffff80106c7c:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80106c81:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c84:	e8 ca f2 ff ff       	call   ffffffff80105f53 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffffffff80106c89:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffffffff80106c8c:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffffffff80106c90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106c94:	b9 10 00 00 00       	mov    $0x10,%ecx
ffffffff80106c99:	48 89 c7             	mov    %rax,%rdi
ffffffff80106c9c:	e8 23 b9 ff ff       	call   ffffffff801025c4 <writei>
ffffffff80106ca1:	83 f8 10             	cmp    $0x10,%eax
ffffffff80106ca4:	74 0c                	je     ffffffff80106cb2 <sys_unlink+0x154>
    panic("unlink: writei");
ffffffff80106ca6:	48 c7 c7 cd a0 10 80 	mov    $0xffffffff8010a0cd,%rdi
ffffffff80106cad:	e8 7d 9c ff ff       	call   ffffffff8010092f <panic>
  if(ip->type == T_DIR){
ffffffff80106cb2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106cb6:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80106cba:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff80106cbe:	75 21                	jne    ffffffff80106ce1 <sys_unlink+0x183>
    dp->nlink--;
ffffffff80106cc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106cc4:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80106cc8:	83 e8 01             	sub    $0x1,%eax
ffffffff80106ccb:	89 c2                	mov    %eax,%edx
ffffffff80106ccd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106cd1:	66 89 50 16          	mov    %dx,0x16(%rax)
    iupdate(dp);
ffffffff80106cd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106cd9:	48 89 c7             	mov    %rax,%rdi
ffffffff80106cdc:	e8 b9 af ff ff       	call   ffffffff80101c9a <iupdate>
  }
  iunlockput(dp);
ffffffff80106ce1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106ce5:	48 89 c7             	mov    %rax,%rdi
ffffffff80106ce8:	e8 73 b4 ff ff       	call   ffffffff80102160 <iunlockput>

  ip->nlink--;
ffffffff80106ced:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106cf1:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80106cf5:	83 e8 01             	sub    $0x1,%eax
ffffffff80106cf8:	89 c2                	mov    %eax,%edx
ffffffff80106cfa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106cfe:	66 89 50 16          	mov    %dx,0x16(%rax)
  iupdate(ip);
ffffffff80106d02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106d06:	48 89 c7             	mov    %rax,%rdi
ffffffff80106d09:	e8 8c af ff ff       	call   ffffffff80101c9a <iupdate>
  iunlockput(ip);
ffffffff80106d0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106d12:	48 89 c7             	mov    %rax,%rdi
ffffffff80106d15:	e8 46 b4 ff ff       	call   ffffffff80102160 <iunlockput>

  commit_trans();
ffffffff80106d1a:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106d1f:	e8 6b cd ff ff       	call   ffffffff80103a8f <commit_trans>

  return 0;
ffffffff80106d24:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106d29:	eb 1f                	jmp    ffffffff80106d4a <sys_unlink+0x1ec>
    goto bad;
ffffffff80106d2b:	90                   	nop
ffffffff80106d2c:	eb 01                	jmp    ffffffff80106d2f <sys_unlink+0x1d1>
    goto bad;
ffffffff80106d2e:	90                   	nop

bad:
  iunlockput(dp);
ffffffff80106d2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106d33:	48 89 c7             	mov    %rax,%rdi
ffffffff80106d36:	e8 25 b4 ff ff       	call   ffffffff80102160 <iunlockput>
  commit_trans();
ffffffff80106d3b:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106d40:	e8 4a cd ff ff       	call   ffffffff80103a8f <commit_trans>
  return -1;
ffffffff80106d45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffffffff80106d4a:	c9                   	leave
ffffffff80106d4b:	c3                   	ret

ffffffff80106d4c <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
ffffffff80106d4c:	55                   	push   %rbp
ffffffff80106d4d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106d50:	48 83 ec 50          	sub    $0x50,%rsp
ffffffff80106d54:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffffffff80106d58:	89 c8                	mov    %ecx,%eax
ffffffff80106d5a:	89 f1                	mov    %esi,%ecx
ffffffff80106d5c:	66 89 4d c4          	mov    %cx,-0x3c(%rbp)
ffffffff80106d60:	66 89 55 c0          	mov    %dx,-0x40(%rbp)
ffffffff80106d64:	66 89 45 bc          	mov    %ax,-0x44(%rbp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
ffffffff80106d68:	48 8d 55 de          	lea    -0x22(%rbp),%rdx
ffffffff80106d6c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80106d70:	48 89 d6             	mov    %rdx,%rsi
ffffffff80106d73:	48 89 c7             	mov    %rax,%rdi
ffffffff80106d76:	e8 0b be ff ff       	call   ffffffff80102b86 <nameiparent>
ffffffff80106d7b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80106d7f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80106d84:	75 0a                	jne    ffffffff80106d90 <create+0x44>
    return 0;
ffffffff80106d86:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106d8b:	e9 88 01 00 00       	jmp    ffffffff80106f18 <create+0x1cc>
  ilock(dp);
ffffffff80106d90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106d94:	48 89 c7             	mov    %rax,%rdi
ffffffff80106d97:	e8 fc b0 ff ff       	call   ffffffff80101e98 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
ffffffff80106d9c:	48 8d 55 ec          	lea    -0x14(%rbp),%rdx
ffffffff80106da0:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffffffff80106da4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106da8:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106dab:	48 89 c7             	mov    %rax,%rdi
ffffffff80106dae:	e8 ec b9 ff ff       	call   ffffffff8010279f <dirlookup>
ffffffff80106db3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80106db7:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80106dbc:	74 4c                	je     ffffffff80106e0a <create+0xbe>
    iunlockput(dp);
ffffffff80106dbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106dc2:	48 89 c7             	mov    %rax,%rdi
ffffffff80106dc5:	e8 96 b3 ff ff       	call   ffffffff80102160 <iunlockput>
    ilock(ip);
ffffffff80106dca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106dce:	48 89 c7             	mov    %rax,%rdi
ffffffff80106dd1:	e8 c2 b0 ff ff       	call   ffffffff80101e98 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
ffffffff80106dd6:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%rbp)
ffffffff80106ddb:	75 17                	jne    ffffffff80106df4 <create+0xa8>
ffffffff80106ddd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106de1:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80106de5:	66 83 f8 02          	cmp    $0x2,%ax
ffffffff80106de9:	75 09                	jne    ffffffff80106df4 <create+0xa8>
      return ip;
ffffffff80106deb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106def:	e9 24 01 00 00       	jmp    ffffffff80106f18 <create+0x1cc>
    iunlockput(ip);
ffffffff80106df4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106df8:	48 89 c7             	mov    %rax,%rdi
ffffffff80106dfb:	e8 60 b3 ff ff       	call   ffffffff80102160 <iunlockput>
    return 0;
ffffffff80106e00:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106e05:	e9 0e 01 00 00       	jmp    ffffffff80106f18 <create+0x1cc>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
ffffffff80106e0a:	0f bf 55 c4          	movswl -0x3c(%rbp),%edx
ffffffff80106e0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106e12:	8b 00                	mov    (%rax),%eax
ffffffff80106e14:	89 d6                	mov    %edx,%esi
ffffffff80106e16:	89 c7                	mov    %eax,%edi
ffffffff80106e18:	e8 96 ad ff ff       	call   ffffffff80101bb3 <ialloc>
ffffffff80106e1d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80106e21:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80106e26:	75 0c                	jne    ffffffff80106e34 <create+0xe8>
    panic("create: ialloc");
ffffffff80106e28:	48 c7 c7 dc a0 10 80 	mov    $0xffffffff8010a0dc,%rdi
ffffffff80106e2f:	e8 fb 9a ff ff       	call   ffffffff8010092f <panic>

  ilock(ip);
ffffffff80106e34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106e38:	48 89 c7             	mov    %rax,%rdi
ffffffff80106e3b:	e8 58 b0 ff ff       	call   ffffffff80101e98 <ilock>
  ip->major = major;
ffffffff80106e40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106e44:	0f b7 55 c0          	movzwl -0x40(%rbp),%edx
ffffffff80106e48:	66 89 50 12          	mov    %dx,0x12(%rax)
  ip->minor = minor;
ffffffff80106e4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106e50:	0f b7 55 bc          	movzwl -0x44(%rbp),%edx
ffffffff80106e54:	66 89 50 14          	mov    %dx,0x14(%rax)
  ip->nlink = 1;
ffffffff80106e58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106e5c:	66 c7 40 16 01 00    	movw   $0x1,0x16(%rax)
  iupdate(ip);
ffffffff80106e62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106e66:	48 89 c7             	mov    %rax,%rdi
ffffffff80106e69:	e8 2c ae ff ff       	call   ffffffff80101c9a <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
ffffffff80106e6e:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%rbp)
ffffffff80106e73:	75 69                	jne    ffffffff80106ede <create+0x192>
    dp->nlink++;  // for ".."
ffffffff80106e75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106e79:	0f b7 40 16          	movzwl 0x16(%rax),%eax
ffffffff80106e7d:	83 c0 01             	add    $0x1,%eax
ffffffff80106e80:	89 c2                	mov    %eax,%edx
ffffffff80106e82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106e86:	66 89 50 16          	mov    %dx,0x16(%rax)
    iupdate(dp);
ffffffff80106e8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106e8e:	48 89 c7             	mov    %rax,%rdi
ffffffff80106e91:	e8 04 ae ff ff       	call   ffffffff80101c9a <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
ffffffff80106e96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106e9a:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff80106e9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106ea1:	48 c7 c6 b6 a0 10 80 	mov    $0xffffffff8010a0b6,%rsi
ffffffff80106ea8:	48 89 c7             	mov    %rax,%rdi
ffffffff80106eab:	e8 c0 b9 ff ff       	call   ffffffff80102870 <dirlink>
ffffffff80106eb0:	85 c0                	test   %eax,%eax
ffffffff80106eb2:	78 1e                	js     ffffffff80106ed2 <create+0x186>
ffffffff80106eb4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106eb8:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff80106ebb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106ebf:	48 c7 c6 b8 a0 10 80 	mov    $0xffffffff8010a0b8,%rsi
ffffffff80106ec6:	48 89 c7             	mov    %rax,%rdi
ffffffff80106ec9:	e8 a2 b9 ff ff       	call   ffffffff80102870 <dirlink>
ffffffff80106ece:	85 c0                	test   %eax,%eax
ffffffff80106ed0:	79 0c                	jns    ffffffff80106ede <create+0x192>
      panic("create dots");
ffffffff80106ed2:	48 c7 c7 eb a0 10 80 	mov    $0xffffffff8010a0eb,%rdi
ffffffff80106ed9:	e8 51 9a ff ff       	call   ffffffff8010092f <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
ffffffff80106ede:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80106ee2:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff80106ee5:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffffffff80106ee9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106eed:	48 89 ce             	mov    %rcx,%rsi
ffffffff80106ef0:	48 89 c7             	mov    %rax,%rdi
ffffffff80106ef3:	e8 78 b9 ff ff       	call   ffffffff80102870 <dirlink>
ffffffff80106ef8:	85 c0                	test   %eax,%eax
ffffffff80106efa:	79 0c                	jns    ffffffff80106f08 <create+0x1bc>
    panic("create: dirlink");
ffffffff80106efc:	48 c7 c7 f7 a0 10 80 	mov    $0xffffffff8010a0f7,%rdi
ffffffff80106f03:	e8 27 9a ff ff       	call   ffffffff8010092f <panic>

  iunlockput(dp);
ffffffff80106f08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106f0c:	48 89 c7             	mov    %rax,%rdi
ffffffff80106f0f:	e8 4c b2 ff ff       	call   ffffffff80102160 <iunlockput>

  return ip;
ffffffff80106f14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffffffff80106f18:	c9                   	leave
ffffffff80106f19:	c3                   	ret

ffffffff80106f1a <sys_open>:

int
sys_open(void)
{
ffffffff80106f1a:	55                   	push   %rbp
ffffffff80106f1b:	48 89 e5             	mov    %rsp,%rbp
ffffffff80106f1e:	48 83 ec 30          	sub    $0x30,%rsp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
ffffffff80106f22:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffffffff80106f26:	48 89 c6             	mov    %rax,%rsi
ffffffff80106f29:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80106f2e:	e8 1d f6 ff ff       	call   ffffffff80106550 <argstr>
ffffffff80106f33:	85 c0                	test   %eax,%eax
ffffffff80106f35:	78 15                	js     ffffffff80106f4c <sys_open+0x32>
ffffffff80106f37:	48 8d 45 dc          	lea    -0x24(%rbp),%rax
ffffffff80106f3b:	48 89 c6             	mov    %rax,%rsi
ffffffff80106f3e:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff80106f43:	e8 38 f5 ff ff       	call   ffffffff80106480 <argint>
ffffffff80106f48:	85 c0                	test   %eax,%eax
ffffffff80106f4a:	79 0a                	jns    ffffffff80106f56 <sys_open+0x3c>
    return -1;
ffffffff80106f4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106f51:	e9 60 01 00 00       	jmp    ffffffff801070b6 <sys_open+0x19c>
  if(omode & O_CREATE){
ffffffff80106f56:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80106f59:	25 00 02 00 00       	and    $0x200,%eax
ffffffff80106f5e:	85 c0                	test   %eax,%eax
ffffffff80106f60:	74 44                	je     ffffffff80106fa6 <sys_open+0x8c>
    begin_trans();
ffffffff80106f62:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106f67:	e8 db ca ff ff       	call   ffffffff80103a47 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
ffffffff80106f6c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80106f70:	b9 00 00 00 00       	mov    $0x0,%ecx
ffffffff80106f75:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80106f7a:	be 02 00 00 00       	mov    $0x2,%esi
ffffffff80106f7f:	48 89 c7             	mov    %rax,%rdi
ffffffff80106f82:	e8 c5 fd ff ff       	call   ffffffff80106d4c <create>
ffffffff80106f87:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    commit_trans();
ffffffff80106f8b:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80106f90:	e8 fa ca ff ff       	call   ffffffff80103a8f <commit_trans>
    if(ip == 0)
ffffffff80106f95:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80106f9a:	75 62                	jne    ffffffff80106ffe <sys_open+0xe4>
      return -1;
ffffffff80106f9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106fa1:	e9 10 01 00 00       	jmp    ffffffff801070b6 <sys_open+0x19c>
  } else {
    if((ip = namei(path)) == 0)
ffffffff80106fa6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80106faa:	48 89 c7             	mov    %rax,%rdi
ffffffff80106fad:	e8 b1 bb ff ff       	call   ffffffff80102b63 <namei>
ffffffff80106fb2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80106fb6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80106fbb:	75 0a                	jne    ffffffff80106fc7 <sys_open+0xad>
      return -1;
ffffffff80106fbd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106fc2:	e9 ef 00 00 00       	jmp    ffffffff801070b6 <sys_open+0x19c>
    ilock(ip);
ffffffff80106fc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106fcb:	48 89 c7             	mov    %rax,%rdi
ffffffff80106fce:	e8 c5 ae ff ff       	call   ffffffff80101e98 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
ffffffff80106fd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106fd7:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff80106fdb:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff80106fdf:	75 1d                	jne    ffffffff80106ffe <sys_open+0xe4>
ffffffff80106fe1:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80106fe4:	85 c0                	test   %eax,%eax
ffffffff80106fe6:	74 16                	je     ffffffff80106ffe <sys_open+0xe4>
      iunlockput(ip);
ffffffff80106fe8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80106fec:	48 89 c7             	mov    %rax,%rdi
ffffffff80106fef:	e8 6c b1 ff ff       	call   ffffffff80102160 <iunlockput>
      return -1;
ffffffff80106ff4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80106ff9:	e9 b8 00 00 00       	jmp    ffffffff801070b6 <sys_open+0x19c>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
ffffffff80106ffe:	e8 8d a4 ff ff       	call   ffffffff80101490 <filealloc>
ffffffff80107003:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffffffff80107007:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff8010700c:	74 15                	je     ffffffff80107023 <sys_open+0x109>
ffffffff8010700e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107012:	48 89 c7             	mov    %rax,%rdi
ffffffff80107015:	e8 e5 f6 ff ff       	call   ffffffff801066ff <fdalloc>
ffffffff8010701a:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffffffff8010701d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffffffff80107021:	79 26                	jns    ffffffff80107049 <sys_open+0x12f>
    if(f)
ffffffff80107023:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80107028:	74 0c                	je     ffffffff80107036 <sys_open+0x11c>
      fileclose(f);
ffffffff8010702a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010702e:	48 89 c7             	mov    %rax,%rdi
ffffffff80107031:	e8 17 a5 ff ff       	call   ffffffff8010154d <fileclose>
    iunlockput(ip);
ffffffff80107036:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010703a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010703d:	e8 1e b1 ff ff       	call   ffffffff80102160 <iunlockput>
    return -1;
ffffffff80107042:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107047:	eb 6d                	jmp    ffffffff801070b6 <sys_open+0x19c>
  }
  iunlock(ip);
ffffffff80107049:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010704d:	48 89 c7             	mov    %rax,%rdi
ffffffff80107050:	e8 b4 af ff ff       	call   ffffffff80102009 <iunlock>

  f->type = FD_INODE;
ffffffff80107055:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107059:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  f->ip = ip;
ffffffff8010705f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107063:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80107067:	48 89 50 18          	mov    %rdx,0x18(%rax)
  f->off = 0;
ffffffff8010706b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010706f:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
  f->readable = !(omode & O_WRONLY);
ffffffff80107076:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80107079:	83 e0 01             	and    $0x1,%eax
ffffffff8010707c:	85 c0                	test   %eax,%eax
ffffffff8010707e:	0f 94 c0             	sete   %al
ffffffff80107081:	89 c2                	mov    %eax,%edx
ffffffff80107083:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107087:	88 50 08             	mov    %dl,0x8(%rax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
ffffffff8010708a:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff8010708d:	83 e0 01             	and    $0x1,%eax
ffffffff80107090:	85 c0                	test   %eax,%eax
ffffffff80107092:	75 0a                	jne    ffffffff8010709e <sys_open+0x184>
ffffffff80107094:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80107097:	83 e0 02             	and    $0x2,%eax
ffffffff8010709a:	85 c0                	test   %eax,%eax
ffffffff8010709c:	74 07                	je     ffffffff801070a5 <sys_open+0x18b>
ffffffff8010709e:	b8 01 00 00 00       	mov    $0x1,%eax
ffffffff801070a3:	eb 05                	jmp    ffffffff801070aa <sys_open+0x190>
ffffffff801070a5:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801070aa:	89 c2                	mov    %eax,%edx
ffffffff801070ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801070b0:	88 50 09             	mov    %dl,0x9(%rax)
  return fd;
ffffffff801070b3:	8b 45 ec             	mov    -0x14(%rbp),%eax
}
ffffffff801070b6:	c9                   	leave
ffffffff801070b7:	c3                   	ret

ffffffff801070b8 <sys_mkdir>:

int
sys_mkdir(void)
{
ffffffff801070b8:	55                   	push   %rbp
ffffffff801070b9:	48 89 e5             	mov    %rsp,%rbp
ffffffff801070bc:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_trans();
ffffffff801070c0:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801070c5:	e8 7d c9 ff ff       	call   ffffffff80103a47 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
ffffffff801070ca:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff801070ce:	48 89 c6             	mov    %rax,%rsi
ffffffff801070d1:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801070d6:	e8 75 f4 ff ff       	call   ffffffff80106550 <argstr>
ffffffff801070db:	85 c0                	test   %eax,%eax
ffffffff801070dd:	78 26                	js     ffffffff80107105 <sys_mkdir+0x4d>
ffffffff801070df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801070e3:	b9 00 00 00 00       	mov    $0x0,%ecx
ffffffff801070e8:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff801070ed:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff801070f2:	48 89 c7             	mov    %rax,%rdi
ffffffff801070f5:	e8 52 fc ff ff       	call   ffffffff80106d4c <create>
ffffffff801070fa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801070fe:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80107103:	75 11                	jne    ffffffff80107116 <sys_mkdir+0x5e>
    commit_trans();
ffffffff80107105:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010710a:	e8 80 c9 ff ff       	call   ffffffff80103a8f <commit_trans>
    return -1;
ffffffff8010710f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107114:	eb 1b                	jmp    ffffffff80107131 <sys_mkdir+0x79>
  }
  iunlockput(ip);
ffffffff80107116:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010711a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010711d:	e8 3e b0 ff ff       	call   ffffffff80102160 <iunlockput>
  commit_trans();
ffffffff80107122:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107127:	e8 63 c9 ff ff       	call   ffffffff80103a8f <commit_trans>
  return 0;
ffffffff8010712c:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80107131:	c9                   	leave
ffffffff80107132:	c3                   	ret

ffffffff80107133 <sys_mknod>:

int
sys_mknod(void)
{
ffffffff80107133:	55                   	push   %rbp
ffffffff80107134:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107137:	48 83 ec 20          	sub    $0x20,%rsp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
ffffffff8010713b:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107140:	e8 02 c9 ff ff       	call   ffffffff80103a47 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
ffffffff80107145:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff80107149:	48 89 c6             	mov    %rax,%rsi
ffffffff8010714c:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80107151:	e8 fa f3 ff ff       	call   ffffffff80106550 <argstr>
ffffffff80107156:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80107159:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff8010715d:	78 52                	js     ffffffff801071b1 <sys_mknod+0x7e>
     argint(1, &major) < 0 ||
ffffffff8010715f:	48 8d 45 e4          	lea    -0x1c(%rbp),%rax
ffffffff80107163:	48 89 c6             	mov    %rax,%rsi
ffffffff80107166:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff8010716b:	e8 10 f3 ff ff       	call   ffffffff80106480 <argint>
  if((len=argstr(0, &path)) < 0 ||
ffffffff80107170:	85 c0                	test   %eax,%eax
ffffffff80107172:	78 3d                	js     ffffffff801071b1 <sys_mknod+0x7e>
     argint(2, &minor) < 0 ||
ffffffff80107174:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffffffff80107178:	48 89 c6             	mov    %rax,%rsi
ffffffff8010717b:	bf 02 00 00 00       	mov    $0x2,%edi
ffffffff80107180:	e8 fb f2 ff ff       	call   ffffffff80106480 <argint>
     argint(1, &major) < 0 ||
ffffffff80107185:	85 c0                	test   %eax,%eax
ffffffff80107187:	78 28                	js     ffffffff801071b1 <sys_mknod+0x7e>
     (ip = create(path, T_DEV, major, minor)) == 0){
ffffffff80107189:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffffffff8010718c:	0f bf c8             	movswl %ax,%ecx
ffffffff8010718f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80107192:	0f bf d0             	movswl %ax,%edx
ffffffff80107195:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80107199:	be 03 00 00 00       	mov    $0x3,%esi
ffffffff8010719e:	48 89 c7             	mov    %rax,%rdi
ffffffff801071a1:	e8 a6 fb ff ff       	call   ffffffff80106d4c <create>
ffffffff801071a6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
     argint(2, &minor) < 0 ||
ffffffff801071aa:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff801071af:	75 11                	jne    ffffffff801071c2 <sys_mknod+0x8f>
    commit_trans();
ffffffff801071b1:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801071b6:	e8 d4 c8 ff ff       	call   ffffffff80103a8f <commit_trans>
    return -1;
ffffffff801071bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801071c0:	eb 1b                	jmp    ffffffff801071dd <sys_mknod+0xaa>
  }
  iunlockput(ip);
ffffffff801071c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801071c6:	48 89 c7             	mov    %rax,%rdi
ffffffff801071c9:	e8 92 af ff ff       	call   ffffffff80102160 <iunlockput>
  commit_trans();
ffffffff801071ce:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801071d3:	e8 b7 c8 ff ff       	call   ffffffff80103a8f <commit_trans>
  return 0;
ffffffff801071d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801071dd:	c9                   	leave
ffffffff801071de:	c3                   	ret

ffffffff801071df <sys_chdir>:

int
sys_chdir(void)
{
ffffffff801071df:	55                   	push   %rbp
ffffffff801071e0:	48 89 e5             	mov    %rsp,%rbp
ffffffff801071e3:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
ffffffff801071e7:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff801071eb:	48 89 c6             	mov    %rax,%rsi
ffffffff801071ee:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801071f3:	e8 58 f3 ff ff       	call   ffffffff80106550 <argstr>
ffffffff801071f8:	85 c0                	test   %eax,%eax
ffffffff801071fa:	78 17                	js     ffffffff80107213 <sys_chdir+0x34>
ffffffff801071fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107200:	48 89 c7             	mov    %rax,%rdi
ffffffff80107203:	e8 5b b9 ff ff       	call   ffffffff80102b63 <namei>
ffffffff80107208:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff8010720c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80107211:	75 07                	jne    ffffffff8010721a <sys_chdir+0x3b>
    return -1;
ffffffff80107213:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107218:	eb 6e                	jmp    ffffffff80107288 <sys_chdir+0xa9>
  ilock(ip);
ffffffff8010721a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010721e:	48 89 c7             	mov    %rax,%rdi
ffffffff80107221:	e8 72 ac ff ff       	call   ffffffff80101e98 <ilock>
  if(ip->type != T_DIR){
ffffffff80107226:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010722a:	0f b7 40 10          	movzwl 0x10(%rax),%eax
ffffffff8010722e:	66 83 f8 01          	cmp    $0x1,%ax
ffffffff80107232:	74 13                	je     ffffffff80107247 <sys_chdir+0x68>
    iunlockput(ip);
ffffffff80107234:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107238:	48 89 c7             	mov    %rax,%rdi
ffffffff8010723b:	e8 20 af ff ff       	call   ffffffff80102160 <iunlockput>
    return -1;
ffffffff80107240:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107245:	eb 41                	jmp    ffffffff80107288 <sys_chdir+0xa9>
  }
  iunlock(ip);
ffffffff80107247:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010724b:	48 89 c7             	mov    %rax,%rdi
ffffffff8010724e:	e8 b6 ad ff ff       	call   ffffffff80102009 <iunlock>
  iput(proc->cwd);
ffffffff80107253:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010725a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010725e:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffffffff80107265:	48 89 c7             	mov    %rax,%rdi
ffffffff80107268:	e8 0e ae ff ff       	call   ffffffff8010207b <iput>
  proc->cwd = ip;
ffffffff8010726d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107274:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107278:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff8010727c:	48 89 90 c8 00 00 00 	mov    %rdx,0xc8(%rax)
  return 0;
ffffffff80107283:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80107288:	c9                   	leave
ffffffff80107289:	c3                   	ret

ffffffff8010728a <sys_exec>:

int
sys_exec(void)
{
ffffffff8010728a:	55                   	push   %rbp
ffffffff8010728b:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010728e:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
  char *path, *argv[MAXARG];
  int i;
  uintp uargv, uarg;

  if(argstr(0, &path) < 0 || arguintp(1, &uargv) < 0){
ffffffff80107295:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff80107299:	48 89 c6             	mov    %rax,%rsi
ffffffff8010729c:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801072a1:	e8 aa f2 ff ff       	call   ffffffff80106550 <argstr>
ffffffff801072a6:	85 c0                	test   %eax,%eax
ffffffff801072a8:	78 18                	js     ffffffff801072c2 <sys_exec+0x38>
ffffffff801072aa:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
ffffffff801072b1:	48 89 c6             	mov    %rax,%rsi
ffffffff801072b4:	bf 01 00 00 00       	mov    $0x1,%edi
ffffffff801072b9:	e8 ea f1 ff ff       	call   ffffffff801064a8 <arguintp>
ffffffff801072be:	85 c0                	test   %eax,%eax
ffffffff801072c0:	79 0a                	jns    ffffffff801072cc <sys_exec+0x42>
    return -1;
ffffffff801072c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801072c7:	e9 d6 00 00 00       	jmp    ffffffff801073a2 <sys_exec+0x118>
  }
  memset(argv, 0, sizeof(argv));
ffffffff801072cc:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffffffff801072d3:	ba 00 01 00 00       	mov    $0x100,%edx
ffffffff801072d8:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801072dd:	48 89 c7             	mov    %rax,%rdi
ffffffff801072e0:	e8 6e ec ff ff       	call   ffffffff80105f53 <memset>
  for(i=0;; i++){
ffffffff801072e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    if(i >= NELEM(argv))
ffffffff801072ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801072ef:	83 f8 1f             	cmp    $0x1f,%eax
ffffffff801072f2:	76 0a                	jbe    ffffffff801072fe <sys_exec+0x74>
      return -1;
ffffffff801072f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801072f9:	e9 a4 00 00 00       	jmp    ffffffff801073a2 <sys_exec+0x118>
    if(fetchuintp(uargv+sizeof(uintp)*i, &uarg) < 0)
ffffffff801072fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80107301:	48 98                	cltq
ffffffff80107303:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff8010730a:	00 
ffffffff8010730b:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
ffffffff80107312:	48 01 c2             	add    %rax,%rdx
ffffffff80107315:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
ffffffff8010731c:	48 89 c6             	mov    %rax,%rsi
ffffffff8010731f:	48 89 d7             	mov    %rdx,%rdi
ffffffff80107322:	e8 d4 ef ff ff       	call   ffffffff801062fb <fetchuintp>
ffffffff80107327:	85 c0                	test   %eax,%eax
ffffffff80107329:	79 07                	jns    ffffffff80107332 <sys_exec+0xa8>
      return -1;
ffffffff8010732b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107330:	eb 70                	jmp    ffffffff801073a2 <sys_exec+0x118>
    if(uarg == 0){
ffffffff80107332:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffffffff80107339:	48 85 c0             	test   %rax,%rax
ffffffff8010733c:	75 2a                	jne    ffffffff80107368 <sys_exec+0xde>
      argv[i] = 0;
ffffffff8010733e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80107341:	48 98                	cltq
ffffffff80107343:	48 c7 84 c5 f0 fe ff 	movq   $0x0,-0x110(%rbp,%rax,8)
ffffffff8010734a:	ff 00 00 00 00 
      break;
ffffffff8010734f:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
ffffffff80107350:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107354:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffffffff8010735b:	48 89 d6             	mov    %rdx,%rsi
ffffffff8010735e:	48 89 c7             	mov    %rax,%rdi
ffffffff80107361:	e8 0f 9c ff ff       	call   ffffffff80100f75 <exec>
ffffffff80107366:	eb 3a                	jmp    ffffffff801073a2 <sys_exec+0x118>
    if(fetchstr(uarg, &argv[i]) < 0)
ffffffff80107368:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffffffff8010736f:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80107372:	48 63 d2             	movslq %edx,%rdx
ffffffff80107375:	48 c1 e2 03          	shl    $0x3,%rdx
ffffffff80107379:	48 01 c2             	add    %rax,%rdx
ffffffff8010737c:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffffffff80107383:	48 89 d6             	mov    %rdx,%rsi
ffffffff80107386:	48 89 c7             	mov    %rax,%rdi
ffffffff80107389:	e8 c8 ef ff ff       	call   ffffffff80106356 <fetchstr>
ffffffff8010738e:	85 c0                	test   %eax,%eax
ffffffff80107390:	79 07                	jns    ffffffff80107399 <sys_exec+0x10f>
      return -1;
ffffffff80107392:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107397:	eb 09                	jmp    ffffffff801073a2 <sys_exec+0x118>
  for(i=0;; i++){
ffffffff80107399:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(i >= NELEM(argv))
ffffffff8010739d:	e9 4a ff ff ff       	jmp    ffffffff801072ec <sys_exec+0x62>
}
ffffffff801073a2:	c9                   	leave
ffffffff801073a3:	c3                   	ret

ffffffff801073a4 <sys_pipe>:

int
sys_pipe(void)
{
ffffffff801073a4:	55                   	push   %rbp
ffffffff801073a5:	48 89 e5             	mov    %rsp,%rbp
ffffffff801073a8:	48 83 ec 20          	sub    $0x20,%rsp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
ffffffff801073ac:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff801073b0:	ba 08 00 00 00       	mov    $0x8,%edx
ffffffff801073b5:	48 89 c6             	mov    %rax,%rsi
ffffffff801073b8:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801073bd:	e8 0d f1 ff ff       	call   ffffffff801064cf <argptr>
ffffffff801073c2:	85 c0                	test   %eax,%eax
ffffffff801073c4:	79 0a                	jns    ffffffff801073d0 <sys_pipe+0x2c>
    return -1;
ffffffff801073c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801073cb:	e9 b0 00 00 00       	jmp    ffffffff80107480 <sys_pipe+0xdc>
  if(pipealloc(&rf, &wf) < 0)
ffffffff801073d0:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffffffff801073d4:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff801073d8:	48 89 d6             	mov    %rdx,%rsi
ffffffff801073db:	48 89 c7             	mov    %rax,%rdi
ffffffff801073de:	e8 66 d5 ff ff       	call   ffffffff80104949 <pipealloc>
ffffffff801073e3:	85 c0                	test   %eax,%eax
ffffffff801073e5:	79 0a                	jns    ffffffff801073f1 <sys_pipe+0x4d>
    return -1;
ffffffff801073e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801073ec:	e9 8f 00 00 00       	jmp    ffffffff80107480 <sys_pipe+0xdc>
  fd0 = -1;
ffffffff801073f1:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
ffffffff801073f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801073fc:	48 89 c7             	mov    %rax,%rdi
ffffffff801073ff:	e8 fb f2 ff ff       	call   ffffffff801066ff <fdalloc>
ffffffff80107404:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffffffff80107407:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff8010740b:	78 15                	js     ffffffff80107422 <sys_pipe+0x7e>
ffffffff8010740d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80107411:	48 89 c7             	mov    %rax,%rdi
ffffffff80107414:	e8 e6 f2 ff ff       	call   ffffffff801066ff <fdalloc>
ffffffff80107419:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffffffff8010741c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffffffff80107420:	79 43                	jns    ffffffff80107465 <sys_pipe+0xc1>
    if(fd0 >= 0)
ffffffff80107422:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffffffff80107426:	78 1e                	js     ffffffff80107446 <sys_pipe+0xa2>
      proc->ofile[fd0] = 0;
ffffffff80107428:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff8010742f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107433:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80107436:	48 63 d2             	movslq %edx,%rdx
ffffffff80107439:	48 83 c2 08          	add    $0x8,%rdx
ffffffff8010743d:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffffffff80107444:	00 00 
    fileclose(rf);
ffffffff80107446:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010744a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010744d:	e8 fb a0 ff ff       	call   ffffffff8010154d <fileclose>
    fileclose(wf);
ffffffff80107452:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80107456:	48 89 c7             	mov    %rax,%rdi
ffffffff80107459:	e8 ef a0 ff ff       	call   ffffffff8010154d <fileclose>
    return -1;
ffffffff8010745e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107463:	eb 1b                	jmp    ffffffff80107480 <sys_pipe+0xdc>
  }
  fd[0] = fd0;
ffffffff80107465:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107469:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff8010746c:	89 10                	mov    %edx,(%rax)
  fd[1] = fd1;
ffffffff8010746e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107472:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffffffff80107476:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffffffff80107479:	89 02                	mov    %eax,(%rdx)
  return 0;
ffffffff8010747b:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80107480:	c9                   	leave
ffffffff80107481:	c3                   	ret

ffffffff80107482 <outw>:
{
ffffffff80107482:	55                   	push   %rbp
ffffffff80107483:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107486:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff8010748a:	89 fa                	mov    %edi,%edx
ffffffff8010748c:	89 f0                	mov    %esi,%eax
ffffffff8010748e:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff80107492:	66 89 45 f8          	mov    %ax,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff80107496:	0f b7 45 f8          	movzwl -0x8(%rbp),%eax
ffffffff8010749a:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff8010749e:	66 ef                	out    %ax,(%dx)
}
ffffffff801074a0:	90                   	nop
ffffffff801074a1:	c9                   	leave
ffffffff801074a2:	c3                   	ret

ffffffff801074a3 <sys_fork>:

extern struct ptable ptable;

int
sys_fork(void)
{
ffffffff801074a3:	55                   	push   %rbp
ffffffff801074a4:	48 89 e5             	mov    %rsp,%rbp
  return fork();
ffffffff801074a7:	e8 4e dc ff ff       	call   ffffffff801050fa <fork>
}
ffffffff801074ac:	5d                   	pop    %rbp
ffffffff801074ad:	c3                   	ret

ffffffff801074ae <sys_exit>:

int
sys_exit(void)
{
ffffffff801074ae:	55                   	push   %rbp
ffffffff801074af:	48 89 e5             	mov    %rsp,%rbp
  exit();
ffffffff801074b2:	e8 cb de ff ff       	call   ffffffff80105382 <exit>
  return 0;  // not reached
ffffffff801074b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801074bc:	5d                   	pop    %rbp
ffffffff801074bd:	c3                   	ret

ffffffff801074be <sys_wait>:

int
sys_wait(void)
{
ffffffff801074be:	55                   	push   %rbp
ffffffff801074bf:	48 89 e5             	mov    %rsp,%rbp
  return wait();
ffffffff801074c2:	e8 41 e0 ff ff       	call   ffffffff80105508 <wait>
}
ffffffff801074c7:	5d                   	pop    %rbp
ffffffff801074c8:	c3                   	ret

ffffffff801074c9 <sys_kill>:

int
sys_kill(void)
{
ffffffff801074c9:	55                   	push   %rbp
ffffffff801074ca:	48 89 e5             	mov    %rsp,%rbp
ffffffff801074cd:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  if(argint(0, &pid) < 0)
ffffffff801074d1:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffffffff801074d5:	48 89 c6             	mov    %rax,%rsi
ffffffff801074d8:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff801074dd:	e8 9e ef ff ff       	call   ffffffff80106480 <argint>
ffffffff801074e2:	85 c0                	test   %eax,%eax
ffffffff801074e4:	79 07                	jns    ffffffff801074ed <sys_kill+0x24>
    return -1;
ffffffff801074e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801074eb:	eb 0a                	jmp    ffffffff801074f7 <sys_kill+0x2e>
  return kill(pid);
ffffffff801074ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801074f0:	89 c7                	mov    %eax,%edi
ffffffff801074f2:	e8 af e4 ff ff       	call   ffffffff801059a6 <kill>
}
ffffffff801074f7:	c9                   	leave
ffffffff801074f8:	c3                   	ret

ffffffff801074f9 <sys_getpinfo>:

int sys_getpinfo(void) 
{
ffffffff801074f9:	55                   	push   %rbp
ffffffff801074fa:	48 89 e5             	mov    %rsp,%rbp
ffffffff801074fd:	48 83 ec 20          	sub    $0x20,%rsp
    struct pstat *pstat;

    argptr(0, (void*)&pstat, sizeof(*pstat));
ffffffff80107501:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffffffff80107505:	ba 00 04 00 00       	mov    $0x400,%edx
ffffffff8010750a:	48 89 c6             	mov    %rax,%rsi
ffffffff8010750d:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80107512:	e8 b8 ef ff ff       	call   ffffffff801064cf <argptr>

    if (pstat == 0) {
ffffffff80107517:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010751b:	48 85 c0             	test   %rax,%rax
ffffffff8010751e:	75 0a                	jne    ffffffff8010752a <sys_getpinfo+0x31>
        return -1;
ffffffff80107520:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107525:	e9 ca 00 00 00       	jmp    ffffffff801075f4 <sys_getpinfo+0xfb>
    }

    acquire(&ptable.lock);
ffffffff8010752a:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff80107531:	e8 ad e6 ff ff       	call   ffffffff80105be3 <acquire>
    struct proc *p;
    int i;
    for (p = ptable.proc; p != &(ptable.proc[NPROC]); p++) 
ffffffff80107536:	48 c7 45 f8 68 04 11 	movq   $0xffffffff80110468,-0x8(%rbp)
ffffffff8010753d:	80 
ffffffff8010753e:	e9 92 00 00 00       	jmp    ffffffff801075d5 <sys_getpinfo+0xdc>
    {
        i = p - ptable.proc;
ffffffff80107543:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107547:	48 2d 68 04 11 80    	sub    $0xffffffff80110468,%rax
ffffffff8010754d:	48 c1 f8 04          	sar    $0x4,%rax
ffffffff80107551:	48 89 c2             	mov    %rax,%rdx
ffffffff80107554:	48 b8 ef ee ee ee ee 	movabs $0xeeeeeeeeeeeeeeef,%rax
ffffffff8010755b:	ee ee ee 
ffffffff8010755e:	48 0f af c2          	imul   %rdx,%rax
ffffffff80107562:	89 45 f4             	mov    %eax,-0xc(%rbp)
        /* if (p->state == UNUSED) { */
        /*     pstat->inuse[i] = 0; */
        /* } else { */
        /*     pstat->inuse[i] = 1; */
        /* } */
        pstat->inuse[i] = p->inuse;
ffffffff80107565:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80107569:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff8010756d:	8b 8a e0 00 00 00    	mov    0xe0(%rdx),%ecx
ffffffff80107573:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffffffff80107576:	48 63 d2             	movslq %edx,%rdx
ffffffff80107579:	89 0c 90             	mov    %ecx,(%rax,%rdx,4)
        pstat->pid[i] = p->pid;
ffffffff8010757c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80107580:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80107584:	8b 52 1c             	mov    0x1c(%rdx),%edx
ffffffff80107587:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffffffff8010758a:	48 63 c9             	movslq %ecx,%rcx
ffffffff8010758d:	48 83 e9 80          	sub    $0xffffffffffffff80,%rcx
ffffffff80107591:	89 14 88             	mov    %edx,(%rax,%rcx,4)
        pstat->ticks[i] = p->ticks;
ffffffff80107594:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80107598:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff8010759c:	8b 92 e4 00 00 00    	mov    0xe4(%rdx),%edx
ffffffff801075a2:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffffffff801075a5:	48 63 c9             	movslq %ecx,%rcx
ffffffff801075a8:	48 81 c1 c0 00 00 00 	add    $0xc0,%rcx
ffffffff801075af:	89 14 88             	mov    %edx,(%rax,%rcx,4)
        pstat->tickets[i] = p->tickets;
ffffffff801075b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801075b6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801075ba:	8b 92 e8 00 00 00    	mov    0xe8(%rdx),%edx
ffffffff801075c0:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffffffff801075c3:	48 63 c9             	movslq %ecx,%rcx
ffffffff801075c6:	48 83 c1 40          	add    $0x40,%rcx
ffffffff801075ca:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    for (p = ptable.proc; p != &(ptable.proc[NPROC]); p++) 
ffffffff801075cd:	48 81 45 f8 f0 00 00 	addq   $0xf0,-0x8(%rbp)
ffffffff801075d4:	00 
ffffffff801075d5:	48 81 7d f8 68 40 11 	cmpq   $0xffffffff80114068,-0x8(%rbp)
ffffffff801075dc:	80 
ffffffff801075dd:	0f 85 60 ff ff ff    	jne    ffffffff80107543 <sys_getpinfo+0x4a>
    }
    release(&ptable.lock);
ffffffff801075e3:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801075ea:	e8 cb e6 ff ff       	call   ffffffff80105cba <release>
    return 0;
ffffffff801075ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801075f4:	c9                   	leave
ffffffff801075f5:	c3                   	ret

ffffffff801075f6 <sys_getpid>:

int
sys_getpid(void)
{
ffffffff801075f6:	55                   	push   %rbp
ffffffff801075f7:	48 89 e5             	mov    %rsp,%rbp
  return proc->pid;
ffffffff801075fa:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107601:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107605:	8b 40 1c             	mov    0x1c(%rax),%eax
}
ffffffff80107608:	5d                   	pop    %rbp
ffffffff80107609:	c3                   	ret

ffffffff8010760a <sys_sbrk>:

uintp
sys_sbrk(void)
{
ffffffff8010760a:	55                   	push   %rbp
ffffffff8010760b:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010760e:	48 83 ec 10          	sub    $0x10,%rsp
  uintp addr;
  uintp n;

  if(arguintp(0, &n) < 0)
ffffffff80107612:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffffffff80107616:	48 89 c6             	mov    %rax,%rsi
ffffffff80107619:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff8010761e:	e8 85 ee ff ff       	call   ffffffff801064a8 <arguintp>
ffffffff80107623:	85 c0                	test   %eax,%eax
ffffffff80107625:	79 09                	jns    ffffffff80107630 <sys_sbrk+0x26>
    return -1;
ffffffff80107627:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffffffff8010762e:	eb 2e                	jmp    ffffffff8010765e <sys_sbrk+0x54>
  addr = proc->sz;
ffffffff80107630:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107637:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010763b:	48 8b 00             	mov    (%rax),%rax
ffffffff8010763e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(growproc(n) < 0)
ffffffff80107642:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80107646:	89 c7                	mov    %eax,%edi
ffffffff80107648:	e8 ef d9 ff ff       	call   ffffffff8010503c <growproc>
ffffffff8010764d:	85 c0                	test   %eax,%eax
ffffffff8010764f:	79 09                	jns    ffffffff8010765a <sys_sbrk+0x50>
    return -1;
ffffffff80107651:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffffffff80107658:	eb 04                	jmp    ffffffff8010765e <sys_sbrk+0x54>
  return addr;
ffffffff8010765a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff8010765e:	c9                   	leave
ffffffff8010765f:	c3                   	ret

ffffffff80107660 <sys_sleep>:

int
sys_sleep(void)
{
ffffffff80107660:	55                   	push   %rbp
ffffffff80107661:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107664:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
ffffffff80107668:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffffffff8010766c:	48 89 c6             	mov    %rax,%rsi
ffffffff8010766f:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80107674:	e8 07 ee ff ff       	call   ffffffff80106480 <argint>
ffffffff80107679:	85 c0                	test   %eax,%eax
ffffffff8010767b:	79 07                	jns    ffffffff80107684 <sys_sleep+0x24>
    return -1;
ffffffff8010767d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107682:	eb 70                	jmp    ffffffff801076f4 <sys_sleep+0x94>
  acquire(&tickslock);
ffffffff80107684:	48 c7 c7 00 49 11 80 	mov    $0xffffffff80114900,%rdi
ffffffff8010768b:	e8 53 e5 ff ff       	call   ffffffff80105be3 <acquire>
  ticks0 = ticks;
ffffffff80107690:	8b 05 d2 d2 00 00    	mov    0xd2d2(%rip),%eax        # ffffffff80114968 <ticks>
ffffffff80107696:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while(ticks - ticks0 < n){
ffffffff80107699:	eb 38                	jmp    ffffffff801076d3 <sys_sleep+0x73>
    if(proc->killed){
ffffffff8010769b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801076a2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801076a6:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff801076a9:	85 c0                	test   %eax,%eax
ffffffff801076ab:	74 13                	je     ffffffff801076c0 <sys_sleep+0x60>
      release(&tickslock);
ffffffff801076ad:	48 c7 c7 00 49 11 80 	mov    $0xffffffff80114900,%rdi
ffffffff801076b4:	e8 01 e6 ff ff       	call   ffffffff80105cba <release>
      return -1;
ffffffff801076b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff801076be:	eb 34                	jmp    ffffffff801076f4 <sys_sleep+0x94>
    }
    sleep(&ticks, &tickslock);
ffffffff801076c0:	48 c7 c6 00 49 11 80 	mov    $0xffffffff80114900,%rsi
ffffffff801076c7:	48 c7 c7 68 49 11 80 	mov    $0xffffffff80114968,%rdi
ffffffff801076ce:	e8 8c e1 ff ff       	call   ffffffff8010585f <sleep>
  while(ticks - ticks0 < n){
ffffffff801076d3:	8b 05 8f d2 00 00    	mov    0xd28f(%rip),%eax        # ffffffff80114968 <ticks>
ffffffff801076d9:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffffffff801076dc:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffffffff801076df:	39 d0                	cmp    %edx,%eax
ffffffff801076e1:	72 b8                	jb     ffffffff8010769b <sys_sleep+0x3b>
  }
  release(&tickslock);
ffffffff801076e3:	48 c7 c7 00 49 11 80 	mov    $0xffffffff80114900,%rdi
ffffffff801076ea:	e8 cb e5 ff ff       	call   ffffffff80105cba <release>
  return 0;
ffffffff801076ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff801076f4:	c9                   	leave
ffffffff801076f5:	c3                   	ret

ffffffff801076f6 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
ffffffff801076f6:	55                   	push   %rbp
ffffffff801076f7:	48 89 e5             	mov    %rsp,%rbp
ffffffff801076fa:	48 83 ec 10          	sub    $0x10,%rsp
  uint xticks;
  
  acquire(&tickslock);
ffffffff801076fe:	48 c7 c7 00 49 11 80 	mov    $0xffffffff80114900,%rdi
ffffffff80107705:	e8 d9 e4 ff ff       	call   ffffffff80105be3 <acquire>
  xticks = ticks;
ffffffff8010770a:	8b 05 58 d2 00 00    	mov    0xd258(%rip),%eax        # ffffffff80114968 <ticks>
ffffffff80107710:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&tickslock);
ffffffff80107713:	48 c7 c7 00 49 11 80 	mov    $0xffffffff80114900,%rdi
ffffffff8010771a:	e8 9b e5 ff ff       	call   ffffffff80105cba <release>
  return xticks;
ffffffff8010771f:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffffffff80107722:	c9                   	leave
ffffffff80107723:	c3                   	ret

ffffffff80107724 <sys_getfavnum>:

int sys_getfavnum(void){
ffffffff80107724:	55                   	push   %rbp
ffffffff80107725:	48 89 e5             	mov    %rsp,%rbp
  return 7;
ffffffff80107728:	b8 07 00 00 00       	mov    $0x7,%eax
}
ffffffff8010772d:	5d                   	pop    %rbp
ffffffff8010772e:	c3                   	ret

ffffffff8010772f <sys_shutdown>:

void sys_shutdown(void){
ffffffff8010772f:	55                   	push   %rbp
ffffffff80107730:	48 89 e5             	mov    %rsp,%rbp
  outw(0x604, 0x2000); //Γράφουμε στην διεύθυνση θύρας I/O 0x604 την τιμή 0x2000
ffffffff80107733:	be 00 20 00 00       	mov    $0x2000,%esi
ffffffff80107738:	bf 04 06 00 00       	mov    $0x604,%edi
ffffffff8010773d:	e8 40 fd ff ff       	call   ffffffff80107482 <outw>
  return;
ffffffff80107742:	90                   	nop
}
ffffffff80107743:	5d                   	pop    %rbp
ffffffff80107744:	c3                   	ret

ffffffff80107745 <sys_getcount>:

int sys_getcount(void){
ffffffff80107745:	55                   	push   %rbp
ffffffff80107746:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107749:	48 83 ec 10          	sub    $0x10,%rsp
  int syscall;
  if(argint(0, &syscall) < 0) return -1; //Αν δεν υπάρχει όρισμα για το syscall επιστρέφουμε -1. Διαφορετικά το βάζουμε στην syscall
ffffffff8010774d:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffffffff80107751:	48 89 c6             	mov    %rax,%rsi
ffffffff80107754:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff80107759:	e8 22 ed ff ff       	call   ffffffff80106480 <argint>
ffffffff8010775e:	85 c0                	test   %eax,%eax
ffffffff80107760:	79 07                	jns    ffffffff80107769 <sys_getcount+0x24>
ffffffff80107762:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107767:	eb 47                	jmp    ffffffff801077b0 <sys_getcount+0x6b>
  cprintf("%d\n", syscall);
ffffffff80107769:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff8010776c:	89 c6                	mov    %eax,%esi
ffffffff8010776e:	48 c7 c7 07 a1 10 80 	mov    $0xffffffff8010a107,%rdi
ffffffff80107775:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010777a:	e8 25 8e ff ff       	call   ffffffff801005a4 <cprintf>
  cprintf("%d\n", syscallsCount[syscall-1]);
ffffffff8010777f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80107782:	83 e8 01             	sub    $0x1,%eax
ffffffff80107785:	48 98                	cltq
ffffffff80107787:	8b 04 85 80 40 11 80 	mov    -0x7feebf80(,%rax,4),%eax
ffffffff8010778e:	89 c6                	mov    %eax,%esi
ffffffff80107790:	48 c7 c7 07 a1 10 80 	mov    $0xffffffff8010a107,%rdi
ffffffff80107797:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010779c:	e8 03 8e ff ff       	call   ffffffff801005a4 <cprintf>
  return syscallsCount[syscall-1];
ffffffff801077a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff801077a4:	83 e8 01             	sub    $0x1,%eax
ffffffff801077a7:	48 98                	cltq
ffffffff801077a9:	8b 04 85 80 40 11 80 	mov    -0x7feebf80(,%rax,4),%eax
}
ffffffff801077b0:	c9                   	leave
ffffffff801077b1:	c3                   	ret

ffffffff801077b2 <sys_killrandom>:

int sys_killrandom(void){
ffffffff801077b2:	55                   	push   %rbp
ffffffff801077b3:	48 89 e5             	mov    %rsp,%rbp
ffffffff801077b6:	53                   	push   %rbx
ffffffff801077b7:	48 83 ec 28          	sub    $0x28,%rsp
  LCG lcg;
  Set *set = createRoot();
ffffffff801077bb:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801077c0:	e8 b8 19 00 00       	call   ffffffff8010917d <createRoot>
ffffffff801077c5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

  // Από sys_getpinfo
  acquire(&ptable.lock);
ffffffff801077c9:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff801077d0:	e8 0e e4 ff ff       	call   ffffffff80105be3 <acquire>
  struct proc *p;
  for (p = ptable.proc; p != &(ptable.proc[NPROC]); p++) { //Για κάθε διεργασία
ffffffff801077d5:	48 c7 45 e8 68 04 11 	movq   $0xffffffff80110468,-0x18(%rbp)
ffffffff801077dc:	80 
ffffffff801077dd:	eb 1d                	jmp    ffffffff801077fc <sys_killrandom+0x4a>
      createNode(p->pid, set);
ffffffff801077df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801077e3:	8b 40 1c             	mov    0x1c(%rax),%eax
ffffffff801077e6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffffffff801077ea:	48 89 d6             	mov    %rdx,%rsi
ffffffff801077ed:	89 c7                	mov    %eax,%edi
ffffffff801077ef:	e8 b6 19 00 00       	call   ffffffff801091aa <createNode>
  for (p = ptable.proc; p != &(ptable.proc[NPROC]); p++) { //Για κάθε διεργασία
ffffffff801077f4:	48 81 45 e8 f0 00 00 	addq   $0xf0,-0x18(%rbp)
ffffffff801077fb:	00 
ffffffff801077fc:	48 81 7d e8 68 40 11 	cmpq   $0xffffffff80114068,-0x18(%rbp)
ffffffff80107803:	80 
ffffffff80107804:	75 d9                	jne    ffffffff801077df <sys_killrandom+0x2d>
  }
  release(&ptable.lock);
ffffffff80107806:	48 c7 c7 00 04 11 80 	mov    $0xffffffff80110400,%rdi
ffffffff8010780d:	e8 a8 e4 ff ff       	call   ffffffff80105cba <release>

  //Γεννήτρια ψευδοτυχαίων αριθμών
  lcg.m = set->size;
ffffffff80107812:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80107816:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80107819:	89 45 d0             	mov    %eax,-0x30(%rbp)
  lcg.a = sys_uptime()/(MAX(sys_getfavnum(), set->size));
ffffffff8010781c:	e8 d5 fe ff ff       	call   ffffffff801076f6 <sys_uptime>
ffffffff80107821:	89 c3                	mov    %eax,%ebx
ffffffff80107823:	e8 fc fe ff ff       	call   ffffffff80107724 <sys_getfavnum>
ffffffff80107828:	89 c2                	mov    %eax,%edx
ffffffff8010782a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010782e:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80107831:	39 c2                	cmp    %eax,%edx
ffffffff80107833:	7e 09                	jle    ffffffff8010783e <sys_killrandom+0x8c>
ffffffff80107835:	e8 ea fe ff ff       	call   ffffffff80107724 <sys_getfavnum>
ffffffff8010783a:	89 c1                	mov    %eax,%ecx
ffffffff8010783c:	eb 07                	jmp    ffffffff80107845 <sys_killrandom+0x93>
ffffffff8010783e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80107842:	8b 48 08             	mov    0x8(%rax),%ecx
ffffffff80107845:	89 d8                	mov    %ebx,%eax
ffffffff80107847:	99                   	cltd
ffffffff80107848:	f7 f9                	idiv   %ecx
ffffffff8010784a:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  lcg.c = sys_getfavnum();
ffffffff8010784d:	e8 d2 fe ff ff       	call   ffffffff80107724 <sys_getfavnum>
ffffffff80107852:	89 45 d8             	mov    %eax,-0x28(%rbp)
  lcg.state = 0;
ffffffff80107855:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)

  lcg_init(&lcg, sys_uptime());
ffffffff8010785c:	e8 95 fe ff ff       	call   ffffffff801076f6 <sys_uptime>
ffffffff80107861:	89 c2                	mov    %eax,%edx
ffffffff80107863:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffffffff80107867:	89 d6                	mov    %edx,%esi
ffffffff80107869:	48 89 c7             	mov    %rax,%rdi
ffffffff8010786c:	e8 ef 1a 00 00       	call   ffffffff80109360 <lcg_init>
  lcg_random(&lcg);
ffffffff80107871:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffffffff80107875:	48 89 c7             	mov    %rax,%rdi
ffffffff80107878:	e8 08 1b 00 00       	call   ffffffff80109385 <lcg_random>
  
  cprintf("Killing PID: %d\n", getNodeAtPosition(set,lcg.state)->i);
ffffffff8010787d:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffffffff80107880:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80107884:	89 d6                	mov    %edx,%esi
ffffffff80107886:	48 89 c7             	mov    %rax,%rdi
ffffffff80107889:	e8 6a 1a 00 00       	call   ffffffff801092f8 <getNodeAtPosition>
ffffffff8010788e:	8b 00                	mov    (%rax),%eax
ffffffff80107890:	89 c6                	mov    %eax,%esi
ffffffff80107892:	48 c7 c7 0b a1 10 80 	mov    $0xffffffff8010a10b,%rdi
ffffffff80107899:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010789e:	e8 01 8d ff ff       	call   ffffffff801005a4 <cprintf>
  kill(getNodeAtPosition(set,lcg.state)->i);
ffffffff801078a3:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffffffff801078a6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801078aa:	89 d6                	mov    %edx,%esi
ffffffff801078ac:	48 89 c7             	mov    %rax,%rdi
ffffffff801078af:	e8 44 1a 00 00       	call   ffffffff801092f8 <getNodeAtPosition>
ffffffff801078b4:	8b 00                	mov    (%rax),%eax
ffffffff801078b6:	89 c7                	mov    %eax,%edi
ffffffff801078b8:	e8 e9 e0 ff ff       	call   ffffffff801059a6 <kill>
  
  return 1;
ffffffff801078bd:	b8 01 00 00 00       	mov    $0x1,%eax
ffffffff801078c2:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffffffff801078c6:	c9                   	leave
ffffffff801078c7:	c3                   	ret

ffffffff801078c8 <outb>:
{
ffffffff801078c8:	55                   	push   %rbp
ffffffff801078c9:	48 89 e5             	mov    %rsp,%rbp
ffffffff801078cc:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff801078d0:	89 fa                	mov    %edi,%edx
ffffffff801078d2:	89 f0                	mov    %esi,%eax
ffffffff801078d4:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff801078d8:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff801078db:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff801078df:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff801078e3:	ee                   	out    %al,(%dx)
}
ffffffff801078e4:	90                   	nop
ffffffff801078e5:	c9                   	leave
ffffffff801078e6:	c3                   	ret

ffffffff801078e7 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
ffffffff801078e7:	55                   	push   %rbp
ffffffff801078e8:	48 89 e5             	mov    %rsp,%rbp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
ffffffff801078eb:	be 34 00 00 00       	mov    $0x34,%esi
ffffffff801078f0:	bf 43 00 00 00       	mov    $0x43,%edi
ffffffff801078f5:	e8 ce ff ff ff       	call   ffffffff801078c8 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
ffffffff801078fa:	be 9c 00 00 00       	mov    $0x9c,%esi
ffffffff801078ff:	bf 40 00 00 00       	mov    $0x40,%edi
ffffffff80107904:	e8 bf ff ff ff       	call   ffffffff801078c8 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
ffffffff80107909:	be 2e 00 00 00       	mov    $0x2e,%esi
ffffffff8010790e:	bf 40 00 00 00       	mov    $0x40,%edi
ffffffff80107913:	e8 b0 ff ff ff       	call   ffffffff801078c8 <outb>
  picenable(IRQ_TIMER);
ffffffff80107918:	bf 00 00 00 00       	mov    $0x0,%edi
ffffffff8010791d:	e8 fd ce ff ff       	call   ffffffff8010481f <picenable>
}
ffffffff80107922:	90                   	nop
ffffffff80107923:	5d                   	pop    %rbp
ffffffff80107924:	c3                   	ret

ffffffff80107925 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  push %r15
ffffffff80107925:	41 57                	push   %r15
  push %r14
ffffffff80107927:	41 56                	push   %r14
  push %r13
ffffffff80107929:	41 55                	push   %r13
  push %r12
ffffffff8010792b:	41 54                	push   %r12
  push %r11
ffffffff8010792d:	41 53                	push   %r11
  push %r10
ffffffff8010792f:	41 52                	push   %r10
  push %r9
ffffffff80107931:	41 51                	push   %r9
  push %r8
ffffffff80107933:	41 50                	push   %r8
  push %rdi
ffffffff80107935:	57                   	push   %rdi
  push %rsi
ffffffff80107936:	56                   	push   %rsi
  push %rbp
ffffffff80107937:	55                   	push   %rbp
  push %rdx
ffffffff80107938:	52                   	push   %rdx
  push %rcx
ffffffff80107939:	51                   	push   %rcx
  push %rbx
ffffffff8010793a:	53                   	push   %rbx
  push %rax
ffffffff8010793b:	50                   	push   %rax

  mov  %rsp, %rdi  # frame in arg1
ffffffff8010793c:	48 89 e7             	mov    %rsp,%rdi
  call trap
ffffffff8010793f:	e8 32 00 00 00       	call   ffffffff80107976 <trap>

ffffffff80107944 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  pop %rax
ffffffff80107944:	58                   	pop    %rax
  pop %rbx
ffffffff80107945:	5b                   	pop    %rbx
  pop %rcx
ffffffff80107946:	59                   	pop    %rcx
  pop %rdx
ffffffff80107947:	5a                   	pop    %rdx
  pop %rbp
ffffffff80107948:	5d                   	pop    %rbp
  pop %rsi
ffffffff80107949:	5e                   	pop    %rsi
  pop %rdi
ffffffff8010794a:	5f                   	pop    %rdi
  pop %r8
ffffffff8010794b:	41 58                	pop    %r8
  pop %r9
ffffffff8010794d:	41 59                	pop    %r9
  pop %r10
ffffffff8010794f:	41 5a                	pop    %r10
  pop %r11
ffffffff80107951:	41 5b                	pop    %r11
  pop %r12
ffffffff80107953:	41 5c                	pop    %r12
  pop %r13
ffffffff80107955:	41 5d                	pop    %r13
  pop %r14
ffffffff80107957:	41 5e                	pop    %r14
  pop %r15
ffffffff80107959:	41 5f                	pop    %r15

  # discard trapnum and errorcode
  add $16, %rsp
ffffffff8010795b:	48 83 c4 10          	add    $0x10,%rsp
  iretq
ffffffff8010795f:	48 cf                	iretq

ffffffff80107961 <rcr2>:

static inline uintp
rcr2(void)
{
ffffffff80107961:	55                   	push   %rbp
ffffffff80107962:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107965:	48 83 ec 10          	sub    $0x10,%rsp
  uintp val;
  asm volatile("mov %%cr2,%0" : "=r" (val));
ffffffff80107969:	0f 20 d0             	mov    %cr2,%rax
ffffffff8010796c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return val;
ffffffff80107970:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff80107974:	c9                   	leave
ffffffff80107975:	c3                   	ret

ffffffff80107976 <trap>:
#endif

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
ffffffff80107976:	55                   	push   %rbp
ffffffff80107977:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010797a:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff8010797e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(tf->trapno == T_SYSCALL){
ffffffff80107982:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107986:	48 8b 40 78          	mov    0x78(%rax),%rax
ffffffff8010798a:	48 83 f8 40          	cmp    $0x40,%rax
ffffffff8010798e:	75 4f                	jne    ffffffff801079df <trap+0x69>
    if(proc->killed)
ffffffff80107990:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107997:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff8010799b:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff8010799e:	85 c0                	test   %eax,%eax
ffffffff801079a0:	74 05                	je     ffffffff801079a7 <trap+0x31>
      exit();
ffffffff801079a2:	e8 db d9 ff ff       	call   ffffffff80105382 <exit>
    proc->tf = tf;
ffffffff801079a7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801079ae:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801079b2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801079b6:	48 89 50 28          	mov    %rdx,0x28(%rax)
    syscall();
ffffffff801079ba:	e8 d1 eb ff ff       	call   ffffffff80106590 <syscall>
    if(proc->killed)
ffffffff801079bf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff801079c6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff801079ca:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff801079cd:	85 c0                	test   %eax,%eax
ffffffff801079cf:	0f 84 d4 02 00 00    	je     ffffffff80107ca9 <trap+0x333>
      exit();
ffffffff801079d5:	e8 a8 d9 ff ff       	call   ffffffff80105382 <exit>
    return;
ffffffff801079da:	e9 ca 02 00 00       	jmp    ffffffff80107ca9 <trap+0x333>
  }

  switch(tf->trapno){
ffffffff801079df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801079e3:	48 8b 40 78          	mov    0x78(%rax),%rax
ffffffff801079e7:	48 83 e8 20          	sub    $0x20,%rax
ffffffff801079eb:	48 83 f8 1f          	cmp    $0x1f,%rax
ffffffff801079ef:	0f 87 08 01 00 00    	ja     ffffffff80107afd <trap+0x187>
ffffffff801079f5:	48 8b 04 c5 c8 a1 10 	mov    -0x7fef5e38(,%rax,8),%rax
ffffffff801079fc:	80 
ffffffff801079fd:	ff e0                	jmp    *%rax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
ffffffff801079ff:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80107a06:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107a0a:	0f b6 00             	movzbl (%rax),%eax
ffffffff80107a0d:	84 c0                	test   %al,%al
ffffffff80107a0f:	75 71                	jne    ffffffff80107a82 <trap+0x10c>
      acquire(&tickslock);
ffffffff80107a11:	48 c7 c7 00 49 11 80 	mov    $0xffffffff80114900,%rdi
ffffffff80107a18:	e8 c6 e1 ff ff       	call   ffffffff80105be3 <acquire>
      ticks++;
ffffffff80107a1d:	8b 05 45 cf 00 00    	mov    0xcf45(%rip),%eax        # ffffffff80114968 <ticks>
ffffffff80107a23:	83 c0 01             	add    $0x1,%eax
ffffffff80107a26:	89 05 3c cf 00 00    	mov    %eax,0xcf3c(%rip)        # ffffffff80114968 <ticks>
      if (proc && (tf->cs & 3) == 3) {
ffffffff80107a2c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107a33:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107a37:	48 85 c0             	test   %rax,%rax
ffffffff80107a3a:	74 2e                	je     ffffffff80107a6a <trap+0xf4>
ffffffff80107a3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107a40:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffffffff80107a47:	83 e0 03             	and    $0x3,%eax
ffffffff80107a4a:	48 83 f8 03          	cmp    $0x3,%rax
ffffffff80107a4e:	75 1a                	jne    ffffffff80107a6a <trap+0xf4>
          proc->ticks++;
ffffffff80107a50:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107a57:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107a5b:	8b 90 e4 00 00 00    	mov    0xe4(%rax),%edx
ffffffff80107a61:	83 c2 01             	add    $0x1,%edx
ffffffff80107a64:	89 90 e4 00 00 00    	mov    %edx,0xe4(%rax)
      }
      wakeup(&ticks);
ffffffff80107a6a:	48 c7 c7 68 49 11 80 	mov    $0xffffffff80114968,%rdi
ffffffff80107a71:	e8 fd de ff ff       	call   ffffffff80105973 <wakeup>
      release(&tickslock);
ffffffff80107a76:	48 c7 c7 00 49 11 80 	mov    $0xffffffff80114900,%rdi
ffffffff80107a7d:	e8 38 e2 ff ff       	call   ffffffff80105cba <release>
    }
    lapiceoi();
ffffffff80107a82:	e8 75 bc ff ff       	call   ffffffff801036fc <lapiceoi>
    break;
ffffffff80107a87:	e9 6f 01 00 00       	jmp    ffffffff80107bfb <trap+0x285>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
ffffffff80107a8c:	e8 a4 b3 ff ff       	call   ffffffff80102e35 <ideintr>
    lapiceoi();
ffffffff80107a91:	e8 66 bc ff ff       	call   ffffffff801036fc <lapiceoi>
    break;
ffffffff80107a96:	e9 60 01 00 00       	jmp    ffffffff80107bfb <trap+0x285>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
ffffffff80107a9b:	e8 11 ba ff ff       	call   ffffffff801034b1 <kbdintr>
    lapiceoi();
ffffffff80107aa0:	e8 57 bc ff ff       	call   ffffffff801036fc <lapiceoi>
    break;
ffffffff80107aa5:	e9 51 01 00 00       	jmp    ffffffff80107bfb <trap+0x285>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
ffffffff80107aaa:	e8 cf 03 00 00       	call   ffffffff80107e7e <uartintr>
    lapiceoi();
ffffffff80107aaf:	e8 48 bc ff ff       	call   ffffffff801036fc <lapiceoi>
    break;
ffffffff80107ab4:	e9 42 01 00 00       	jmp    ffffffff80107bfb <trap+0x285>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
ffffffff80107ab9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107abd:	48 8b 88 88 00 00 00 	mov    0x88(%rax),%rcx
ffffffff80107ac4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107ac8:	48 8b 90 90 00 00 00 	mov    0x90(%rax),%rdx
            cpu->id, tf->cs, tf->eip);
ffffffff80107acf:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80107ad6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107ada:	0f b6 00             	movzbl (%rax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
ffffffff80107add:	0f b6 c0             	movzbl %al,%eax
ffffffff80107ae0:	89 c6                	mov    %eax,%esi
ffffffff80107ae2:	48 c7 c7 20 a1 10 80 	mov    $0xffffffff8010a120,%rdi
ffffffff80107ae9:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107aee:	e8 b1 8a ff ff       	call   ffffffff801005a4 <cprintf>
    lapiceoi();
ffffffff80107af3:	e8 04 bc ff ff       	call   ffffffff801036fc <lapiceoi>
    break;
ffffffff80107af8:	e9 fe 00 00 00       	jmp    ffffffff80107bfb <trap+0x285>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
ffffffff80107afd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107b04:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107b08:	48 85 c0             	test   %rax,%rax
ffffffff80107b0b:	74 13                	je     ffffffff80107b20 <trap+0x1aa>
ffffffff80107b0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107b11:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffffffff80107b18:	83 e0 03             	and    $0x3,%eax
ffffffff80107b1b:	48 85 c0             	test   %rax,%rax
ffffffff80107b1e:	75 4f                	jne    ffffffff80107b6f <trap+0x1f9>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
ffffffff80107b20:	e8 3c fe ff ff       	call   ffffffff80107961 <rcr2>
ffffffff80107b25:	48 89 c6             	mov    %rax,%rsi
ffffffff80107b28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107b2c:	48 8b 88 88 00 00 00 	mov    0x88(%rax),%rcx
              tf->trapno, cpu->id, tf->eip, rcr2());
ffffffff80107b33:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80107b3a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107b3e:	0f b6 00             	movzbl (%rax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
ffffffff80107b41:	0f b6 d0             	movzbl %al,%edx
ffffffff80107b44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107b48:	48 8b 40 78          	mov    0x78(%rax),%rax
ffffffff80107b4c:	49 89 f0             	mov    %rsi,%r8
ffffffff80107b4f:	48 89 c6             	mov    %rax,%rsi
ffffffff80107b52:	48 c7 c7 48 a1 10 80 	mov    $0xffffffff8010a148,%rdi
ffffffff80107b59:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107b5e:	e8 41 8a ff ff       	call   ffffffff801005a4 <cprintf>
      panic("trap");
ffffffff80107b63:	48 c7 c7 7a a1 10 80 	mov    $0xffffffff8010a17a,%rdi
ffffffff80107b6a:	e8 c0 8d ff ff       	call   ffffffff8010092f <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffffffff80107b6f:	e8 ed fd ff ff       	call   ffffffff80107961 <rcr2>
ffffffff80107b74:	48 89 c1             	mov    %rax,%rcx
ffffffff80107b77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107b7b:	48 8b b8 88 00 00 00 	mov    0x88(%rax),%rdi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
ffffffff80107b82:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffffffff80107b89:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107b8d:	0f b6 00             	movzbl (%rax),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffffffff80107b90:	44 0f b6 c8          	movzbl %al,%r9d
ffffffff80107b94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107b98:	4c 8b 80 80 00 00 00 	mov    0x80(%rax),%r8
ffffffff80107b9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107ba3:	48 8b 50 78          	mov    0x78(%rax),%rdx
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
ffffffff80107ba7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107bae:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107bb2:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffffffff80107bb9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107bc0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107bc4:	8b 40 1c             	mov    0x1c(%rax),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffffffff80107bc7:	51                   	push   %rcx
ffffffff80107bc8:	57                   	push   %rdi
ffffffff80107bc9:	48 89 d1             	mov    %rdx,%rcx
ffffffff80107bcc:	48 89 f2             	mov    %rsi,%rdx
ffffffff80107bcf:	89 c6                	mov    %eax,%esi
ffffffff80107bd1:	48 c7 c7 80 a1 10 80 	mov    $0xffffffff8010a180,%rdi
ffffffff80107bd8:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80107bdd:	e8 c2 89 ff ff       	call   ffffffff801005a4 <cprintf>
ffffffff80107be2:	48 83 c4 10          	add    $0x10,%rsp
            rcr2());
    proc->killed = 1;
ffffffff80107be6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107bed:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107bf1:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
ffffffff80107bf8:	eb 01                	jmp    ffffffff80107bfb <trap+0x285>
    break;
ffffffff80107bfa:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffffffff80107bfb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107c02:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107c06:	48 85 c0             	test   %rax,%rax
ffffffff80107c09:	74 2b                	je     ffffffff80107c36 <trap+0x2c0>
ffffffff80107c0b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107c12:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107c16:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80107c19:	85 c0                	test   %eax,%eax
ffffffff80107c1b:	74 19                	je     ffffffff80107c36 <trap+0x2c0>
ffffffff80107c1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107c21:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffffffff80107c28:	83 e0 03             	and    $0x3,%eax
ffffffff80107c2b:	48 83 f8 03          	cmp    $0x3,%rax
ffffffff80107c2f:	75 05                	jne    ffffffff80107c36 <trap+0x2c0>
    exit();
ffffffff80107c31:	e8 4c d7 ff ff       	call   ffffffff80105382 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
ffffffff80107c36:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107c3d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107c41:	48 85 c0             	test   %rax,%rax
ffffffff80107c44:	74 26                	je     ffffffff80107c6c <trap+0x2f6>
ffffffff80107c46:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107c4d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107c51:	8b 40 18             	mov    0x18(%rax),%eax
ffffffff80107c54:	83 f8 04             	cmp    $0x4,%eax
ffffffff80107c57:	75 13                	jne    ffffffff80107c6c <trap+0x2f6>
ffffffff80107c59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107c5d:	48 8b 40 78          	mov    0x78(%rax),%rax
ffffffff80107c61:	48 83 f8 20          	cmp    $0x20,%rax
ffffffff80107c65:	75 05                	jne    ffffffff80107c6c <trap+0x2f6>
    yield();
ffffffff80107c67:	e8 91 db ff ff       	call   ffffffff801057fd <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffffffff80107c6c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107c73:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107c77:	48 85 c0             	test   %rax,%rax
ffffffff80107c7a:	74 2e                	je     ffffffff80107caa <trap+0x334>
ffffffff80107c7c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffffffff80107c83:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffffffff80107c87:	8b 40 40             	mov    0x40(%rax),%eax
ffffffff80107c8a:	85 c0                	test   %eax,%eax
ffffffff80107c8c:	74 1c                	je     ffffffff80107caa <trap+0x334>
ffffffff80107c8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107c92:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffffffff80107c99:	83 e0 03             	and    $0x3,%eax
ffffffff80107c9c:	48 83 f8 03          	cmp    $0x3,%rax
ffffffff80107ca0:	75 08                	jne    ffffffff80107caa <trap+0x334>
    exit();
ffffffff80107ca2:	e8 db d6 ff ff       	call   ffffffff80105382 <exit>
ffffffff80107ca7:	eb 01                	jmp    ffffffff80107caa <trap+0x334>
    return;
ffffffff80107ca9:	90                   	nop
}
ffffffff80107caa:	c9                   	leave
ffffffff80107cab:	c3                   	ret

ffffffff80107cac <inb>:
{
ffffffff80107cac:	55                   	push   %rbp
ffffffff80107cad:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107cb0:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80107cb4:	89 f8                	mov    %edi,%eax
ffffffff80107cb6:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffffffff80107cba:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffffffff80107cbe:	89 c2                	mov    %eax,%edx
ffffffff80107cc0:	ec                   	in     (%dx),%al
ffffffff80107cc1:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffffffff80107cc4:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffffffff80107cc8:	c9                   	leave
ffffffff80107cc9:	c3                   	ret

ffffffff80107cca <outb>:
{
ffffffff80107cca:	55                   	push   %rbp
ffffffff80107ccb:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107cce:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80107cd2:	89 fa                	mov    %edi,%edx
ffffffff80107cd4:	89 f0                	mov    %esi,%eax
ffffffff80107cd6:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffffffff80107cda:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffffffff80107cdd:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffffffff80107ce1:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffffffff80107ce5:	ee                   	out    %al,(%dx)
}
ffffffff80107ce6:	90                   	nop
ffffffff80107ce7:	c9                   	leave
ffffffff80107ce8:	c3                   	ret

ffffffff80107ce9 <uartearlyinit>:

static int uart;    // is there a uart?

void
uartearlyinit(void)
{
ffffffff80107ce9:	55                   	push   %rbp
ffffffff80107cea:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107ced:	48 83 ec 10          	sub    $0x10,%rsp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
ffffffff80107cf1:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80107cf6:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffffffff80107cfb:	e8 ca ff ff ff       	call   ffffffff80107cca <outb>
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
ffffffff80107d00:	be 80 00 00 00       	mov    $0x80,%esi
ffffffff80107d05:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffffffff80107d0a:	e8 bb ff ff ff       	call   ffffffff80107cca <outb>
  outb(COM1+0, 115200/9600);
ffffffff80107d0f:	be 0c 00 00 00       	mov    $0xc,%esi
ffffffff80107d14:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffffffff80107d19:	e8 ac ff ff ff       	call   ffffffff80107cca <outb>
  outb(COM1+1, 0);
ffffffff80107d1e:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80107d23:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffffffff80107d28:	e8 9d ff ff ff       	call   ffffffff80107cca <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
ffffffff80107d2d:	be 03 00 00 00       	mov    $0x3,%esi
ffffffff80107d32:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffffffff80107d37:	e8 8e ff ff ff       	call   ffffffff80107cca <outb>
  outb(COM1+4, 0);
ffffffff80107d3c:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80107d41:	bf fc 03 00 00       	mov    $0x3fc,%edi
ffffffff80107d46:	e8 7f ff ff ff       	call   ffffffff80107cca <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
ffffffff80107d4b:	be 01 00 00 00       	mov    $0x1,%esi
ffffffff80107d50:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffffffff80107d55:	e8 70 ff ff ff       	call   ffffffff80107cca <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
ffffffff80107d5a:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffffffff80107d5f:	e8 48 ff ff ff       	call   ffffffff80107cac <inb>
ffffffff80107d64:	3c ff                	cmp    $0xff,%al
ffffffff80107d66:	74 37                	je     ffffffff80107d9f <uartearlyinit+0xb6>
    return;
  uart = 1;
ffffffff80107d68:	c7 05 fa cb 00 00 01 	movl   $0x1,0xcbfa(%rip)        # ffffffff8011496c <uart>
ffffffff80107d6f:	00 00 00 

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
ffffffff80107d72:	48 c7 45 f8 c8 a2 10 	movq   $0xffffffff8010a2c8,-0x8(%rbp)
ffffffff80107d79:	80 
ffffffff80107d7a:	eb 16                	jmp    ffffffff80107d92 <uartearlyinit+0xa9>
    uartputc(*p);
ffffffff80107d7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107d80:	0f b6 00             	movzbl (%rax),%eax
ffffffff80107d83:	0f be c0             	movsbl %al,%eax
ffffffff80107d86:	89 c7                	mov    %eax,%edi
ffffffff80107d88:	e8 55 00 00 00       	call   ffffffff80107de2 <uartputc>
  for(p="xv6...\n"; *p; p++)
ffffffff80107d8d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffffffff80107d92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80107d96:	0f b6 00             	movzbl (%rax),%eax
ffffffff80107d99:	84 c0                	test   %al,%al
ffffffff80107d9b:	75 df                	jne    ffffffff80107d7c <uartearlyinit+0x93>
ffffffff80107d9d:	eb 01                	jmp    ffffffff80107da0 <uartearlyinit+0xb7>
    return;
ffffffff80107d9f:	90                   	nop
}
ffffffff80107da0:	c9                   	leave
ffffffff80107da1:	c3                   	ret

ffffffff80107da2 <uartinit>:

void
uartinit(void)
{
ffffffff80107da2:	55                   	push   %rbp
ffffffff80107da3:	48 89 e5             	mov    %rsp,%rbp
  if (!uart)
ffffffff80107da6:	8b 05 c0 cb 00 00    	mov    0xcbc0(%rip),%eax        # ffffffff8011496c <uart>
ffffffff80107dac:	85 c0                	test   %eax,%eax
ffffffff80107dae:	74 2f                	je     ffffffff80107ddf <uartinit+0x3d>
    return;

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
ffffffff80107db0:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffffffff80107db5:	e8 f2 fe ff ff       	call   ffffffff80107cac <inb>
  inb(COM1+0);
ffffffff80107dba:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffffffff80107dbf:	e8 e8 fe ff ff       	call   ffffffff80107cac <inb>
  picenable(IRQ_COM1);
ffffffff80107dc4:	bf 04 00 00 00       	mov    $0x4,%edi
ffffffff80107dc9:	e8 51 ca ff ff       	call   ffffffff8010481f <picenable>
  ioapicenable(IRQ_COM1, 0);
ffffffff80107dce:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80107dd3:	bf 04 00 00 00       	mov    $0x4,%edi
ffffffff80107dd8:	e8 25 b3 ff ff       	call   ffffffff80103102 <ioapicenable>
ffffffff80107ddd:	eb 01                	jmp    ffffffff80107de0 <uartinit+0x3e>
    return;
ffffffff80107ddf:	90                   	nop
}
ffffffff80107de0:	5d                   	pop    %rbp
ffffffff80107de1:	c3                   	ret

ffffffff80107de2 <uartputc>:

void
uartputc(int c)
{
ffffffff80107de2:	55                   	push   %rbp
ffffffff80107de3:	48 89 e5             	mov    %rsp,%rbp
ffffffff80107de6:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80107dea:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;

  if(!uart)
ffffffff80107ded:	8b 05 79 cb 00 00    	mov    0xcb79(%rip),%eax        # ffffffff8011496c <uart>
ffffffff80107df3:	85 c0                	test   %eax,%eax
ffffffff80107df5:	74 45                	je     ffffffff80107e3c <uartputc+0x5a>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffffffff80107df7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80107dfe:	eb 0e                	jmp    ffffffff80107e0e <uartputc+0x2c>
    microdelay(10);
ffffffff80107e00:	bf 0a 00 00 00       	mov    $0xa,%edi
ffffffff80107e05:	e8 14 b9 ff ff       	call   ffffffff8010371e <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffffffff80107e0a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80107e0e:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffffffff80107e12:	7f 14                	jg     ffffffff80107e28 <uartputc+0x46>
ffffffff80107e14:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffffffff80107e19:	e8 8e fe ff ff       	call   ffffffff80107cac <inb>
ffffffff80107e1e:	0f b6 c0             	movzbl %al,%eax
ffffffff80107e21:	83 e0 20             	and    $0x20,%eax
ffffffff80107e24:	85 c0                	test   %eax,%eax
ffffffff80107e26:	74 d8                	je     ffffffff80107e00 <uartputc+0x1e>
  outb(COM1+0, c);
ffffffff80107e28:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80107e2b:	0f b6 c0             	movzbl %al,%eax
ffffffff80107e2e:	89 c6                	mov    %eax,%esi
ffffffff80107e30:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffffffff80107e35:	e8 90 fe ff ff       	call   ffffffff80107cca <outb>
ffffffff80107e3a:	eb 01                	jmp    ffffffff80107e3d <uartputc+0x5b>
    return;
ffffffff80107e3c:	90                   	nop
}
ffffffff80107e3d:	c9                   	leave
ffffffff80107e3e:	c3                   	ret

ffffffff80107e3f <uartgetc>:

static int
uartgetc(void)
{
ffffffff80107e3f:	55                   	push   %rbp
ffffffff80107e40:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffffffff80107e43:	8b 05 23 cb 00 00    	mov    0xcb23(%rip),%eax        # ffffffff8011496c <uart>
ffffffff80107e49:	85 c0                	test   %eax,%eax
ffffffff80107e4b:	75 07                	jne    ffffffff80107e54 <uartgetc+0x15>
    return -1;
ffffffff80107e4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107e52:	eb 28                	jmp    ffffffff80107e7c <uartgetc+0x3d>
  if(!(inb(COM1+5) & 0x01))
ffffffff80107e54:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffffffff80107e59:	e8 4e fe ff ff       	call   ffffffff80107cac <inb>
ffffffff80107e5e:	0f b6 c0             	movzbl %al,%eax
ffffffff80107e61:	83 e0 01             	and    $0x1,%eax
ffffffff80107e64:	85 c0                	test   %eax,%eax
ffffffff80107e66:	75 07                	jne    ffffffff80107e6f <uartgetc+0x30>
    return -1;
ffffffff80107e68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80107e6d:	eb 0d                	jmp    ffffffff80107e7c <uartgetc+0x3d>
  return inb(COM1+0);
ffffffff80107e6f:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffffffff80107e74:	e8 33 fe ff ff       	call   ffffffff80107cac <inb>
ffffffff80107e79:	0f b6 c0             	movzbl %al,%eax
}
ffffffff80107e7c:	5d                   	pop    %rbp
ffffffff80107e7d:	c3                   	ret

ffffffff80107e7e <uartintr>:

void
uartintr(void)
{
ffffffff80107e7e:	55                   	push   %rbp
ffffffff80107e7f:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(uartgetc);
ffffffff80107e82:	48 c7 c7 3f 7e 10 80 	mov    $0xffffffff80107e3f,%rdi
ffffffff80107e89:	e8 35 8d ff ff       	call   ffffffff80100bc3 <consoleintr>
}
ffffffff80107e8e:	90                   	nop
ffffffff80107e8f:	5d                   	pop    %rbp
ffffffff80107e90:	c3                   	ret

ffffffff80107e91 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  push $0
ffffffff80107e91:	6a 00                	push   $0x0
  push $0
ffffffff80107e93:	6a 00                	push   $0x0
  jmp alltraps
ffffffff80107e95:	e9 8b fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107e9a <vector1>:
.globl vector1
vector1:
  push $0
ffffffff80107e9a:	6a 00                	push   $0x0
  push $1
ffffffff80107e9c:	6a 01                	push   $0x1
  jmp alltraps
ffffffff80107e9e:	e9 82 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ea3 <vector2>:
.globl vector2
vector2:
  push $0
ffffffff80107ea3:	6a 00                	push   $0x0
  push $2
ffffffff80107ea5:	6a 02                	push   $0x2
  jmp alltraps
ffffffff80107ea7:	e9 79 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107eac <vector3>:
.globl vector3
vector3:
  push $0
ffffffff80107eac:	6a 00                	push   $0x0
  push $3
ffffffff80107eae:	6a 03                	push   $0x3
  jmp alltraps
ffffffff80107eb0:	e9 70 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107eb5 <vector4>:
.globl vector4
vector4:
  push $0
ffffffff80107eb5:	6a 00                	push   $0x0
  push $4
ffffffff80107eb7:	6a 04                	push   $0x4
  jmp alltraps
ffffffff80107eb9:	e9 67 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ebe <vector5>:
.globl vector5
vector5:
  push $0
ffffffff80107ebe:	6a 00                	push   $0x0
  push $5
ffffffff80107ec0:	6a 05                	push   $0x5
  jmp alltraps
ffffffff80107ec2:	e9 5e fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ec7 <vector6>:
.globl vector6
vector6:
  push $0
ffffffff80107ec7:	6a 00                	push   $0x0
  push $6
ffffffff80107ec9:	6a 06                	push   $0x6
  jmp alltraps
ffffffff80107ecb:	e9 55 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ed0 <vector7>:
.globl vector7
vector7:
  push $0
ffffffff80107ed0:	6a 00                	push   $0x0
  push $7
ffffffff80107ed2:	6a 07                	push   $0x7
  jmp alltraps
ffffffff80107ed4:	e9 4c fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ed9 <vector8>:
.globl vector8
vector8:
  push $8
ffffffff80107ed9:	6a 08                	push   $0x8
  jmp alltraps
ffffffff80107edb:	e9 45 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ee0 <vector9>:
.globl vector9
vector9:
  push $0
ffffffff80107ee0:	6a 00                	push   $0x0
  push $9
ffffffff80107ee2:	6a 09                	push   $0x9
  jmp alltraps
ffffffff80107ee4:	e9 3c fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ee9 <vector10>:
.globl vector10
vector10:
  push $10
ffffffff80107ee9:	6a 0a                	push   $0xa
  jmp alltraps
ffffffff80107eeb:	e9 35 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ef0 <vector11>:
.globl vector11
vector11:
  push $11
ffffffff80107ef0:	6a 0b                	push   $0xb
  jmp alltraps
ffffffff80107ef2:	e9 2e fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ef7 <vector12>:
.globl vector12
vector12:
  push $12
ffffffff80107ef7:	6a 0c                	push   $0xc
  jmp alltraps
ffffffff80107ef9:	e9 27 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107efe <vector13>:
.globl vector13
vector13:
  push $13
ffffffff80107efe:	6a 0d                	push   $0xd
  jmp alltraps
ffffffff80107f00:	e9 20 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f05 <vector14>:
.globl vector14
vector14:
  push $14
ffffffff80107f05:	6a 0e                	push   $0xe
  jmp alltraps
ffffffff80107f07:	e9 19 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f0c <vector15>:
.globl vector15
vector15:
  push $0
ffffffff80107f0c:	6a 00                	push   $0x0
  push $15
ffffffff80107f0e:	6a 0f                	push   $0xf
  jmp alltraps
ffffffff80107f10:	e9 10 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f15 <vector16>:
.globl vector16
vector16:
  push $0
ffffffff80107f15:	6a 00                	push   $0x0
  push $16
ffffffff80107f17:	6a 10                	push   $0x10
  jmp alltraps
ffffffff80107f19:	e9 07 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f1e <vector17>:
.globl vector17
vector17:
  push $17
ffffffff80107f1e:	6a 11                	push   $0x11
  jmp alltraps
ffffffff80107f20:	e9 00 fa ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f25 <vector18>:
.globl vector18
vector18:
  push $0
ffffffff80107f25:	6a 00                	push   $0x0
  push $18
ffffffff80107f27:	6a 12                	push   $0x12
  jmp alltraps
ffffffff80107f29:	e9 f7 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f2e <vector19>:
.globl vector19
vector19:
  push $0
ffffffff80107f2e:	6a 00                	push   $0x0
  push $19
ffffffff80107f30:	6a 13                	push   $0x13
  jmp alltraps
ffffffff80107f32:	e9 ee f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f37 <vector20>:
.globl vector20
vector20:
  push $0
ffffffff80107f37:	6a 00                	push   $0x0
  push $20
ffffffff80107f39:	6a 14                	push   $0x14
  jmp alltraps
ffffffff80107f3b:	e9 e5 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f40 <vector21>:
.globl vector21
vector21:
  push $0
ffffffff80107f40:	6a 00                	push   $0x0
  push $21
ffffffff80107f42:	6a 15                	push   $0x15
  jmp alltraps
ffffffff80107f44:	e9 dc f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f49 <vector22>:
.globl vector22
vector22:
  push $0
ffffffff80107f49:	6a 00                	push   $0x0
  push $22
ffffffff80107f4b:	6a 16                	push   $0x16
  jmp alltraps
ffffffff80107f4d:	e9 d3 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f52 <vector23>:
.globl vector23
vector23:
  push $0
ffffffff80107f52:	6a 00                	push   $0x0
  push $23
ffffffff80107f54:	6a 17                	push   $0x17
  jmp alltraps
ffffffff80107f56:	e9 ca f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f5b <vector24>:
.globl vector24
vector24:
  push $0
ffffffff80107f5b:	6a 00                	push   $0x0
  push $24
ffffffff80107f5d:	6a 18                	push   $0x18
  jmp alltraps
ffffffff80107f5f:	e9 c1 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f64 <vector25>:
.globl vector25
vector25:
  push $0
ffffffff80107f64:	6a 00                	push   $0x0
  push $25
ffffffff80107f66:	6a 19                	push   $0x19
  jmp alltraps
ffffffff80107f68:	e9 b8 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f6d <vector26>:
.globl vector26
vector26:
  push $0
ffffffff80107f6d:	6a 00                	push   $0x0
  push $26
ffffffff80107f6f:	6a 1a                	push   $0x1a
  jmp alltraps
ffffffff80107f71:	e9 af f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f76 <vector27>:
.globl vector27
vector27:
  push $0
ffffffff80107f76:	6a 00                	push   $0x0
  push $27
ffffffff80107f78:	6a 1b                	push   $0x1b
  jmp alltraps
ffffffff80107f7a:	e9 a6 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f7f <vector28>:
.globl vector28
vector28:
  push $0
ffffffff80107f7f:	6a 00                	push   $0x0
  push $28
ffffffff80107f81:	6a 1c                	push   $0x1c
  jmp alltraps
ffffffff80107f83:	e9 9d f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f88 <vector29>:
.globl vector29
vector29:
  push $0
ffffffff80107f88:	6a 00                	push   $0x0
  push $29
ffffffff80107f8a:	6a 1d                	push   $0x1d
  jmp alltraps
ffffffff80107f8c:	e9 94 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f91 <vector30>:
.globl vector30
vector30:
  push $0
ffffffff80107f91:	6a 00                	push   $0x0
  push $30
ffffffff80107f93:	6a 1e                	push   $0x1e
  jmp alltraps
ffffffff80107f95:	e9 8b f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107f9a <vector31>:
.globl vector31
vector31:
  push $0
ffffffff80107f9a:	6a 00                	push   $0x0
  push $31
ffffffff80107f9c:	6a 1f                	push   $0x1f
  jmp alltraps
ffffffff80107f9e:	e9 82 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107fa3 <vector32>:
.globl vector32
vector32:
  push $0
ffffffff80107fa3:	6a 00                	push   $0x0
  push $32
ffffffff80107fa5:	6a 20                	push   $0x20
  jmp alltraps
ffffffff80107fa7:	e9 79 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107fac <vector33>:
.globl vector33
vector33:
  push $0
ffffffff80107fac:	6a 00                	push   $0x0
  push $33
ffffffff80107fae:	6a 21                	push   $0x21
  jmp alltraps
ffffffff80107fb0:	e9 70 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107fb5 <vector34>:
.globl vector34
vector34:
  push $0
ffffffff80107fb5:	6a 00                	push   $0x0
  push $34
ffffffff80107fb7:	6a 22                	push   $0x22
  jmp alltraps
ffffffff80107fb9:	e9 67 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107fbe <vector35>:
.globl vector35
vector35:
  push $0
ffffffff80107fbe:	6a 00                	push   $0x0
  push $35
ffffffff80107fc0:	6a 23                	push   $0x23
  jmp alltraps
ffffffff80107fc2:	e9 5e f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107fc7 <vector36>:
.globl vector36
vector36:
  push $0
ffffffff80107fc7:	6a 00                	push   $0x0
  push $36
ffffffff80107fc9:	6a 24                	push   $0x24
  jmp alltraps
ffffffff80107fcb:	e9 55 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107fd0 <vector37>:
.globl vector37
vector37:
  push $0
ffffffff80107fd0:	6a 00                	push   $0x0
  push $37
ffffffff80107fd2:	6a 25                	push   $0x25
  jmp alltraps
ffffffff80107fd4:	e9 4c f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107fd9 <vector38>:
.globl vector38
vector38:
  push $0
ffffffff80107fd9:	6a 00                	push   $0x0
  push $38
ffffffff80107fdb:	6a 26                	push   $0x26
  jmp alltraps
ffffffff80107fdd:	e9 43 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107fe2 <vector39>:
.globl vector39
vector39:
  push $0
ffffffff80107fe2:	6a 00                	push   $0x0
  push $39
ffffffff80107fe4:	6a 27                	push   $0x27
  jmp alltraps
ffffffff80107fe6:	e9 3a f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107feb <vector40>:
.globl vector40
vector40:
  push $0
ffffffff80107feb:	6a 00                	push   $0x0
  push $40
ffffffff80107fed:	6a 28                	push   $0x28
  jmp alltraps
ffffffff80107fef:	e9 31 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ff4 <vector41>:
.globl vector41
vector41:
  push $0
ffffffff80107ff4:	6a 00                	push   $0x0
  push $41
ffffffff80107ff6:	6a 29                	push   $0x29
  jmp alltraps
ffffffff80107ff8:	e9 28 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80107ffd <vector42>:
.globl vector42
vector42:
  push $0
ffffffff80107ffd:	6a 00                	push   $0x0
  push $42
ffffffff80107fff:	6a 2a                	push   $0x2a
  jmp alltraps
ffffffff80108001:	e9 1f f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108006 <vector43>:
.globl vector43
vector43:
  push $0
ffffffff80108006:	6a 00                	push   $0x0
  push $43
ffffffff80108008:	6a 2b                	push   $0x2b
  jmp alltraps
ffffffff8010800a:	e9 16 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010800f <vector44>:
.globl vector44
vector44:
  push $0
ffffffff8010800f:	6a 00                	push   $0x0
  push $44
ffffffff80108011:	6a 2c                	push   $0x2c
  jmp alltraps
ffffffff80108013:	e9 0d f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108018 <vector45>:
.globl vector45
vector45:
  push $0
ffffffff80108018:	6a 00                	push   $0x0
  push $45
ffffffff8010801a:	6a 2d                	push   $0x2d
  jmp alltraps
ffffffff8010801c:	e9 04 f9 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108021 <vector46>:
.globl vector46
vector46:
  push $0
ffffffff80108021:	6a 00                	push   $0x0
  push $46
ffffffff80108023:	6a 2e                	push   $0x2e
  jmp alltraps
ffffffff80108025:	e9 fb f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010802a <vector47>:
.globl vector47
vector47:
  push $0
ffffffff8010802a:	6a 00                	push   $0x0
  push $47
ffffffff8010802c:	6a 2f                	push   $0x2f
  jmp alltraps
ffffffff8010802e:	e9 f2 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108033 <vector48>:
.globl vector48
vector48:
  push $0
ffffffff80108033:	6a 00                	push   $0x0
  push $48
ffffffff80108035:	6a 30                	push   $0x30
  jmp alltraps
ffffffff80108037:	e9 e9 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010803c <vector49>:
.globl vector49
vector49:
  push $0
ffffffff8010803c:	6a 00                	push   $0x0
  push $49
ffffffff8010803e:	6a 31                	push   $0x31
  jmp alltraps
ffffffff80108040:	e9 e0 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108045 <vector50>:
.globl vector50
vector50:
  push $0
ffffffff80108045:	6a 00                	push   $0x0
  push $50
ffffffff80108047:	6a 32                	push   $0x32
  jmp alltraps
ffffffff80108049:	e9 d7 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010804e <vector51>:
.globl vector51
vector51:
  push $0
ffffffff8010804e:	6a 00                	push   $0x0
  push $51
ffffffff80108050:	6a 33                	push   $0x33
  jmp alltraps
ffffffff80108052:	e9 ce f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108057 <vector52>:
.globl vector52
vector52:
  push $0
ffffffff80108057:	6a 00                	push   $0x0
  push $52
ffffffff80108059:	6a 34                	push   $0x34
  jmp alltraps
ffffffff8010805b:	e9 c5 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108060 <vector53>:
.globl vector53
vector53:
  push $0
ffffffff80108060:	6a 00                	push   $0x0
  push $53
ffffffff80108062:	6a 35                	push   $0x35
  jmp alltraps
ffffffff80108064:	e9 bc f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108069 <vector54>:
.globl vector54
vector54:
  push $0
ffffffff80108069:	6a 00                	push   $0x0
  push $54
ffffffff8010806b:	6a 36                	push   $0x36
  jmp alltraps
ffffffff8010806d:	e9 b3 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108072 <vector55>:
.globl vector55
vector55:
  push $0
ffffffff80108072:	6a 00                	push   $0x0
  push $55
ffffffff80108074:	6a 37                	push   $0x37
  jmp alltraps
ffffffff80108076:	e9 aa f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010807b <vector56>:
.globl vector56
vector56:
  push $0
ffffffff8010807b:	6a 00                	push   $0x0
  push $56
ffffffff8010807d:	6a 38                	push   $0x38
  jmp alltraps
ffffffff8010807f:	e9 a1 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108084 <vector57>:
.globl vector57
vector57:
  push $0
ffffffff80108084:	6a 00                	push   $0x0
  push $57
ffffffff80108086:	6a 39                	push   $0x39
  jmp alltraps
ffffffff80108088:	e9 98 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010808d <vector58>:
.globl vector58
vector58:
  push $0
ffffffff8010808d:	6a 00                	push   $0x0
  push $58
ffffffff8010808f:	6a 3a                	push   $0x3a
  jmp alltraps
ffffffff80108091:	e9 8f f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108096 <vector59>:
.globl vector59
vector59:
  push $0
ffffffff80108096:	6a 00                	push   $0x0
  push $59
ffffffff80108098:	6a 3b                	push   $0x3b
  jmp alltraps
ffffffff8010809a:	e9 86 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010809f <vector60>:
.globl vector60
vector60:
  push $0
ffffffff8010809f:	6a 00                	push   $0x0
  push $60
ffffffff801080a1:	6a 3c                	push   $0x3c
  jmp alltraps
ffffffff801080a3:	e9 7d f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801080a8 <vector61>:
.globl vector61
vector61:
  push $0
ffffffff801080a8:	6a 00                	push   $0x0
  push $61
ffffffff801080aa:	6a 3d                	push   $0x3d
  jmp alltraps
ffffffff801080ac:	e9 74 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801080b1 <vector62>:
.globl vector62
vector62:
  push $0
ffffffff801080b1:	6a 00                	push   $0x0
  push $62
ffffffff801080b3:	6a 3e                	push   $0x3e
  jmp alltraps
ffffffff801080b5:	e9 6b f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801080ba <vector63>:
.globl vector63
vector63:
  push $0
ffffffff801080ba:	6a 00                	push   $0x0
  push $63
ffffffff801080bc:	6a 3f                	push   $0x3f
  jmp alltraps
ffffffff801080be:	e9 62 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801080c3 <vector64>:
.globl vector64
vector64:
  push $0
ffffffff801080c3:	6a 00                	push   $0x0
  push $64
ffffffff801080c5:	6a 40                	push   $0x40
  jmp alltraps
ffffffff801080c7:	e9 59 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801080cc <vector65>:
.globl vector65
vector65:
  push $0
ffffffff801080cc:	6a 00                	push   $0x0
  push $65
ffffffff801080ce:	6a 41                	push   $0x41
  jmp alltraps
ffffffff801080d0:	e9 50 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801080d5 <vector66>:
.globl vector66
vector66:
  push $0
ffffffff801080d5:	6a 00                	push   $0x0
  push $66
ffffffff801080d7:	6a 42                	push   $0x42
  jmp alltraps
ffffffff801080d9:	e9 47 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801080de <vector67>:
.globl vector67
vector67:
  push $0
ffffffff801080de:	6a 00                	push   $0x0
  push $67
ffffffff801080e0:	6a 43                	push   $0x43
  jmp alltraps
ffffffff801080e2:	e9 3e f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801080e7 <vector68>:
.globl vector68
vector68:
  push $0
ffffffff801080e7:	6a 00                	push   $0x0
  push $68
ffffffff801080e9:	6a 44                	push   $0x44
  jmp alltraps
ffffffff801080eb:	e9 35 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801080f0 <vector69>:
.globl vector69
vector69:
  push $0
ffffffff801080f0:	6a 00                	push   $0x0
  push $69
ffffffff801080f2:	6a 45                	push   $0x45
  jmp alltraps
ffffffff801080f4:	e9 2c f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801080f9 <vector70>:
.globl vector70
vector70:
  push $0
ffffffff801080f9:	6a 00                	push   $0x0
  push $70
ffffffff801080fb:	6a 46                	push   $0x46
  jmp alltraps
ffffffff801080fd:	e9 23 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108102 <vector71>:
.globl vector71
vector71:
  push $0
ffffffff80108102:	6a 00                	push   $0x0
  push $71
ffffffff80108104:	6a 47                	push   $0x47
  jmp alltraps
ffffffff80108106:	e9 1a f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010810b <vector72>:
.globl vector72
vector72:
  push $0
ffffffff8010810b:	6a 00                	push   $0x0
  push $72
ffffffff8010810d:	6a 48                	push   $0x48
  jmp alltraps
ffffffff8010810f:	e9 11 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108114 <vector73>:
.globl vector73
vector73:
  push $0
ffffffff80108114:	6a 00                	push   $0x0
  push $73
ffffffff80108116:	6a 49                	push   $0x49
  jmp alltraps
ffffffff80108118:	e9 08 f8 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010811d <vector74>:
.globl vector74
vector74:
  push $0
ffffffff8010811d:	6a 00                	push   $0x0
  push $74
ffffffff8010811f:	6a 4a                	push   $0x4a
  jmp alltraps
ffffffff80108121:	e9 ff f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108126 <vector75>:
.globl vector75
vector75:
  push $0
ffffffff80108126:	6a 00                	push   $0x0
  push $75
ffffffff80108128:	6a 4b                	push   $0x4b
  jmp alltraps
ffffffff8010812a:	e9 f6 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010812f <vector76>:
.globl vector76
vector76:
  push $0
ffffffff8010812f:	6a 00                	push   $0x0
  push $76
ffffffff80108131:	6a 4c                	push   $0x4c
  jmp alltraps
ffffffff80108133:	e9 ed f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108138 <vector77>:
.globl vector77
vector77:
  push $0
ffffffff80108138:	6a 00                	push   $0x0
  push $77
ffffffff8010813a:	6a 4d                	push   $0x4d
  jmp alltraps
ffffffff8010813c:	e9 e4 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108141 <vector78>:
.globl vector78
vector78:
  push $0
ffffffff80108141:	6a 00                	push   $0x0
  push $78
ffffffff80108143:	6a 4e                	push   $0x4e
  jmp alltraps
ffffffff80108145:	e9 db f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010814a <vector79>:
.globl vector79
vector79:
  push $0
ffffffff8010814a:	6a 00                	push   $0x0
  push $79
ffffffff8010814c:	6a 4f                	push   $0x4f
  jmp alltraps
ffffffff8010814e:	e9 d2 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108153 <vector80>:
.globl vector80
vector80:
  push $0
ffffffff80108153:	6a 00                	push   $0x0
  push $80
ffffffff80108155:	6a 50                	push   $0x50
  jmp alltraps
ffffffff80108157:	e9 c9 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010815c <vector81>:
.globl vector81
vector81:
  push $0
ffffffff8010815c:	6a 00                	push   $0x0
  push $81
ffffffff8010815e:	6a 51                	push   $0x51
  jmp alltraps
ffffffff80108160:	e9 c0 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108165 <vector82>:
.globl vector82
vector82:
  push $0
ffffffff80108165:	6a 00                	push   $0x0
  push $82
ffffffff80108167:	6a 52                	push   $0x52
  jmp alltraps
ffffffff80108169:	e9 b7 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010816e <vector83>:
.globl vector83
vector83:
  push $0
ffffffff8010816e:	6a 00                	push   $0x0
  push $83
ffffffff80108170:	6a 53                	push   $0x53
  jmp alltraps
ffffffff80108172:	e9 ae f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108177 <vector84>:
.globl vector84
vector84:
  push $0
ffffffff80108177:	6a 00                	push   $0x0
  push $84
ffffffff80108179:	6a 54                	push   $0x54
  jmp alltraps
ffffffff8010817b:	e9 a5 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108180 <vector85>:
.globl vector85
vector85:
  push $0
ffffffff80108180:	6a 00                	push   $0x0
  push $85
ffffffff80108182:	6a 55                	push   $0x55
  jmp alltraps
ffffffff80108184:	e9 9c f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108189 <vector86>:
.globl vector86
vector86:
  push $0
ffffffff80108189:	6a 00                	push   $0x0
  push $86
ffffffff8010818b:	6a 56                	push   $0x56
  jmp alltraps
ffffffff8010818d:	e9 93 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108192 <vector87>:
.globl vector87
vector87:
  push $0
ffffffff80108192:	6a 00                	push   $0x0
  push $87
ffffffff80108194:	6a 57                	push   $0x57
  jmp alltraps
ffffffff80108196:	e9 8a f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010819b <vector88>:
.globl vector88
vector88:
  push $0
ffffffff8010819b:	6a 00                	push   $0x0
  push $88
ffffffff8010819d:	6a 58                	push   $0x58
  jmp alltraps
ffffffff8010819f:	e9 81 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081a4 <vector89>:
.globl vector89
vector89:
  push $0
ffffffff801081a4:	6a 00                	push   $0x0
  push $89
ffffffff801081a6:	6a 59                	push   $0x59
  jmp alltraps
ffffffff801081a8:	e9 78 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081ad <vector90>:
.globl vector90
vector90:
  push $0
ffffffff801081ad:	6a 00                	push   $0x0
  push $90
ffffffff801081af:	6a 5a                	push   $0x5a
  jmp alltraps
ffffffff801081b1:	e9 6f f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081b6 <vector91>:
.globl vector91
vector91:
  push $0
ffffffff801081b6:	6a 00                	push   $0x0
  push $91
ffffffff801081b8:	6a 5b                	push   $0x5b
  jmp alltraps
ffffffff801081ba:	e9 66 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081bf <vector92>:
.globl vector92
vector92:
  push $0
ffffffff801081bf:	6a 00                	push   $0x0
  push $92
ffffffff801081c1:	6a 5c                	push   $0x5c
  jmp alltraps
ffffffff801081c3:	e9 5d f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081c8 <vector93>:
.globl vector93
vector93:
  push $0
ffffffff801081c8:	6a 00                	push   $0x0
  push $93
ffffffff801081ca:	6a 5d                	push   $0x5d
  jmp alltraps
ffffffff801081cc:	e9 54 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081d1 <vector94>:
.globl vector94
vector94:
  push $0
ffffffff801081d1:	6a 00                	push   $0x0
  push $94
ffffffff801081d3:	6a 5e                	push   $0x5e
  jmp alltraps
ffffffff801081d5:	e9 4b f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081da <vector95>:
.globl vector95
vector95:
  push $0
ffffffff801081da:	6a 00                	push   $0x0
  push $95
ffffffff801081dc:	6a 5f                	push   $0x5f
  jmp alltraps
ffffffff801081de:	e9 42 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081e3 <vector96>:
.globl vector96
vector96:
  push $0
ffffffff801081e3:	6a 00                	push   $0x0
  push $96
ffffffff801081e5:	6a 60                	push   $0x60
  jmp alltraps
ffffffff801081e7:	e9 39 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081ec <vector97>:
.globl vector97
vector97:
  push $0
ffffffff801081ec:	6a 00                	push   $0x0
  push $97
ffffffff801081ee:	6a 61                	push   $0x61
  jmp alltraps
ffffffff801081f0:	e9 30 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081f5 <vector98>:
.globl vector98
vector98:
  push $0
ffffffff801081f5:	6a 00                	push   $0x0
  push $98
ffffffff801081f7:	6a 62                	push   $0x62
  jmp alltraps
ffffffff801081f9:	e9 27 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801081fe <vector99>:
.globl vector99
vector99:
  push $0
ffffffff801081fe:	6a 00                	push   $0x0
  push $99
ffffffff80108200:	6a 63                	push   $0x63
  jmp alltraps
ffffffff80108202:	e9 1e f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108207 <vector100>:
.globl vector100
vector100:
  push $0
ffffffff80108207:	6a 00                	push   $0x0
  push $100
ffffffff80108209:	6a 64                	push   $0x64
  jmp alltraps
ffffffff8010820b:	e9 15 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108210 <vector101>:
.globl vector101
vector101:
  push $0
ffffffff80108210:	6a 00                	push   $0x0
  push $101
ffffffff80108212:	6a 65                	push   $0x65
  jmp alltraps
ffffffff80108214:	e9 0c f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108219 <vector102>:
.globl vector102
vector102:
  push $0
ffffffff80108219:	6a 00                	push   $0x0
  push $102
ffffffff8010821b:	6a 66                	push   $0x66
  jmp alltraps
ffffffff8010821d:	e9 03 f7 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108222 <vector103>:
.globl vector103
vector103:
  push $0
ffffffff80108222:	6a 00                	push   $0x0
  push $103
ffffffff80108224:	6a 67                	push   $0x67
  jmp alltraps
ffffffff80108226:	e9 fa f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010822b <vector104>:
.globl vector104
vector104:
  push $0
ffffffff8010822b:	6a 00                	push   $0x0
  push $104
ffffffff8010822d:	6a 68                	push   $0x68
  jmp alltraps
ffffffff8010822f:	e9 f1 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108234 <vector105>:
.globl vector105
vector105:
  push $0
ffffffff80108234:	6a 00                	push   $0x0
  push $105
ffffffff80108236:	6a 69                	push   $0x69
  jmp alltraps
ffffffff80108238:	e9 e8 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010823d <vector106>:
.globl vector106
vector106:
  push $0
ffffffff8010823d:	6a 00                	push   $0x0
  push $106
ffffffff8010823f:	6a 6a                	push   $0x6a
  jmp alltraps
ffffffff80108241:	e9 df f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108246 <vector107>:
.globl vector107
vector107:
  push $0
ffffffff80108246:	6a 00                	push   $0x0
  push $107
ffffffff80108248:	6a 6b                	push   $0x6b
  jmp alltraps
ffffffff8010824a:	e9 d6 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010824f <vector108>:
.globl vector108
vector108:
  push $0
ffffffff8010824f:	6a 00                	push   $0x0
  push $108
ffffffff80108251:	6a 6c                	push   $0x6c
  jmp alltraps
ffffffff80108253:	e9 cd f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108258 <vector109>:
.globl vector109
vector109:
  push $0
ffffffff80108258:	6a 00                	push   $0x0
  push $109
ffffffff8010825a:	6a 6d                	push   $0x6d
  jmp alltraps
ffffffff8010825c:	e9 c4 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108261 <vector110>:
.globl vector110
vector110:
  push $0
ffffffff80108261:	6a 00                	push   $0x0
  push $110
ffffffff80108263:	6a 6e                	push   $0x6e
  jmp alltraps
ffffffff80108265:	e9 bb f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010826a <vector111>:
.globl vector111
vector111:
  push $0
ffffffff8010826a:	6a 00                	push   $0x0
  push $111
ffffffff8010826c:	6a 6f                	push   $0x6f
  jmp alltraps
ffffffff8010826e:	e9 b2 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108273 <vector112>:
.globl vector112
vector112:
  push $0
ffffffff80108273:	6a 00                	push   $0x0
  push $112
ffffffff80108275:	6a 70                	push   $0x70
  jmp alltraps
ffffffff80108277:	e9 a9 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010827c <vector113>:
.globl vector113
vector113:
  push $0
ffffffff8010827c:	6a 00                	push   $0x0
  push $113
ffffffff8010827e:	6a 71                	push   $0x71
  jmp alltraps
ffffffff80108280:	e9 a0 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108285 <vector114>:
.globl vector114
vector114:
  push $0
ffffffff80108285:	6a 00                	push   $0x0
  push $114
ffffffff80108287:	6a 72                	push   $0x72
  jmp alltraps
ffffffff80108289:	e9 97 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010828e <vector115>:
.globl vector115
vector115:
  push $0
ffffffff8010828e:	6a 00                	push   $0x0
  push $115
ffffffff80108290:	6a 73                	push   $0x73
  jmp alltraps
ffffffff80108292:	e9 8e f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108297 <vector116>:
.globl vector116
vector116:
  push $0
ffffffff80108297:	6a 00                	push   $0x0
  push $116
ffffffff80108299:	6a 74                	push   $0x74
  jmp alltraps
ffffffff8010829b:	e9 85 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082a0 <vector117>:
.globl vector117
vector117:
  push $0
ffffffff801082a0:	6a 00                	push   $0x0
  push $117
ffffffff801082a2:	6a 75                	push   $0x75
  jmp alltraps
ffffffff801082a4:	e9 7c f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082a9 <vector118>:
.globl vector118
vector118:
  push $0
ffffffff801082a9:	6a 00                	push   $0x0
  push $118
ffffffff801082ab:	6a 76                	push   $0x76
  jmp alltraps
ffffffff801082ad:	e9 73 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082b2 <vector119>:
.globl vector119
vector119:
  push $0
ffffffff801082b2:	6a 00                	push   $0x0
  push $119
ffffffff801082b4:	6a 77                	push   $0x77
  jmp alltraps
ffffffff801082b6:	e9 6a f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082bb <vector120>:
.globl vector120
vector120:
  push $0
ffffffff801082bb:	6a 00                	push   $0x0
  push $120
ffffffff801082bd:	6a 78                	push   $0x78
  jmp alltraps
ffffffff801082bf:	e9 61 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082c4 <vector121>:
.globl vector121
vector121:
  push $0
ffffffff801082c4:	6a 00                	push   $0x0
  push $121
ffffffff801082c6:	6a 79                	push   $0x79
  jmp alltraps
ffffffff801082c8:	e9 58 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082cd <vector122>:
.globl vector122
vector122:
  push $0
ffffffff801082cd:	6a 00                	push   $0x0
  push $122
ffffffff801082cf:	6a 7a                	push   $0x7a
  jmp alltraps
ffffffff801082d1:	e9 4f f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082d6 <vector123>:
.globl vector123
vector123:
  push $0
ffffffff801082d6:	6a 00                	push   $0x0
  push $123
ffffffff801082d8:	6a 7b                	push   $0x7b
  jmp alltraps
ffffffff801082da:	e9 46 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082df <vector124>:
.globl vector124
vector124:
  push $0
ffffffff801082df:	6a 00                	push   $0x0
  push $124
ffffffff801082e1:	6a 7c                	push   $0x7c
  jmp alltraps
ffffffff801082e3:	e9 3d f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082e8 <vector125>:
.globl vector125
vector125:
  push $0
ffffffff801082e8:	6a 00                	push   $0x0
  push $125
ffffffff801082ea:	6a 7d                	push   $0x7d
  jmp alltraps
ffffffff801082ec:	e9 34 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082f1 <vector126>:
.globl vector126
vector126:
  push $0
ffffffff801082f1:	6a 00                	push   $0x0
  push $126
ffffffff801082f3:	6a 7e                	push   $0x7e
  jmp alltraps
ffffffff801082f5:	e9 2b f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801082fa <vector127>:
.globl vector127
vector127:
  push $0
ffffffff801082fa:	6a 00                	push   $0x0
  push $127
ffffffff801082fc:	6a 7f                	push   $0x7f
  jmp alltraps
ffffffff801082fe:	e9 22 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108303 <vector128>:
.globl vector128
vector128:
  push $0
ffffffff80108303:	6a 00                	push   $0x0
  push $128
ffffffff80108305:	68 80 00 00 00       	push   $0x80
  jmp alltraps
ffffffff8010830a:	e9 16 f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010830f <vector129>:
.globl vector129
vector129:
  push $0
ffffffff8010830f:	6a 00                	push   $0x0
  push $129
ffffffff80108311:	68 81 00 00 00       	push   $0x81
  jmp alltraps
ffffffff80108316:	e9 0a f6 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010831b <vector130>:
.globl vector130
vector130:
  push $0
ffffffff8010831b:	6a 00                	push   $0x0
  push $130
ffffffff8010831d:	68 82 00 00 00       	push   $0x82
  jmp alltraps
ffffffff80108322:	e9 fe f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108327 <vector131>:
.globl vector131
vector131:
  push $0
ffffffff80108327:	6a 00                	push   $0x0
  push $131
ffffffff80108329:	68 83 00 00 00       	push   $0x83
  jmp alltraps
ffffffff8010832e:	e9 f2 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108333 <vector132>:
.globl vector132
vector132:
  push $0
ffffffff80108333:	6a 00                	push   $0x0
  push $132
ffffffff80108335:	68 84 00 00 00       	push   $0x84
  jmp alltraps
ffffffff8010833a:	e9 e6 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010833f <vector133>:
.globl vector133
vector133:
  push $0
ffffffff8010833f:	6a 00                	push   $0x0
  push $133
ffffffff80108341:	68 85 00 00 00       	push   $0x85
  jmp alltraps
ffffffff80108346:	e9 da f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010834b <vector134>:
.globl vector134
vector134:
  push $0
ffffffff8010834b:	6a 00                	push   $0x0
  push $134
ffffffff8010834d:	68 86 00 00 00       	push   $0x86
  jmp alltraps
ffffffff80108352:	e9 ce f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108357 <vector135>:
.globl vector135
vector135:
  push $0
ffffffff80108357:	6a 00                	push   $0x0
  push $135
ffffffff80108359:	68 87 00 00 00       	push   $0x87
  jmp alltraps
ffffffff8010835e:	e9 c2 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108363 <vector136>:
.globl vector136
vector136:
  push $0
ffffffff80108363:	6a 00                	push   $0x0
  push $136
ffffffff80108365:	68 88 00 00 00       	push   $0x88
  jmp alltraps
ffffffff8010836a:	e9 b6 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010836f <vector137>:
.globl vector137
vector137:
  push $0
ffffffff8010836f:	6a 00                	push   $0x0
  push $137
ffffffff80108371:	68 89 00 00 00       	push   $0x89
  jmp alltraps
ffffffff80108376:	e9 aa f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010837b <vector138>:
.globl vector138
vector138:
  push $0
ffffffff8010837b:	6a 00                	push   $0x0
  push $138
ffffffff8010837d:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
ffffffff80108382:	e9 9e f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108387 <vector139>:
.globl vector139
vector139:
  push $0
ffffffff80108387:	6a 00                	push   $0x0
  push $139
ffffffff80108389:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
ffffffff8010838e:	e9 92 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108393 <vector140>:
.globl vector140
vector140:
  push $0
ffffffff80108393:	6a 00                	push   $0x0
  push $140
ffffffff80108395:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
ffffffff8010839a:	e9 86 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010839f <vector141>:
.globl vector141
vector141:
  push $0
ffffffff8010839f:	6a 00                	push   $0x0
  push $141
ffffffff801083a1:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
ffffffff801083a6:	e9 7a f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801083ab <vector142>:
.globl vector142
vector142:
  push $0
ffffffff801083ab:	6a 00                	push   $0x0
  push $142
ffffffff801083ad:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
ffffffff801083b2:	e9 6e f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801083b7 <vector143>:
.globl vector143
vector143:
  push $0
ffffffff801083b7:	6a 00                	push   $0x0
  push $143
ffffffff801083b9:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
ffffffff801083be:	e9 62 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801083c3 <vector144>:
.globl vector144
vector144:
  push $0
ffffffff801083c3:	6a 00                	push   $0x0
  push $144
ffffffff801083c5:	68 90 00 00 00       	push   $0x90
  jmp alltraps
ffffffff801083ca:	e9 56 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801083cf <vector145>:
.globl vector145
vector145:
  push $0
ffffffff801083cf:	6a 00                	push   $0x0
  push $145
ffffffff801083d1:	68 91 00 00 00       	push   $0x91
  jmp alltraps
ffffffff801083d6:	e9 4a f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801083db <vector146>:
.globl vector146
vector146:
  push $0
ffffffff801083db:	6a 00                	push   $0x0
  push $146
ffffffff801083dd:	68 92 00 00 00       	push   $0x92
  jmp alltraps
ffffffff801083e2:	e9 3e f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801083e7 <vector147>:
.globl vector147
vector147:
  push $0
ffffffff801083e7:	6a 00                	push   $0x0
  push $147
ffffffff801083e9:	68 93 00 00 00       	push   $0x93
  jmp alltraps
ffffffff801083ee:	e9 32 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801083f3 <vector148>:
.globl vector148
vector148:
  push $0
ffffffff801083f3:	6a 00                	push   $0x0
  push $148
ffffffff801083f5:	68 94 00 00 00       	push   $0x94
  jmp alltraps
ffffffff801083fa:	e9 26 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801083ff <vector149>:
.globl vector149
vector149:
  push $0
ffffffff801083ff:	6a 00                	push   $0x0
  push $149
ffffffff80108401:	68 95 00 00 00       	push   $0x95
  jmp alltraps
ffffffff80108406:	e9 1a f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010840b <vector150>:
.globl vector150
vector150:
  push $0
ffffffff8010840b:	6a 00                	push   $0x0
  push $150
ffffffff8010840d:	68 96 00 00 00       	push   $0x96
  jmp alltraps
ffffffff80108412:	e9 0e f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108417 <vector151>:
.globl vector151
vector151:
  push $0
ffffffff80108417:	6a 00                	push   $0x0
  push $151
ffffffff80108419:	68 97 00 00 00       	push   $0x97
  jmp alltraps
ffffffff8010841e:	e9 02 f5 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108423 <vector152>:
.globl vector152
vector152:
  push $0
ffffffff80108423:	6a 00                	push   $0x0
  push $152
ffffffff80108425:	68 98 00 00 00       	push   $0x98
  jmp alltraps
ffffffff8010842a:	e9 f6 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010842f <vector153>:
.globl vector153
vector153:
  push $0
ffffffff8010842f:	6a 00                	push   $0x0
  push $153
ffffffff80108431:	68 99 00 00 00       	push   $0x99
  jmp alltraps
ffffffff80108436:	e9 ea f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010843b <vector154>:
.globl vector154
vector154:
  push $0
ffffffff8010843b:	6a 00                	push   $0x0
  push $154
ffffffff8010843d:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
ffffffff80108442:	e9 de f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108447 <vector155>:
.globl vector155
vector155:
  push $0
ffffffff80108447:	6a 00                	push   $0x0
  push $155
ffffffff80108449:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
ffffffff8010844e:	e9 d2 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108453 <vector156>:
.globl vector156
vector156:
  push $0
ffffffff80108453:	6a 00                	push   $0x0
  push $156
ffffffff80108455:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
ffffffff8010845a:	e9 c6 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010845f <vector157>:
.globl vector157
vector157:
  push $0
ffffffff8010845f:	6a 00                	push   $0x0
  push $157
ffffffff80108461:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
ffffffff80108466:	e9 ba f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010846b <vector158>:
.globl vector158
vector158:
  push $0
ffffffff8010846b:	6a 00                	push   $0x0
  push $158
ffffffff8010846d:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
ffffffff80108472:	e9 ae f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108477 <vector159>:
.globl vector159
vector159:
  push $0
ffffffff80108477:	6a 00                	push   $0x0
  push $159
ffffffff80108479:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
ffffffff8010847e:	e9 a2 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108483 <vector160>:
.globl vector160
vector160:
  push $0
ffffffff80108483:	6a 00                	push   $0x0
  push $160
ffffffff80108485:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
ffffffff8010848a:	e9 96 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010848f <vector161>:
.globl vector161
vector161:
  push $0
ffffffff8010848f:	6a 00                	push   $0x0
  push $161
ffffffff80108491:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
ffffffff80108496:	e9 8a f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010849b <vector162>:
.globl vector162
vector162:
  push $0
ffffffff8010849b:	6a 00                	push   $0x0
  push $162
ffffffff8010849d:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
ffffffff801084a2:	e9 7e f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801084a7 <vector163>:
.globl vector163
vector163:
  push $0
ffffffff801084a7:	6a 00                	push   $0x0
  push $163
ffffffff801084a9:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
ffffffff801084ae:	e9 72 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801084b3 <vector164>:
.globl vector164
vector164:
  push $0
ffffffff801084b3:	6a 00                	push   $0x0
  push $164
ffffffff801084b5:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
ffffffff801084ba:	e9 66 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801084bf <vector165>:
.globl vector165
vector165:
  push $0
ffffffff801084bf:	6a 00                	push   $0x0
  push $165
ffffffff801084c1:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
ffffffff801084c6:	e9 5a f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801084cb <vector166>:
.globl vector166
vector166:
  push $0
ffffffff801084cb:	6a 00                	push   $0x0
  push $166
ffffffff801084cd:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
ffffffff801084d2:	e9 4e f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801084d7 <vector167>:
.globl vector167
vector167:
  push $0
ffffffff801084d7:	6a 00                	push   $0x0
  push $167
ffffffff801084d9:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
ffffffff801084de:	e9 42 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801084e3 <vector168>:
.globl vector168
vector168:
  push $0
ffffffff801084e3:	6a 00                	push   $0x0
  push $168
ffffffff801084e5:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
ffffffff801084ea:	e9 36 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801084ef <vector169>:
.globl vector169
vector169:
  push $0
ffffffff801084ef:	6a 00                	push   $0x0
  push $169
ffffffff801084f1:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
ffffffff801084f6:	e9 2a f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801084fb <vector170>:
.globl vector170
vector170:
  push $0
ffffffff801084fb:	6a 00                	push   $0x0
  push $170
ffffffff801084fd:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
ffffffff80108502:	e9 1e f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108507 <vector171>:
.globl vector171
vector171:
  push $0
ffffffff80108507:	6a 00                	push   $0x0
  push $171
ffffffff80108509:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
ffffffff8010850e:	e9 12 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108513 <vector172>:
.globl vector172
vector172:
  push $0
ffffffff80108513:	6a 00                	push   $0x0
  push $172
ffffffff80108515:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
ffffffff8010851a:	e9 06 f4 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010851f <vector173>:
.globl vector173
vector173:
  push $0
ffffffff8010851f:	6a 00                	push   $0x0
  push $173
ffffffff80108521:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
ffffffff80108526:	e9 fa f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010852b <vector174>:
.globl vector174
vector174:
  push $0
ffffffff8010852b:	6a 00                	push   $0x0
  push $174
ffffffff8010852d:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
ffffffff80108532:	e9 ee f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108537 <vector175>:
.globl vector175
vector175:
  push $0
ffffffff80108537:	6a 00                	push   $0x0
  push $175
ffffffff80108539:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
ffffffff8010853e:	e9 e2 f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108543 <vector176>:
.globl vector176
vector176:
  push $0
ffffffff80108543:	6a 00                	push   $0x0
  push $176
ffffffff80108545:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
ffffffff8010854a:	e9 d6 f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010854f <vector177>:
.globl vector177
vector177:
  push $0
ffffffff8010854f:	6a 00                	push   $0x0
  push $177
ffffffff80108551:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
ffffffff80108556:	e9 ca f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010855b <vector178>:
.globl vector178
vector178:
  push $0
ffffffff8010855b:	6a 00                	push   $0x0
  push $178
ffffffff8010855d:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
ffffffff80108562:	e9 be f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108567 <vector179>:
.globl vector179
vector179:
  push $0
ffffffff80108567:	6a 00                	push   $0x0
  push $179
ffffffff80108569:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
ffffffff8010856e:	e9 b2 f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108573 <vector180>:
.globl vector180
vector180:
  push $0
ffffffff80108573:	6a 00                	push   $0x0
  push $180
ffffffff80108575:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
ffffffff8010857a:	e9 a6 f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010857f <vector181>:
.globl vector181
vector181:
  push $0
ffffffff8010857f:	6a 00                	push   $0x0
  push $181
ffffffff80108581:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
ffffffff80108586:	e9 9a f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010858b <vector182>:
.globl vector182
vector182:
  push $0
ffffffff8010858b:	6a 00                	push   $0x0
  push $182
ffffffff8010858d:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
ffffffff80108592:	e9 8e f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108597 <vector183>:
.globl vector183
vector183:
  push $0
ffffffff80108597:	6a 00                	push   $0x0
  push $183
ffffffff80108599:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
ffffffff8010859e:	e9 82 f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801085a3 <vector184>:
.globl vector184
vector184:
  push $0
ffffffff801085a3:	6a 00                	push   $0x0
  push $184
ffffffff801085a5:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
ffffffff801085aa:	e9 76 f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801085af <vector185>:
.globl vector185
vector185:
  push $0
ffffffff801085af:	6a 00                	push   $0x0
  push $185
ffffffff801085b1:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
ffffffff801085b6:	e9 6a f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801085bb <vector186>:
.globl vector186
vector186:
  push $0
ffffffff801085bb:	6a 00                	push   $0x0
  push $186
ffffffff801085bd:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
ffffffff801085c2:	e9 5e f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801085c7 <vector187>:
.globl vector187
vector187:
  push $0
ffffffff801085c7:	6a 00                	push   $0x0
  push $187
ffffffff801085c9:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
ffffffff801085ce:	e9 52 f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801085d3 <vector188>:
.globl vector188
vector188:
  push $0
ffffffff801085d3:	6a 00                	push   $0x0
  push $188
ffffffff801085d5:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
ffffffff801085da:	e9 46 f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801085df <vector189>:
.globl vector189
vector189:
  push $0
ffffffff801085df:	6a 00                	push   $0x0
  push $189
ffffffff801085e1:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
ffffffff801085e6:	e9 3a f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801085eb <vector190>:
.globl vector190
vector190:
  push $0
ffffffff801085eb:	6a 00                	push   $0x0
  push $190
ffffffff801085ed:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
ffffffff801085f2:	e9 2e f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801085f7 <vector191>:
.globl vector191
vector191:
  push $0
ffffffff801085f7:	6a 00                	push   $0x0
  push $191
ffffffff801085f9:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
ffffffff801085fe:	e9 22 f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108603 <vector192>:
.globl vector192
vector192:
  push $0
ffffffff80108603:	6a 00                	push   $0x0
  push $192
ffffffff80108605:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
ffffffff8010860a:	e9 16 f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010860f <vector193>:
.globl vector193
vector193:
  push $0
ffffffff8010860f:	6a 00                	push   $0x0
  push $193
ffffffff80108611:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
ffffffff80108616:	e9 0a f3 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010861b <vector194>:
.globl vector194
vector194:
  push $0
ffffffff8010861b:	6a 00                	push   $0x0
  push $194
ffffffff8010861d:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
ffffffff80108622:	e9 fe f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108627 <vector195>:
.globl vector195
vector195:
  push $0
ffffffff80108627:	6a 00                	push   $0x0
  push $195
ffffffff80108629:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
ffffffff8010862e:	e9 f2 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108633 <vector196>:
.globl vector196
vector196:
  push $0
ffffffff80108633:	6a 00                	push   $0x0
  push $196
ffffffff80108635:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
ffffffff8010863a:	e9 e6 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010863f <vector197>:
.globl vector197
vector197:
  push $0
ffffffff8010863f:	6a 00                	push   $0x0
  push $197
ffffffff80108641:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
ffffffff80108646:	e9 da f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010864b <vector198>:
.globl vector198
vector198:
  push $0
ffffffff8010864b:	6a 00                	push   $0x0
  push $198
ffffffff8010864d:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
ffffffff80108652:	e9 ce f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108657 <vector199>:
.globl vector199
vector199:
  push $0
ffffffff80108657:	6a 00                	push   $0x0
  push $199
ffffffff80108659:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
ffffffff8010865e:	e9 c2 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108663 <vector200>:
.globl vector200
vector200:
  push $0
ffffffff80108663:	6a 00                	push   $0x0
  push $200
ffffffff80108665:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
ffffffff8010866a:	e9 b6 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010866f <vector201>:
.globl vector201
vector201:
  push $0
ffffffff8010866f:	6a 00                	push   $0x0
  push $201
ffffffff80108671:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
ffffffff80108676:	e9 aa f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010867b <vector202>:
.globl vector202
vector202:
  push $0
ffffffff8010867b:	6a 00                	push   $0x0
  push $202
ffffffff8010867d:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
ffffffff80108682:	e9 9e f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108687 <vector203>:
.globl vector203
vector203:
  push $0
ffffffff80108687:	6a 00                	push   $0x0
  push $203
ffffffff80108689:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
ffffffff8010868e:	e9 92 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108693 <vector204>:
.globl vector204
vector204:
  push $0
ffffffff80108693:	6a 00                	push   $0x0
  push $204
ffffffff80108695:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
ffffffff8010869a:	e9 86 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010869f <vector205>:
.globl vector205
vector205:
  push $0
ffffffff8010869f:	6a 00                	push   $0x0
  push $205
ffffffff801086a1:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
ffffffff801086a6:	e9 7a f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801086ab <vector206>:
.globl vector206
vector206:
  push $0
ffffffff801086ab:	6a 00                	push   $0x0
  push $206
ffffffff801086ad:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
ffffffff801086b2:	e9 6e f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801086b7 <vector207>:
.globl vector207
vector207:
  push $0
ffffffff801086b7:	6a 00                	push   $0x0
  push $207
ffffffff801086b9:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
ffffffff801086be:	e9 62 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801086c3 <vector208>:
.globl vector208
vector208:
  push $0
ffffffff801086c3:	6a 00                	push   $0x0
  push $208
ffffffff801086c5:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
ffffffff801086ca:	e9 56 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801086cf <vector209>:
.globl vector209
vector209:
  push $0
ffffffff801086cf:	6a 00                	push   $0x0
  push $209
ffffffff801086d1:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
ffffffff801086d6:	e9 4a f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801086db <vector210>:
.globl vector210
vector210:
  push $0
ffffffff801086db:	6a 00                	push   $0x0
  push $210
ffffffff801086dd:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
ffffffff801086e2:	e9 3e f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801086e7 <vector211>:
.globl vector211
vector211:
  push $0
ffffffff801086e7:	6a 00                	push   $0x0
  push $211
ffffffff801086e9:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
ffffffff801086ee:	e9 32 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801086f3 <vector212>:
.globl vector212
vector212:
  push $0
ffffffff801086f3:	6a 00                	push   $0x0
  push $212
ffffffff801086f5:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
ffffffff801086fa:	e9 26 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801086ff <vector213>:
.globl vector213
vector213:
  push $0
ffffffff801086ff:	6a 00                	push   $0x0
  push $213
ffffffff80108701:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
ffffffff80108706:	e9 1a f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010870b <vector214>:
.globl vector214
vector214:
  push $0
ffffffff8010870b:	6a 00                	push   $0x0
  push $214
ffffffff8010870d:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
ffffffff80108712:	e9 0e f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108717 <vector215>:
.globl vector215
vector215:
  push $0
ffffffff80108717:	6a 00                	push   $0x0
  push $215
ffffffff80108719:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
ffffffff8010871e:	e9 02 f2 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108723 <vector216>:
.globl vector216
vector216:
  push $0
ffffffff80108723:	6a 00                	push   $0x0
  push $216
ffffffff80108725:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
ffffffff8010872a:	e9 f6 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010872f <vector217>:
.globl vector217
vector217:
  push $0
ffffffff8010872f:	6a 00                	push   $0x0
  push $217
ffffffff80108731:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
ffffffff80108736:	e9 ea f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010873b <vector218>:
.globl vector218
vector218:
  push $0
ffffffff8010873b:	6a 00                	push   $0x0
  push $218
ffffffff8010873d:	68 da 00 00 00       	push   $0xda
  jmp alltraps
ffffffff80108742:	e9 de f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108747 <vector219>:
.globl vector219
vector219:
  push $0
ffffffff80108747:	6a 00                	push   $0x0
  push $219
ffffffff80108749:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
ffffffff8010874e:	e9 d2 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108753 <vector220>:
.globl vector220
vector220:
  push $0
ffffffff80108753:	6a 00                	push   $0x0
  push $220
ffffffff80108755:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
ffffffff8010875a:	e9 c6 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010875f <vector221>:
.globl vector221
vector221:
  push $0
ffffffff8010875f:	6a 00                	push   $0x0
  push $221
ffffffff80108761:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
ffffffff80108766:	e9 ba f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010876b <vector222>:
.globl vector222
vector222:
  push $0
ffffffff8010876b:	6a 00                	push   $0x0
  push $222
ffffffff8010876d:	68 de 00 00 00       	push   $0xde
  jmp alltraps
ffffffff80108772:	e9 ae f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108777 <vector223>:
.globl vector223
vector223:
  push $0
ffffffff80108777:	6a 00                	push   $0x0
  push $223
ffffffff80108779:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
ffffffff8010877e:	e9 a2 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108783 <vector224>:
.globl vector224
vector224:
  push $0
ffffffff80108783:	6a 00                	push   $0x0
  push $224
ffffffff80108785:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
ffffffff8010878a:	e9 96 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010878f <vector225>:
.globl vector225
vector225:
  push $0
ffffffff8010878f:	6a 00                	push   $0x0
  push $225
ffffffff80108791:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
ffffffff80108796:	e9 8a f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010879b <vector226>:
.globl vector226
vector226:
  push $0
ffffffff8010879b:	6a 00                	push   $0x0
  push $226
ffffffff8010879d:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
ffffffff801087a2:	e9 7e f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801087a7 <vector227>:
.globl vector227
vector227:
  push $0
ffffffff801087a7:	6a 00                	push   $0x0
  push $227
ffffffff801087a9:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
ffffffff801087ae:	e9 72 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801087b3 <vector228>:
.globl vector228
vector228:
  push $0
ffffffff801087b3:	6a 00                	push   $0x0
  push $228
ffffffff801087b5:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
ffffffff801087ba:	e9 66 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801087bf <vector229>:
.globl vector229
vector229:
  push $0
ffffffff801087bf:	6a 00                	push   $0x0
  push $229
ffffffff801087c1:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
ffffffff801087c6:	e9 5a f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801087cb <vector230>:
.globl vector230
vector230:
  push $0
ffffffff801087cb:	6a 00                	push   $0x0
  push $230
ffffffff801087cd:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
ffffffff801087d2:	e9 4e f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801087d7 <vector231>:
.globl vector231
vector231:
  push $0
ffffffff801087d7:	6a 00                	push   $0x0
  push $231
ffffffff801087d9:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
ffffffff801087de:	e9 42 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801087e3 <vector232>:
.globl vector232
vector232:
  push $0
ffffffff801087e3:	6a 00                	push   $0x0
  push $232
ffffffff801087e5:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
ffffffff801087ea:	e9 36 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801087ef <vector233>:
.globl vector233
vector233:
  push $0
ffffffff801087ef:	6a 00                	push   $0x0
  push $233
ffffffff801087f1:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
ffffffff801087f6:	e9 2a f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801087fb <vector234>:
.globl vector234
vector234:
  push $0
ffffffff801087fb:	6a 00                	push   $0x0
  push $234
ffffffff801087fd:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
ffffffff80108802:	e9 1e f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108807 <vector235>:
.globl vector235
vector235:
  push $0
ffffffff80108807:	6a 00                	push   $0x0
  push $235
ffffffff80108809:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
ffffffff8010880e:	e9 12 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108813 <vector236>:
.globl vector236
vector236:
  push $0
ffffffff80108813:	6a 00                	push   $0x0
  push $236
ffffffff80108815:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
ffffffff8010881a:	e9 06 f1 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010881f <vector237>:
.globl vector237
vector237:
  push $0
ffffffff8010881f:	6a 00                	push   $0x0
  push $237
ffffffff80108821:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
ffffffff80108826:	e9 fa f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010882b <vector238>:
.globl vector238
vector238:
  push $0
ffffffff8010882b:	6a 00                	push   $0x0
  push $238
ffffffff8010882d:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
ffffffff80108832:	e9 ee f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108837 <vector239>:
.globl vector239
vector239:
  push $0
ffffffff80108837:	6a 00                	push   $0x0
  push $239
ffffffff80108839:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
ffffffff8010883e:	e9 e2 f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108843 <vector240>:
.globl vector240
vector240:
  push $0
ffffffff80108843:	6a 00                	push   $0x0
  push $240
ffffffff80108845:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
ffffffff8010884a:	e9 d6 f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010884f <vector241>:
.globl vector241
vector241:
  push $0
ffffffff8010884f:	6a 00                	push   $0x0
  push $241
ffffffff80108851:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
ffffffff80108856:	e9 ca f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010885b <vector242>:
.globl vector242
vector242:
  push $0
ffffffff8010885b:	6a 00                	push   $0x0
  push $242
ffffffff8010885d:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
ffffffff80108862:	e9 be f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108867 <vector243>:
.globl vector243
vector243:
  push $0
ffffffff80108867:	6a 00                	push   $0x0
  push $243
ffffffff80108869:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
ffffffff8010886e:	e9 b2 f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108873 <vector244>:
.globl vector244
vector244:
  push $0
ffffffff80108873:	6a 00                	push   $0x0
  push $244
ffffffff80108875:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
ffffffff8010887a:	e9 a6 f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010887f <vector245>:
.globl vector245
vector245:
  push $0
ffffffff8010887f:	6a 00                	push   $0x0
  push $245
ffffffff80108881:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
ffffffff80108886:	e9 9a f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff8010888b <vector246>:
.globl vector246
vector246:
  push $0
ffffffff8010888b:	6a 00                	push   $0x0
  push $246
ffffffff8010888d:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
ffffffff80108892:	e9 8e f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108897 <vector247>:
.globl vector247
vector247:
  push $0
ffffffff80108897:	6a 00                	push   $0x0
  push $247
ffffffff80108899:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
ffffffff8010889e:	e9 82 f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801088a3 <vector248>:
.globl vector248
vector248:
  push $0
ffffffff801088a3:	6a 00                	push   $0x0
  push $248
ffffffff801088a5:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
ffffffff801088aa:	e9 76 f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801088af <vector249>:
.globl vector249
vector249:
  push $0
ffffffff801088af:	6a 00                	push   $0x0
  push $249
ffffffff801088b1:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
ffffffff801088b6:	e9 6a f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801088bb <vector250>:
.globl vector250
vector250:
  push $0
ffffffff801088bb:	6a 00                	push   $0x0
  push $250
ffffffff801088bd:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
ffffffff801088c2:	e9 5e f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801088c7 <vector251>:
.globl vector251
vector251:
  push $0
ffffffff801088c7:	6a 00                	push   $0x0
  push $251
ffffffff801088c9:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
ffffffff801088ce:	e9 52 f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801088d3 <vector252>:
.globl vector252
vector252:
  push $0
ffffffff801088d3:	6a 00                	push   $0x0
  push $252
ffffffff801088d5:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
ffffffff801088da:	e9 46 f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801088df <vector253>:
.globl vector253
vector253:
  push $0
ffffffff801088df:	6a 00                	push   $0x0
  push $253
ffffffff801088e1:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
ffffffff801088e6:	e9 3a f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801088eb <vector254>:
.globl vector254
vector254:
  push $0
ffffffff801088eb:	6a 00                	push   $0x0
  push $254
ffffffff801088ed:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
ffffffff801088f2:	e9 2e f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff801088f7 <vector255>:
.globl vector255
vector255:
  push $0
ffffffff801088f7:	6a 00                	push   $0x0
  push $255
ffffffff801088f9:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
ffffffff801088fe:	e9 22 f0 ff ff       	jmp    ffffffff80107925 <alltraps>

ffffffff80108903 <v2p>:
static inline uintp v2p(void *a) { return ((uintp) (a)) - ((uintp)KERNBASE); }
ffffffff80108903:	55                   	push   %rbp
ffffffff80108904:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108907:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff8010890b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010890f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108913:	ba 00 00 00 80       	mov    $0x80000000,%edx
ffffffff80108918:	48 01 d0             	add    %rdx,%rax
ffffffff8010891b:	c9                   	leave
ffffffff8010891c:	c3                   	ret

ffffffff8010891d <p2v>:
static inline void *p2v(uintp a) { return (void *) ((a) + ((uintp)KERNBASE)); }
ffffffff8010891d:	55                   	push   %rbp
ffffffff8010891e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108921:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80108925:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80108929:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010892d:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
ffffffff80108933:	c9                   	leave
ffffffff80108934:	c3                   	ret

ffffffff80108935 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
ffffffff80108935:	55                   	push   %rbp
ffffffff80108936:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108939:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff8010893d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80108941:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80108945:	89 55 dc             	mov    %edx,-0x24(%rbp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
ffffffff80108948:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010894c:	48 c1 e8 15          	shr    $0x15,%rax
ffffffff80108950:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff80108955:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff8010895c:	00 
ffffffff8010895d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108961:	48 01 d0             	add    %rdx,%rax
ffffffff80108964:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(*pde & PTE_P){
ffffffff80108968:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010896c:	48 8b 00             	mov    (%rax),%rax
ffffffff8010896f:	83 e0 01             	and    $0x1,%eax
ffffffff80108972:	48 85 c0             	test   %rax,%rax
ffffffff80108975:	74 1b                	je     ffffffff80108992 <walkpgdir+0x5d>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
ffffffff80108977:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010897b:	48 8b 00             	mov    (%rax),%rax
ffffffff8010897e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108984:	48 89 c7             	mov    %rax,%rdi
ffffffff80108987:	e8 91 ff ff ff       	call   ffffffff8010891d <p2v>
ffffffff8010898c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80108990:	eb 4d                	jmp    ffffffff801089df <walkpgdir+0xaa>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
ffffffff80108992:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffffffff80108996:	74 10                	je     ffffffff801089a8 <walkpgdir+0x73>
ffffffff80108998:	e8 3c a9 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff8010899d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff801089a1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801089a6:	75 07                	jne    ffffffff801089af <walkpgdir+0x7a>
      return 0;
ffffffff801089a8:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff801089ad:	eb 4c                	jmp    ffffffff801089fb <walkpgdir+0xc6>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
ffffffff801089af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801089b3:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801089b8:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801089bd:	48 89 c7             	mov    %rax,%rdi
ffffffff801089c0:	e8 8e d5 ff ff       	call   ffffffff80105f53 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
ffffffff801089c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801089c9:	48 89 c7             	mov    %rax,%rdi
ffffffff801089cc:	e8 32 ff ff ff       	call   ffffffff80108903 <v2p>
ffffffff801089d1:	48 83 c8 07          	or     $0x7,%rax
ffffffff801089d5:	48 89 c2             	mov    %rax,%rdx
ffffffff801089d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801089dc:	48 89 10             	mov    %rdx,(%rax)
  }
  return &pgtab[PTX(va)];
ffffffff801089df:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801089e3:	48 c1 e8 0c          	shr    $0xc,%rax
ffffffff801089e7:	25 ff 01 00 00       	and    $0x1ff,%eax
ffffffff801089ec:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff801089f3:	00 
ffffffff801089f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801089f8:	48 01 d0             	add    %rdx,%rax
}
ffffffff801089fb:	c9                   	leave
ffffffff801089fc:	c3                   	ret

ffffffff801089fd <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uintp size, uintp pa, int perm)
{
ffffffff801089fd:	55                   	push   %rbp
ffffffff801089fe:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108a01:	48 83 ec 50          	sub    $0x50,%rsp
ffffffff80108a05:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff80108a09:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff80108a0d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffffffff80108a11:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffffffff80108a15:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uintp)va);
ffffffff80108a19:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80108a1d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108a23:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  last = (char*)PGROUNDDOWN(((uintp)va) + size - 1);
ffffffff80108a27:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffffffff80108a2b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80108a2f:	48 01 d0             	add    %rdx,%rax
ffffffff80108a32:	48 83 e8 01          	sub    $0x1,%rax
ffffffff80108a36:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108a3c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffffffff80108a40:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff80108a44:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80108a48:	ba 01 00 00 00       	mov    $0x1,%edx
ffffffff80108a4d:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108a50:	48 89 c7             	mov    %rax,%rdi
ffffffff80108a53:	e8 dd fe ff ff       	call   ffffffff80108935 <walkpgdir>
ffffffff80108a58:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffffffff80108a5c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80108a61:	75 07                	jne    ffffffff80108a6a <mappages+0x6d>
      return -1;
ffffffff80108a63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80108a68:	eb 54                	jmp    ffffffff80108abe <mappages+0xc1>
    if(*pte & PTE_P)
ffffffff80108a6a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108a6e:	48 8b 00             	mov    (%rax),%rax
ffffffff80108a71:	83 e0 01             	and    $0x1,%eax
ffffffff80108a74:	48 85 c0             	test   %rax,%rax
ffffffff80108a77:	74 0c                	je     ffffffff80108a85 <mappages+0x88>
      panic("remap");
ffffffff80108a79:	48 c7 c7 d0 a2 10 80 	mov    $0xffffffff8010a2d0,%rdi
ffffffff80108a80:	e8 aa 7e ff ff       	call   ffffffff8010092f <panic>
    *pte = pa | perm | PTE_P;
ffffffff80108a85:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffffffff80108a88:	48 98                	cltq
ffffffff80108a8a:	48 0b 45 c0          	or     -0x40(%rbp),%rax
ffffffff80108a8e:	48 83 c8 01          	or     $0x1,%rax
ffffffff80108a92:	48 89 c2             	mov    %rax,%rdx
ffffffff80108a95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108a99:	48 89 10             	mov    %rdx,(%rax)
    if(a == last)
ffffffff80108a9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108aa0:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffffffff80108aa4:	74 12                	je     ffffffff80108ab8 <mappages+0xbb>
      break;
    a += PGSIZE;
ffffffff80108aa6:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffffffff80108aad:	00 
    pa += PGSIZE;
ffffffff80108aae:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
ffffffff80108ab5:	00 
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffffffff80108ab6:	eb 88                	jmp    ffffffff80108a40 <mappages+0x43>
      break;
ffffffff80108ab8:	90                   	nop
  }
  return 0;
ffffffff80108ab9:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80108abe:	c9                   	leave
ffffffff80108abf:	c3                   	ret

ffffffff80108ac0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
ffffffff80108ac0:	55                   	push   %rbp
ffffffff80108ac1:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108ac4:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff80108ac8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80108acc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffffffff80108ad0:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *mem;
  
  if(sz >= PGSIZE)
ffffffff80108ad3:	81 7d dc ff 0f 00 00 	cmpl   $0xfff,-0x24(%rbp)
ffffffff80108ada:	76 0c                	jbe    ffffffff80108ae8 <inituvm+0x28>
    panic("inituvm: more than a page");
ffffffff80108adc:	48 c7 c7 d6 a2 10 80 	mov    $0xffffffff8010a2d6,%rdi
ffffffff80108ae3:	e8 47 7e ff ff       	call   ffffffff8010092f <panic>
  mem = kalloc();
ffffffff80108ae8:	e8 ec a7 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80108aed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(mem, 0, PGSIZE);
ffffffff80108af1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108af5:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108afa:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80108aff:	48 89 c7             	mov    %rax,%rdi
ffffffff80108b02:	e8 4c d4 ff ff       	call   ffffffff80105f53 <memset>
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
ffffffff80108b07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108b0b:	48 89 c7             	mov    %rax,%rdi
ffffffff80108b0e:	e8 f0 fd ff ff       	call   ffffffff80108903 <v2p>
ffffffff80108b13:	48 89 c2             	mov    %rax,%rdx
ffffffff80108b16:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108b1a:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffffffff80108b20:	48 89 d1             	mov    %rdx,%rcx
ffffffff80108b23:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108b28:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80108b2d:	48 89 c7             	mov    %rax,%rdi
ffffffff80108b30:	e8 c8 fe ff ff       	call   ffffffff801089fd <mappages>
  memmove(mem, init, sz);
ffffffff80108b35:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffffffff80108b38:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffffffff80108b3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108b40:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108b43:	48 89 c7             	mov    %rax,%rdi
ffffffff80108b46:	e8 f7 d4 ff ff       	call   ffffffff80106042 <memmove>
}
ffffffff80108b4b:	90                   	nop
ffffffff80108b4c:	c9                   	leave
ffffffff80108b4d:	c3                   	ret

ffffffff80108b4e <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
ffffffff80108b4e:	55                   	push   %rbp
ffffffff80108b4f:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108b52:	53                   	push   %rbx
ffffffff80108b53:	48 83 ec 48          	sub    $0x48,%rsp
ffffffff80108b57:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffffffff80108b5b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffffffff80108b5f:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
ffffffff80108b63:	89 4d b4             	mov    %ecx,-0x4c(%rbp)
ffffffff80108b66:	44 89 45 b0          	mov    %r8d,-0x50(%rbp)
  uint i, pa, n;
  pte_t *pte;

  if((uintp) addr % PGSIZE != 0)
ffffffff80108b6a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80108b6e:	25 ff 0f 00 00       	and    $0xfff,%eax
ffffffff80108b73:	48 85 c0             	test   %rax,%rax
ffffffff80108b76:	74 0c                	je     ffffffff80108b84 <loaduvm+0x36>
    panic("loaduvm: addr must be page aligned");
ffffffff80108b78:	48 c7 c7 f0 a2 10 80 	mov    $0xffffffff8010a2f0,%rdi
ffffffff80108b7f:	e8 ab 7d ff ff       	call   ffffffff8010092f <panic>
  for(i = 0; i < sz; i += PGSIZE){
ffffffff80108b84:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffffffff80108b8b:	e9 a1 00 00 00       	jmp    ffffffff80108c31 <loaduvm+0xe3>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
ffffffff80108b90:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff80108b93:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80108b97:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffffffff80108b9b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80108b9f:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80108ba4:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108ba7:	48 89 c7             	mov    %rax,%rdi
ffffffff80108baa:	e8 86 fd ff ff       	call   ffffffff80108935 <walkpgdir>
ffffffff80108baf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffffffff80108bb3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffffffff80108bb8:	75 0c                	jne    ffffffff80108bc6 <loaduvm+0x78>
      panic("loaduvm: address should exist");
ffffffff80108bba:	48 c7 c7 13 a3 10 80 	mov    $0xffffffff8010a313,%rdi
ffffffff80108bc1:	e8 69 7d ff ff       	call   ffffffff8010092f <panic>
    pa = PTE_ADDR(*pte);
ffffffff80108bc6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80108bca:	48 8b 00             	mov    (%rax),%rax
ffffffff80108bcd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
ffffffff80108bd2:	89 45 dc             	mov    %eax,-0x24(%rbp)
    if(sz - i < PGSIZE)
ffffffff80108bd5:	8b 45 b0             	mov    -0x50(%rbp),%eax
ffffffff80108bd8:	2b 45 ec             	sub    -0x14(%rbp),%eax
ffffffff80108bdb:	3d ff 0f 00 00       	cmp    $0xfff,%eax
ffffffff80108be0:	77 0b                	ja     ffffffff80108bed <loaduvm+0x9f>
      n = sz - i;
ffffffff80108be2:	8b 45 b0             	mov    -0x50(%rbp),%eax
ffffffff80108be5:	2b 45 ec             	sub    -0x14(%rbp),%eax
ffffffff80108be8:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffffffff80108beb:	eb 07                	jmp    ffffffff80108bf4 <loaduvm+0xa6>
    else
      n = PGSIZE;
ffffffff80108bed:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%rbp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
ffffffff80108bf4:	8b 55 b4             	mov    -0x4c(%rbp),%edx
ffffffff80108bf7:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80108bfa:	8d 1c 02             	lea    (%rdx,%rax,1),%ebx
ffffffff80108bfd:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffffffff80108c00:	48 89 c7             	mov    %rax,%rdi
ffffffff80108c03:	e8 15 fd ff ff       	call   ffffffff8010891d <p2v>
ffffffff80108c08:	48 89 c6             	mov    %rax,%rsi
ffffffff80108c0b:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffffffff80108c0e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff80108c12:	89 d1                	mov    %edx,%ecx
ffffffff80108c14:	89 da                	mov    %ebx,%edx
ffffffff80108c16:	48 89 c7             	mov    %rax,%rdi
ffffffff80108c19:	e8 22 98 ff ff       	call   ffffffff80102440 <readi>
ffffffff80108c1e:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffffffff80108c21:	74 07                	je     ffffffff80108c2a <loaduvm+0xdc>
      return -1;
ffffffff80108c23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80108c28:	eb 18                	jmp    ffffffff80108c42 <loaduvm+0xf4>
  for(i = 0; i < sz; i += PGSIZE){
ffffffff80108c2a:	81 45 ec 00 10 00 00 	addl   $0x1000,-0x14(%rbp)
ffffffff80108c31:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffffffff80108c34:	3b 45 b0             	cmp    -0x50(%rbp),%eax
ffffffff80108c37:	0f 82 53 ff ff ff    	jb     ffffffff80108b90 <loaduvm+0x42>
  }
  return 0;
ffffffff80108c3d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80108c42:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffffffff80108c46:	c9                   	leave
ffffffff80108c47:	c3                   	ret

ffffffff80108c48 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
ffffffff80108c48:	55                   	push   %rbp
ffffffff80108c49:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108c4c:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80108c50:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80108c54:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffffffff80108c57:	89 55 e0             	mov    %edx,-0x20(%rbp)
  char *mem;
  uintp a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
ffffffff80108c5a:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffffffff80108c5d:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffffffff80108c60:	73 08                	jae    ffffffff80108c6a <allocuvm+0x22>
    return oldsz;
ffffffff80108c62:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80108c65:	e9 b0 00 00 00       	jmp    ffffffff80108d1a <allocuvm+0xd2>

  a = PGROUNDUP(oldsz);
ffffffff80108c6a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80108c6d:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffffffff80108c73:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108c79:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a < newsz; a += PGSIZE){
ffffffff80108c7d:	e9 88 00 00 00       	jmp    ffffffff80108d0a <allocuvm+0xc2>
    mem = kalloc();
ffffffff80108c82:	e8 52 a6 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80108c87:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(mem == 0){
ffffffff80108c8b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80108c90:	75 2d                	jne    ffffffff80108cbf <allocuvm+0x77>
      cprintf("allocuvm out of memory\n");
ffffffff80108c92:	48 c7 c7 31 a3 10 80 	mov    $0xffffffff8010a331,%rdi
ffffffff80108c99:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80108c9e:	e8 01 79 ff ff       	call   ffffffff801005a4 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
ffffffff80108ca3:	8b 55 e4             	mov    -0x1c(%rbp),%edx
ffffffff80108ca6:	8b 4d e0             	mov    -0x20(%rbp),%ecx
ffffffff80108ca9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108cad:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108cb0:	48 89 c7             	mov    %rax,%rdi
ffffffff80108cb3:	e8 64 00 00 00       	call   ffffffff80108d1c <deallocuvm>
      return 0;
ffffffff80108cb8:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80108cbd:	eb 5b                	jmp    ffffffff80108d1a <allocuvm+0xd2>
    }
    memset(mem, 0, PGSIZE);
ffffffff80108cbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108cc3:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108cc8:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80108ccd:	48 89 c7             	mov    %rax,%rdi
ffffffff80108cd0:	e8 7e d2 ff ff       	call   ffffffff80105f53 <memset>
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
ffffffff80108cd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108cd9:	48 89 c7             	mov    %rax,%rdi
ffffffff80108cdc:	e8 22 fc ff ff       	call   ffffffff80108903 <v2p>
ffffffff80108ce1:	48 89 c2             	mov    %rax,%rdx
ffffffff80108ce4:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffffffff80108ce8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108cec:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffffffff80108cf2:	48 89 d1             	mov    %rdx,%rcx
ffffffff80108cf5:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108cfa:	48 89 c7             	mov    %rax,%rdi
ffffffff80108cfd:	e8 fb fc ff ff       	call   ffffffff801089fd <mappages>
  for(; a < newsz; a += PGSIZE){
ffffffff80108d02:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffffffff80108d09:	00 
ffffffff80108d0a:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffffffff80108d0d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffffffff80108d11:	0f 82 6b ff ff ff    	jb     ffffffff80108c82 <allocuvm+0x3a>
  }
  return newsz;
ffffffff80108d17:	8b 45 e0             	mov    -0x20(%rbp),%eax
}
ffffffff80108d1a:	c9                   	leave
ffffffff80108d1b:	c3                   	ret

ffffffff80108d1c <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uintp oldsz, uintp newsz)
{
ffffffff80108d1c:	55                   	push   %rbp
ffffffff80108d1d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108d20:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff80108d24:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff80108d28:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffffffff80108d2c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  pte_t *pte;
  uintp a, pa;

  if(newsz >= oldsz)
ffffffff80108d30:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80108d34:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffffffff80108d38:	72 09                	jb     ffffffff80108d43 <deallocuvm+0x27>
    return oldsz;
ffffffff80108d3a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80108d3e:	e9 ba 00 00 00       	jmp    ffffffff80108dfd <deallocuvm+0xe1>

  a = PGROUNDUP(newsz);
ffffffff80108d43:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80108d47:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffffffff80108d4d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108d53:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a  < oldsz; a += PGSIZE){
ffffffff80108d57:	e9 8f 00 00 00       	jmp    ffffffff80108deb <deallocuvm+0xcf>
    pte = walkpgdir(pgdir, (char*)a, 0);
ffffffff80108d5c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff80108d60:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80108d64:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80108d69:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108d6c:	48 89 c7             	mov    %rax,%rdi
ffffffff80108d6f:	e8 c1 fb ff ff       	call   ffffffff80108935 <walkpgdir>
ffffffff80108d74:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(!pte)
ffffffff80108d78:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffffffff80108d7d:	75 0a                	jne    ffffffff80108d89 <deallocuvm+0x6d>
      a += (NPTENTRIES - 1) * PGSIZE;
ffffffff80108d7f:	48 81 45 f8 00 f0 1f 	addq   $0x1ff000,-0x8(%rbp)
ffffffff80108d86:	00 
ffffffff80108d87:	eb 5a                	jmp    ffffffff80108de3 <deallocuvm+0xc7>
    else if((*pte & PTE_P) != 0){
ffffffff80108d89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108d8d:	48 8b 00             	mov    (%rax),%rax
ffffffff80108d90:	83 e0 01             	and    $0x1,%eax
ffffffff80108d93:	48 85 c0             	test   %rax,%rax
ffffffff80108d96:	74 4b                	je     ffffffff80108de3 <deallocuvm+0xc7>
      pa = PTE_ADDR(*pte);
ffffffff80108d98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108d9c:	48 8b 00             	mov    (%rax),%rax
ffffffff80108d9f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108da5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      if(pa == 0)
ffffffff80108da9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80108dae:	75 0c                	jne    ffffffff80108dbc <deallocuvm+0xa0>
        panic("kfree");
ffffffff80108db0:	48 c7 c7 49 a3 10 80 	mov    $0xffffffff8010a349,%rdi
ffffffff80108db7:	e8 73 7b ff ff       	call   ffffffff8010092f <panic>
      char *v = p2v(pa);
ffffffff80108dbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108dc0:	48 89 c7             	mov    %rax,%rdi
ffffffff80108dc3:	e8 55 fb ff ff       	call   ffffffff8010891d <p2v>
ffffffff80108dc8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      kfree(v);
ffffffff80108dcc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80108dd0:	48 89 c7             	mov    %rax,%rdi
ffffffff80108dd3:	e8 57 a4 ff ff       	call   ffffffff8010322f <kfree>
      *pte = 0;
ffffffff80108dd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108ddc:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; a  < oldsz; a += PGSIZE){
ffffffff80108de3:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffffffff80108dea:	00 
ffffffff80108deb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108def:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffffffff80108df3:	0f 82 63 ff ff ff    	jb     ffffffff80108d5c <deallocuvm+0x40>
    }
  }
  return newsz;
ffffffff80108df9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
ffffffff80108dfd:	c9                   	leave
ffffffff80108dfe:	c3                   	ret

ffffffff80108dff <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
ffffffff80108dff:	55                   	push   %rbp
ffffffff80108e00:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108e03:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80108e07:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  uint i;
  if(pgdir == 0)
ffffffff80108e0b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff80108e10:	75 0c                	jne    ffffffff80108e1e <freevm+0x1f>
    panic("freevm: no pgdir");
ffffffff80108e12:	48 c7 c7 4f a3 10 80 	mov    $0xffffffff8010a34f,%rdi
ffffffff80108e19:	e8 11 7b ff ff       	call   ffffffff8010092f <panic>
  deallocuvm(pgdir, 0x3fa00000, 0);
ffffffff80108e1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108e22:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80108e27:	be 00 00 a0 3f       	mov    $0x3fa00000,%esi
ffffffff80108e2c:	48 89 c7             	mov    %rax,%rdi
ffffffff80108e2f:	e8 e8 fe ff ff       	call   ffffffff80108d1c <deallocuvm>
  for(i = 0; i < NPDENTRIES-2; i++){
ffffffff80108e34:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80108e3b:	eb 54                	jmp    ffffffff80108e91 <freevm+0x92>
    if(pgdir[i] & PTE_P){
ffffffff80108e3d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80108e40:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80108e47:	00 
ffffffff80108e48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108e4c:	48 01 d0             	add    %rdx,%rax
ffffffff80108e4f:	48 8b 00             	mov    (%rax),%rax
ffffffff80108e52:	83 e0 01             	and    $0x1,%eax
ffffffff80108e55:	48 85 c0             	test   %rax,%rax
ffffffff80108e58:	74 33                	je     ffffffff80108e8d <freevm+0x8e>
      char * v = p2v(PTE_ADDR(pgdir[i]));
ffffffff80108e5a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80108e5d:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffffffff80108e64:	00 
ffffffff80108e65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108e69:	48 01 d0             	add    %rdx,%rax
ffffffff80108e6c:	48 8b 00             	mov    (%rax),%rax
ffffffff80108e6f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108e75:	48 89 c7             	mov    %rax,%rdi
ffffffff80108e78:	e8 a0 fa ff ff       	call   ffffffff8010891d <p2v>
ffffffff80108e7d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
      kfree(v);
ffffffff80108e81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80108e85:	48 89 c7             	mov    %rax,%rdi
ffffffff80108e88:	e8 a2 a3 ff ff       	call   ffffffff8010322f <kfree>
  for(i = 0; i < NPDENTRIES-2; i++){
ffffffff80108e8d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80108e91:	81 7d fc fd 01 00 00 	cmpl   $0x1fd,-0x4(%rbp)
ffffffff80108e98:	76 a3                	jbe    ffffffff80108e3d <freevm+0x3e>
    }
  }
  kfree((char*)pgdir);
ffffffff80108e9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108e9e:	48 89 c7             	mov    %rax,%rdi
ffffffff80108ea1:	e8 89 a3 ff ff       	call   ffffffff8010322f <kfree>
}
ffffffff80108ea6:	90                   	nop
ffffffff80108ea7:	c9                   	leave
ffffffff80108ea8:	c3                   	ret

ffffffff80108ea9 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
ffffffff80108ea9:	55                   	push   %rbp
ffffffff80108eaa:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108ead:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80108eb1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80108eb5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffffffff80108eb9:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffffffff80108ebd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80108ec1:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80108ec6:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108ec9:	48 89 c7             	mov    %rax,%rdi
ffffffff80108ecc:	e8 64 fa ff ff       	call   ffffffff80108935 <walkpgdir>
ffffffff80108ed1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(pte == 0)
ffffffff80108ed5:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff80108eda:	75 0c                	jne    ffffffff80108ee8 <clearpteu+0x3f>
    panic("clearpteu");
ffffffff80108edc:	48 c7 c7 60 a3 10 80 	mov    $0xffffffff8010a360,%rdi
ffffffff80108ee3:	e8 47 7a ff ff       	call   ffffffff8010092f <panic>
  *pte &= ~PTE_U;
ffffffff80108ee8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108eec:	48 8b 00             	mov    (%rax),%rax
ffffffff80108eef:	48 83 e0 fb          	and    $0xfffffffffffffffb,%rax
ffffffff80108ef3:	48 89 c2             	mov    %rax,%rdx
ffffffff80108ef6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80108efa:	48 89 10             	mov    %rdx,(%rax)
}
ffffffff80108efd:	90                   	nop
ffffffff80108efe:	c9                   	leave
ffffffff80108eff:	c3                   	ret

ffffffff80108f00 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
ffffffff80108f00:	55                   	push   %rbp
ffffffff80108f01:	48 89 e5             	mov    %rsp,%rbp
ffffffff80108f04:	53                   	push   %rbx
ffffffff80108f05:	48 83 ec 48          	sub    $0x48,%rsp
ffffffff80108f09:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
ffffffff80108f0d:	89 75 b4             	mov    %esi,-0x4c(%rbp)
  pde_t *d;
  pte_t *pte;
  uintp pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
ffffffff80108f10:	e8 54 09 00 00       	call   ffffffff80109869 <setupkvm>
ffffffff80108f15:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffffffff80108f19:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffffffff80108f1e:	75 0a                	jne    ffffffff80108f2a <copyuvm+0x2a>
    return 0;
ffffffff80108f20:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80108f25:	e9 0f 01 00 00       	jmp    ffffffff80109039 <copyuvm+0x139>
  for(i = 0; i < sz; i += PGSIZE){
ffffffff80108f2a:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffffffff80108f31:	00 
ffffffff80108f32:	e9 da 00 00 00       	jmp    ffffffff80109011 <copyuvm+0x111>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
ffffffff80108f37:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffffffff80108f3b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffffffff80108f3f:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff80108f44:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108f47:	48 89 c7             	mov    %rax,%rdi
ffffffff80108f4a:	e8 e6 f9 ff ff       	call   ffffffff80108935 <walkpgdir>
ffffffff80108f4f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffffffff80108f53:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffffffff80108f58:	75 0c                	jne    ffffffff80108f66 <copyuvm+0x66>
      panic("copyuvm: pte should exist");
ffffffff80108f5a:	48 c7 c7 6a a3 10 80 	mov    $0xffffffff8010a36a,%rdi
ffffffff80108f61:	e8 c9 79 ff ff       	call   ffffffff8010092f <panic>
    if(!(*pte & PTE_P))
ffffffff80108f66:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80108f6a:	48 8b 00             	mov    (%rax),%rax
ffffffff80108f6d:	83 e0 01             	and    $0x1,%eax
ffffffff80108f70:	48 85 c0             	test   %rax,%rax
ffffffff80108f73:	75 0c                	jne    ffffffff80108f81 <copyuvm+0x81>
      panic("copyuvm: page not present");
ffffffff80108f75:	48 c7 c7 84 a3 10 80 	mov    $0xffffffff8010a384,%rdi
ffffffff80108f7c:	e8 ae 79 ff ff       	call   ffffffff8010092f <panic>
    pa = PTE_ADDR(*pte);
ffffffff80108f81:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80108f85:	48 8b 00             	mov    (%rax),%rax
ffffffff80108f88:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80108f8e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    flags = PTE_FLAGS(*pte);
ffffffff80108f92:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80108f96:	48 8b 00             	mov    (%rax),%rax
ffffffff80108f99:	25 ff 0f 00 00       	and    $0xfff,%eax
ffffffff80108f9e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    if((mem = kalloc()) == 0)
ffffffff80108fa2:	e8 32 a3 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80108fa7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffffffff80108fab:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffffffff80108fb0:	74 72                	je     ffffffff80109024 <copyuvm+0x124>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
ffffffff80108fb2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff80108fb6:	48 89 c7             	mov    %rax,%rdi
ffffffff80108fb9:	e8 5f f9 ff ff       	call   ffffffff8010891d <p2v>
ffffffff80108fbe:	48 89 c1             	mov    %rax,%rcx
ffffffff80108fc1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80108fc5:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108fca:	48 89 ce             	mov    %rcx,%rsi
ffffffff80108fcd:	48 89 c7             	mov    %rax,%rdi
ffffffff80108fd0:	e8 6d d0 ff ff       	call   ffffffff80106042 <memmove>
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
ffffffff80108fd5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80108fd9:	89 c3                	mov    %eax,%ebx
ffffffff80108fdb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffffffff80108fdf:	48 89 c7             	mov    %rax,%rdi
ffffffff80108fe2:	e8 1c f9 ff ff       	call   ffffffff80108903 <v2p>
ffffffff80108fe7:	48 89 c2             	mov    %rax,%rdx
ffffffff80108fea:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
ffffffff80108fee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80108ff2:	41 89 d8             	mov    %ebx,%r8d
ffffffff80108ff5:	48 89 d1             	mov    %rdx,%rcx
ffffffff80108ff8:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80108ffd:	48 89 c7             	mov    %rax,%rdi
ffffffff80109000:	e8 f8 f9 ff ff       	call   ffffffff801089fd <mappages>
ffffffff80109005:	85 c0                	test   %eax,%eax
ffffffff80109007:	78 1e                	js     ffffffff80109027 <copyuvm+0x127>
  for(i = 0; i < sz; i += PGSIZE){
ffffffff80109009:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
ffffffff80109010:	00 
ffffffff80109011:	8b 45 b4             	mov    -0x4c(%rbp),%eax
ffffffff80109014:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffffffff80109018:	0f 82 19 ff ff ff    	jb     ffffffff80108f37 <copyuvm+0x37>
      goto bad;
  }
  return d;
ffffffff8010901e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109022:	eb 15                	jmp    ffffffff80109039 <copyuvm+0x139>
      goto bad;
ffffffff80109024:	90                   	nop
ffffffff80109025:	eb 01                	jmp    ffffffff80109028 <copyuvm+0x128>
      goto bad;
ffffffff80109027:	90                   	nop

bad:
  freevm(d);
ffffffff80109028:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010902c:	48 89 c7             	mov    %rax,%rdi
ffffffff8010902f:	e8 cb fd ff ff       	call   ffffffff80108dff <freevm>
  return 0;
ffffffff80109034:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff80109039:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffffffff8010903d:	c9                   	leave
ffffffff8010903e:	c3                   	ret

ffffffff8010903f <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
ffffffff8010903f:	55                   	push   %rbp
ffffffff80109040:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109043:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80109047:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff8010904b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffffffff8010904f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffffffff80109053:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109057:	ba 00 00 00 00       	mov    $0x0,%edx
ffffffff8010905c:	48 89 ce             	mov    %rcx,%rsi
ffffffff8010905f:	48 89 c7             	mov    %rax,%rdi
ffffffff80109062:	e8 ce f8 ff ff       	call   ffffffff80108935 <walkpgdir>
ffffffff80109067:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((*pte & PTE_P) == 0)
ffffffff8010906b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010906f:	48 8b 00             	mov    (%rax),%rax
ffffffff80109072:	83 e0 01             	and    $0x1,%eax
ffffffff80109075:	48 85 c0             	test   %rax,%rax
ffffffff80109078:	75 07                	jne    ffffffff80109081 <uva2ka+0x42>
    return 0;
ffffffff8010907a:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010907f:	eb 2c                	jmp    ffffffff801090ad <uva2ka+0x6e>
  if((*pte & PTE_U) == 0)
ffffffff80109081:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109085:	48 8b 00             	mov    (%rax),%rax
ffffffff80109088:	83 e0 04             	and    $0x4,%eax
ffffffff8010908b:	48 85 c0             	test   %rax,%rax
ffffffff8010908e:	75 07                	jne    ffffffff80109097 <uva2ka+0x58>
    return 0;
ffffffff80109090:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff80109095:	eb 16                	jmp    ffffffff801090ad <uva2ka+0x6e>
  return (char*)p2v(PTE_ADDR(*pte));
ffffffff80109097:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010909b:	48 8b 00             	mov    (%rax),%rax
ffffffff8010909e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff801090a4:	48 89 c7             	mov    %rax,%rdi
ffffffff801090a7:	e8 71 f8 ff ff       	call   ffffffff8010891d <p2v>
ffffffff801090ac:	90                   	nop
}
ffffffff801090ad:	c9                   	leave
ffffffff801090ae:	c3                   	ret

ffffffff801090af <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
ffffffff801090af:	55                   	push   %rbp
ffffffff801090b0:	48 89 e5             	mov    %rsp,%rbp
ffffffff801090b3:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff801090b7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffffffff801090bb:	89 75 d4             	mov    %esi,-0x2c(%rbp)
ffffffff801090be:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffffffff801090c2:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  char *buf, *pa0;
  uintp n, va0;

  buf = (char*)p;
ffffffff801090c5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff801090c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(len > 0){
ffffffff801090cd:	e9 9a 00 00 00       	jmp    ffffffff8010916c <copyout+0xbd>
    va0 = (uint)PGROUNDDOWN(va);
ffffffff801090d2:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffffffff801090d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
ffffffff801090da:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    pa0 = uva2ka(pgdir, (char*)va0);
ffffffff801090de:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff801090e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801090e6:	48 89 d6             	mov    %rdx,%rsi
ffffffff801090e9:	48 89 c7             	mov    %rax,%rdi
ffffffff801090ec:	e8 4e ff ff ff       	call   ffffffff8010903f <uva2ka>
ffffffff801090f1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    if(pa0 == 0)
ffffffff801090f5:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffffffff801090fa:	75 07                	jne    ffffffff80109103 <copyout+0x54>
      return -1;
ffffffff801090fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffffffff80109101:	eb 78                	jmp    ffffffff8010917b <copyout+0xcc>
    n = PGSIZE - (va - va0);
ffffffff80109103:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffffffff80109106:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff8010910a:	48 29 c2             	sub    %rax,%rdx
ffffffff8010910d:	48 8d 82 00 10 00 00 	lea    0x1000(%rdx),%rax
ffffffff80109114:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(n > len)
ffffffff80109118:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffffffff8010911b:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffffffff8010911f:	73 07                	jae    ffffffff80109128 <copyout+0x79>
      n = len;
ffffffff80109121:	8b 45 d0             	mov    -0x30(%rbp),%eax
ffffffff80109124:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    memmove(pa0 + (va - va0), buf, n);
ffffffff80109128:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010912c:	89 c6                	mov    %eax,%esi
ffffffff8010912e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffffffff80109131:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffffffff80109135:	48 89 c2             	mov    %rax,%rdx
ffffffff80109138:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010913c:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffffffff80109140:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109144:	89 f2                	mov    %esi,%edx
ffffffff80109146:	48 89 c6             	mov    %rax,%rsi
ffffffff80109149:	48 89 cf             	mov    %rcx,%rdi
ffffffff8010914c:	e8 f1 ce ff ff       	call   ffffffff80106042 <memmove>
    len -= n;
ffffffff80109151:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80109155:	29 45 d0             	sub    %eax,-0x30(%rbp)
    buf += n;
ffffffff80109158:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010915c:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    va = va0 + PGSIZE;
ffffffff80109160:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109164:	05 00 10 00 00       	add    $0x1000,%eax
ffffffff80109169:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  while(len > 0){
ffffffff8010916c:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
ffffffff80109170:	0f 85 5c ff ff ff    	jne    ffffffff801090d2 <copyout+0x23>
  }
  return 0;
ffffffff80109176:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffffffff8010917b:	c9                   	leave
ffffffff8010917c:	c3                   	ret

ffffffff8010917d <createRoot>:
#include "set.h"
#include "defs.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
ffffffff8010917d:	55                   	push   %rbp
ffffffff8010917e:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109181:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = kalloc(); //Η kalloc δεσμεύει 4 Kbyte από την heap του kernel
ffffffff80109185:	e8 4f a1 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff8010918a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
ffffffff8010918e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109192:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
ffffffff80109199:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010919d:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
ffffffff801091a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffffffff801091a8:	c9                   	leave
ffffffff801091a9:	c3                   	ret

ffffffff801091aa <createNode>:

void createNode(int i, Set *set){
ffffffff801091aa:	55                   	push   %rbp
ffffffff801091ab:	48 89 e5             	mov    %rsp,%rbp
ffffffff801091ae:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801091b2:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffffffff801091b5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = kalloc(); //Η kalloc δεσμεύει 4 Kbyte από την heap του kernel
ffffffff801091b9:	e8 1b a1 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff801091be:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
ffffffff801091c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801091c6:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffffffff801091c9:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
ffffffff801091cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801091cf:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
ffffffff801091d6:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root; //Ξεκινάει από την root
ffffffff801091d7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801091db:	48 8b 00             	mov    (%rax),%rax
ffffffff801091de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
ffffffff801091e2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801091e7:	74 34                	je     ffffffff8010921d <createNode+0x73>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
ffffffff801091e9:	eb 25                	jmp    ffffffff80109210 <createNode+0x66>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
ffffffff801091eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801091ef:	8b 00                	mov    (%rax),%eax
ffffffff801091f1:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffffffff801091f4:	75 0e                	jne    ffffffff80109204 <createNode+0x5a>
                kfree(temp);
ffffffff801091f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801091fa:	48 89 c7             	mov    %rax,%rdi
ffffffff801091fd:	e8 2d a0 ff ff       	call   ffffffff8010322f <kfree>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
ffffffff80109202:	eb 4e                	jmp    ffffffff80109252 <createNode+0xa8>
            }
            curr = curr->next; //Επόμενο SetNode
ffffffff80109204:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109208:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff8010920c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
ffffffff80109210:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109214:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80109218:	48 85 c0             	test   %rax,%rax
ffffffff8010921b:	75 ce                	jne    ffffffff801091eb <createNode+0x41>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp);
ffffffff8010921d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109221:	8b 00                	mov    (%rax),%eax
ffffffff80109223:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffffffff80109226:	74 1e                	je     ffffffff80109246 <createNode+0x9c>
ffffffff80109228:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff8010922c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffffffff80109230:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109234:	48 89 ce             	mov    %rcx,%rsi
ffffffff80109237:	48 89 c7             	mov    %rax,%rdi
ffffffff8010923a:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010923f:	e8 10 00 00 00       	call   ffffffff80109254 <attachNode>
ffffffff80109244:	eb 0c                	jmp    ffffffff80109252 <createNode+0xa8>
    else kfree(temp);
ffffffff80109246:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010924a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010924d:	e8 dd 9f ff ff       	call   ffffffff8010322f <kfree>
}
ffffffff80109252:	c9                   	leave
ffffffff80109253:	c3                   	ret

ffffffff80109254 <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
ffffffff80109254:	55                   	push   %rbp
ffffffff80109255:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109258:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff8010925c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff80109260:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffffffff80109264:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
ffffffff80109268:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010926c:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff8010926f:	85 c0                	test   %eax,%eax
ffffffff80109271:	75 0d                	jne    ffffffff80109280 <attachNode+0x2c>
ffffffff80109273:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109277:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff8010927b:	48 89 10             	mov    %rdx,(%rax)
ffffffff8010927e:	eb 0c                	jmp    ffffffff8010928c <attachNode+0x38>
    else curr->next = temp;
ffffffff80109280:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80109284:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff80109288:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
ffffffff8010928c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109290:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff80109293:	8d 50 01             	lea    0x1(%rax),%edx
ffffffff80109296:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010929a:	89 50 08             	mov    %edx,0x8(%rax)
}
ffffffff8010929d:	90                   	nop
ffffffff8010929e:	c9                   	leave
ffffffff8010929f:	c3                   	ret

ffffffff801092a0 <deleteSet>:

void deleteSet(Set *set){
ffffffff801092a0:	55                   	push   %rbp
ffffffff801092a1:	48 89 e5             	mov    %rsp,%rbp
ffffffff801092a4:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801092a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
ffffffff801092ac:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff801092b1:	74 42                	je     ffffffff801092f5 <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
ffffffff801092b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801092b7:	48 8b 00             	mov    (%rax),%rax
ffffffff801092ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){
ffffffff801092be:	eb 20                	jmp    ffffffff801092e0 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
ffffffff801092c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801092c4:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff801092c8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        kfree(curr); //Απελευθέρωση της curr
ffffffff801092cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801092d0:	48 89 c7             	mov    %rax,%rdi
ffffffff801092d3:	e8 57 9f ff ff       	call   ffffffff8010322f <kfree>
        curr = temp;
ffffffff801092d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801092dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){
ffffffff801092e0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffffffff801092e5:	75 d9                	jne    ffffffff801092c0 <deleteSet+0x20>
    }
    kfree(set); //Διαγραφή του Set
ffffffff801092e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801092eb:	48 89 c7             	mov    %rax,%rdi
ffffffff801092ee:	e8 3c 9f ff ff       	call   ffffffff8010322f <kfree>
ffffffff801092f3:	eb 01                	jmp    ffffffff801092f6 <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
ffffffff801092f5:	90                   	nop
}
ffffffff801092f6:	c9                   	leave
ffffffff801092f7:	c3                   	ret

ffffffff801092f8 <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
ffffffff801092f8:	55                   	push   %rbp
ffffffff801092f9:	48 89 e5             	mov    %rsp,%rbp
ffffffff801092fc:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80109300:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80109304:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
ffffffff80109307:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffffffff8010930c:	74 0c                	je     ffffffff8010931a <getNodeAtPosition+0x22>
ffffffff8010930e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109312:	48 8b 00             	mov    (%rax),%rax
ffffffff80109315:	48 85 c0             	test   %rax,%rax
ffffffff80109318:	75 07                	jne    ffffffff80109321 <getNodeAtPosition+0x29>
ffffffff8010931a:	b8 00 00 00 00       	mov    $0x0,%eax
ffffffff8010931f:	eb 3d                	jmp    ffffffff8010935e <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
ffffffff80109321:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109325:	48 8b 00             	mov    (%rax),%rax
ffffffff80109328:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
ffffffff8010932c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffffffff80109333:	eb 10                	jmp    ffffffff80109345 <getNodeAtPosition+0x4d>
ffffffff80109335:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109339:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff8010933d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffffffff80109341:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffffffff80109345:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80109348:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffffffff8010934b:	7d 0d                	jge    ffffffff8010935a <getNodeAtPosition+0x62>
ffffffff8010934d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109351:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80109355:	48 85 c0             	test   %rax,%rax
ffffffff80109358:	75 db                	jne    ffffffff80109335 <getNodeAtPosition+0x3d>
    return curr;
ffffffff8010935a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010935e:	c9                   	leave
ffffffff8010935f:	c3                   	ret

ffffffff80109360 <lcg_init>:
#include "random.h"

void lcg_init(LCG *lcg, int seed){
ffffffff80109360:	55                   	push   %rbp
ffffffff80109361:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109364:	48 83 ec 10          	sub    $0x10,%rsp
ffffffff80109368:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010936c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    lcg->state = seed % lcg->m; //seed mod MAX
ffffffff8010936f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109373:	8b 08                	mov    (%rax),%ecx
ffffffff80109375:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80109378:	99                   	cltd
ffffffff80109379:	f7 f9                	idiv   %ecx
ffffffff8010937b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010937f:	89 50 0c             	mov    %edx,0xc(%rax)
}
ffffffff80109382:	90                   	nop
ffffffff80109383:	c9                   	leave
ffffffff80109384:	c3                   	ret

ffffffff80109385 <lcg_random>:

int lcg_random(LCG *lcg){
ffffffff80109385:	55                   	push   %rbp
ffffffff80109386:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109389:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff8010938d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    //next=(a × seed + c ) mod m
    lcg->state = (lcg->a * lcg->state + lcg->c) % lcg->m;
ffffffff80109391:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109395:	8b 50 04             	mov    0x4(%rax),%edx
ffffffff80109398:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010939c:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff8010939f:	0f af d0             	imul   %eax,%edx
ffffffff801093a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801093a6:	8b 40 08             	mov    0x8(%rax),%eax
ffffffff801093a9:	01 c2                	add    %eax,%edx
ffffffff801093ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801093af:	8b 08                	mov    (%rax),%ecx
ffffffff801093b1:	89 d0                	mov    %edx,%eax
ffffffff801093b3:	99                   	cltd
ffffffff801093b4:	f7 f9                	idiv   %ecx
ffffffff801093b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801093ba:	89 50 0c             	mov    %edx,0xc(%rax)
    return lcg->state;
ffffffff801093bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801093c1:	8b 40 0c             	mov    0xc(%rax),%eax
ffffffff801093c4:	c9                   	leave
ffffffff801093c5:	c3                   	ret

ffffffff801093c6 <lgdt>:
{
ffffffff801093c6:	55                   	push   %rbp
ffffffff801093c7:	48 89 e5             	mov    %rsp,%rbp
ffffffff801093ca:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff801093ce:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801093d2:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  pd[0] = size-1;
ffffffff801093d5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff801093d8:	83 e8 01             	sub    $0x1,%eax
ffffffff801093db:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  pd[1] = (uintp)p;
ffffffff801093df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801093e3:	66 89 45 f8          	mov    %ax,-0x8(%rbp)
  pd[2] = (uintp)p >> 16;
ffffffff801093e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801093eb:	48 c1 e8 10          	shr    $0x10,%rax
ffffffff801093ef:	66 89 45 fa          	mov    %ax,-0x6(%rbp)
  pd[3] = (uintp)p >> 32;
ffffffff801093f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801093f7:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff801093fb:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  pd[4] = (uintp)p >> 48;
ffffffff801093ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109403:	48 c1 e8 30          	shr    $0x30,%rax
ffffffff80109407:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
  asm volatile("lgdt (%0)" : : "r" (pd));
ffffffff8010940b:	48 8d 45 f6          	lea    -0xa(%rbp),%rax
ffffffff8010940f:	0f 01 10             	lgdt   (%rax)
}
ffffffff80109412:	90                   	nop
ffffffff80109413:	c9                   	leave
ffffffff80109414:	c3                   	ret

ffffffff80109415 <lidt>:
{
ffffffff80109415:	55                   	push   %rbp
ffffffff80109416:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109419:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff8010941d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff80109421:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  pd[0] = size-1;
ffffffff80109424:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80109427:	83 e8 01             	sub    $0x1,%eax
ffffffff8010942a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  pd[1] = (uintp)p;
ffffffff8010942e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109432:	66 89 45 f8          	mov    %ax,-0x8(%rbp)
  pd[2] = (uintp)p >> 16;
ffffffff80109436:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010943a:	48 c1 e8 10          	shr    $0x10,%rax
ffffffff8010943e:	66 89 45 fa          	mov    %ax,-0x6(%rbp)
  pd[3] = (uintp)p >> 32;
ffffffff80109442:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109446:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff8010944a:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  pd[4] = (uintp)p >> 48;
ffffffff8010944e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109452:	48 c1 e8 30          	shr    $0x30,%rax
ffffffff80109456:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
  asm volatile("lidt (%0)" : : "r" (pd));
ffffffff8010945a:	48 8d 45 f6          	lea    -0xa(%rbp),%rax
ffffffff8010945e:	0f 01 18             	lidt   (%rax)
}
ffffffff80109461:	90                   	nop
ffffffff80109462:	c9                   	leave
ffffffff80109463:	c3                   	ret

ffffffff80109464 <ltr>:
{
ffffffff80109464:	55                   	push   %rbp
ffffffff80109465:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109468:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff8010946c:	89 f8                	mov    %edi,%eax
ffffffff8010946e:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  asm volatile("ltr %0" : : "r" (sel));
ffffffff80109472:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffffffff80109476:	0f 00 d8             	ltr    %ax
}
ffffffff80109479:	90                   	nop
ffffffff8010947a:	c9                   	leave
ffffffff8010947b:	c3                   	ret

ffffffff8010947c <lcr3>:

static inline void
lcr3(uintp val) 
{
ffffffff8010947c:	55                   	push   %rbp
ffffffff8010947d:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109480:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff80109484:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  asm volatile("mov %0,%%cr3" : : "r" (val));
ffffffff80109488:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010948c:	0f 22 d8             	mov    %rax,%cr3
}
ffffffff8010948f:	90                   	nop
ffffffff80109490:	c9                   	leave
ffffffff80109491:	c3                   	ret

ffffffff80109492 <v2p>:
static inline uintp v2p(void *a) { return ((uintp) (a)) - ((uintp)KERNBASE); }
ffffffff80109492:	55                   	push   %rbp
ffffffff80109493:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109496:	48 83 ec 08          	sub    $0x8,%rsp
ffffffff8010949a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010949e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801094a2:	ba 00 00 00 80       	mov    $0x80000000,%edx
ffffffff801094a7:	48 01 d0             	add    %rdx,%rax
ffffffff801094aa:	c9                   	leave
ffffffff801094ab:	c3                   	ret

ffffffff801094ac <tvinit>:
static pde_t *kpgdir0;
static pde_t *kpgdir1;

void wrmsr(uint msr, uint64 val);

void tvinit(void) {}
ffffffff801094ac:	55                   	push   %rbp
ffffffff801094ad:	48 89 e5             	mov    %rsp,%rbp
ffffffff801094b0:	90                   	nop
ffffffff801094b1:	5d                   	pop    %rbp
ffffffff801094b2:	c3                   	ret

ffffffff801094b3 <idtinit>:
void idtinit(void) {}
ffffffff801094b3:	55                   	push   %rbp
ffffffff801094b4:	48 89 e5             	mov    %rsp,%rbp
ffffffff801094b7:	90                   	nop
ffffffff801094b8:	5d                   	pop    %rbp
ffffffff801094b9:	c3                   	ret

ffffffff801094ba <mkgate>:

static void mkgate(uint *idt, uint n, void *kva, uint pl, uint trap) {
ffffffff801094ba:	55                   	push   %rbp
ffffffff801094bb:	48 89 e5             	mov    %rsp,%rbp
ffffffff801094be:	48 83 ec 30          	sub    $0x30,%rsp
ffffffff801094c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffffffff801094c6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffffffff801094c9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffffffff801094cd:	89 4d e0             	mov    %ecx,-0x20(%rbp)
ffffffff801094d0:	44 89 45 d4          	mov    %r8d,-0x2c(%rbp)
  uint64 addr = (uint64) kva;
ffffffff801094d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff801094d8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  n *= 4;
ffffffff801094dc:	c1 65 e4 02          	shll   $0x2,-0x1c(%rbp)
  trap = trap ? 0x8F00 : 0x8E00; // TRAP vs INTERRUPT gate;
ffffffff801094e0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
ffffffff801094e4:	74 07                	je     ffffffff801094ed <mkgate+0x33>
ffffffff801094e6:	b8 00 8f 00 00       	mov    $0x8f00,%eax
ffffffff801094eb:	eb 05                	jmp    ffffffff801094f2 <mkgate+0x38>
ffffffff801094ed:	b8 00 8e 00 00       	mov    $0x8e00,%eax
ffffffff801094f2:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  idt[n+0] = (addr & 0xFFFF) | ((SEG_KCODE << 3) << 16);
ffffffff801094f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801094f9:	0f b7 d0             	movzwl %ax,%edx
ffffffff801094fc:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff801094ff:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffffffff80109506:	00 
ffffffff80109507:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010950b:	48 01 c8             	add    %rcx,%rax
ffffffff8010950e:	81 ca 00 00 08 00    	or     $0x80000,%edx
ffffffff80109514:	89 10                	mov    %edx,(%rax)
  idt[n+1] = (addr & 0xFFFF0000) | trap | ((pl & 3) << 13); // P=1 DPL=pl
ffffffff80109516:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010951a:	66 b8 00 00          	mov    $0x0,%ax
ffffffff8010951e:	0b 45 d4             	or     -0x2c(%rbp),%eax
ffffffff80109521:	89 c2                	mov    %eax,%edx
ffffffff80109523:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffffffff80109526:	c1 e0 0d             	shl    $0xd,%eax
ffffffff80109529:	25 00 60 00 00       	and    $0x6000,%eax
ffffffff8010952e:	89 c1                	mov    %eax,%ecx
ffffffff80109530:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80109533:	83 c0 01             	add    $0x1,%eax
ffffffff80109536:	89 c0                	mov    %eax,%eax
ffffffff80109538:	48 8d 34 85 00 00 00 	lea    0x0(,%rax,4),%rsi
ffffffff8010953f:	00 
ffffffff80109540:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109544:	48 01 f0             	add    %rsi,%rax
ffffffff80109547:	09 ca                	or     %ecx,%edx
ffffffff80109549:	89 10                	mov    %edx,(%rax)
  idt[n+2] = addr >> 32;
ffffffff8010954b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010954f:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff80109553:	48 89 c2             	mov    %rax,%rdx
ffffffff80109556:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80109559:	83 c0 02             	add    $0x2,%eax
ffffffff8010955c:	89 c0                	mov    %eax,%eax
ffffffff8010955e:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffffffff80109565:	00 
ffffffff80109566:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010956a:	48 01 c8             	add    %rcx,%rax
ffffffff8010956d:	89 10                	mov    %edx,(%rax)
  idt[n+3] = 0;
ffffffff8010956f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffffffff80109572:	83 c0 03             	add    $0x3,%eax
ffffffff80109575:	89 c0                	mov    %eax,%eax
ffffffff80109577:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff8010957e:	00 
ffffffff8010957f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109583:	48 01 d0             	add    %rdx,%rax
ffffffff80109586:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
}
ffffffff8010958c:	90                   	nop
ffffffff8010958d:	c9                   	leave
ffffffff8010958e:	c3                   	ret

ffffffff8010958f <tss_set_rsp>:

static void tss_set_rsp(uint *tss, uint n, uint64 rsp) {
ffffffff8010958f:	55                   	push   %rbp
ffffffff80109590:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109593:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff80109597:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff8010959b:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffffffff8010959e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  tss[n*2 + 1] = rsp;
ffffffff801095a2:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff801095a5:	01 c0                	add    %eax,%eax
ffffffff801095a7:	83 c0 01             	add    $0x1,%eax
ffffffff801095aa:	89 c0                	mov    %eax,%eax
ffffffff801095ac:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff801095b3:	00 
ffffffff801095b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801095b8:	48 01 d0             	add    %rdx,%rax
ffffffff801095bb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff801095bf:	89 10                	mov    %edx,(%rax)
  tss[n*2 + 2] = rsp >> 32;
ffffffff801095c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801095c5:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff801095c9:	48 89 c2             	mov    %rax,%rdx
ffffffff801095cc:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff801095cf:	83 c0 01             	add    $0x1,%eax
ffffffff801095d2:	01 c0                	add    %eax,%eax
ffffffff801095d4:	89 c0                	mov    %eax,%eax
ffffffff801095d6:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffffffff801095dd:	00 
ffffffff801095de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff801095e2:	48 01 c8             	add    %rcx,%rax
ffffffff801095e5:	89 10                	mov    %edx,(%rax)
}
ffffffff801095e7:	90                   	nop
ffffffff801095e8:	c9                   	leave
ffffffff801095e9:	c3                   	ret

ffffffff801095ea <tss_set_ist>:

static void tss_set_ist(uint *tss, uint n, uint64 ist) {
ffffffff801095ea:	55                   	push   %rbp
ffffffff801095eb:	48 89 e5             	mov    %rsp,%rbp
ffffffff801095ee:	48 83 ec 18          	sub    $0x18,%rsp
ffffffff801095f2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffffffff801095f6:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffffffff801095f9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  tss[n*2 + 7] = ist;
ffffffff801095fd:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff80109600:	01 c0                	add    %eax,%eax
ffffffff80109602:	83 c0 07             	add    $0x7,%eax
ffffffff80109605:	89 c0                	mov    %eax,%eax
ffffffff80109607:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffffffff8010960e:	00 
ffffffff8010960f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109613:	48 01 d0             	add    %rdx,%rax
ffffffff80109616:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff8010961a:	89 10                	mov    %edx,(%rax)
  tss[n*2 + 8] = ist >> 32;
ffffffff8010961c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109620:	48 c1 e8 20          	shr    $0x20,%rax
ffffffff80109624:	48 89 c2             	mov    %rax,%rdx
ffffffff80109627:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffffffff8010962a:	83 c0 04             	add    $0x4,%eax
ffffffff8010962d:	01 c0                	add    %eax,%eax
ffffffff8010962f:	89 c0                	mov    %eax,%eax
ffffffff80109631:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffffffff80109638:	00 
ffffffff80109639:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff8010963d:	48 01 c8             	add    %rcx,%rax
ffffffff80109640:	89 10                	mov    %edx,(%rax)
}
ffffffff80109642:	90                   	nop
ffffffff80109643:	c9                   	leave
ffffffff80109644:	c3                   	ret

ffffffff80109645 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
ffffffff80109645:	55                   	push   %rbp
ffffffff80109646:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109649:	48 83 ec 40          	sub    $0x40,%rsp
  uint64 *gdt;
  uint *tss;
  uint64 addr;
  void *local;
  struct cpu *c;
  uint *idt = (uint*) kalloc();
ffffffff8010964d:	e8 87 9c ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80109652:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  int n;
  memset(idt, 0, PGSIZE);
ffffffff80109656:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff8010965a:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff8010965f:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80109664:	48 89 c7             	mov    %rax,%rdi
ffffffff80109667:	e8 e7 c8 ff ff       	call   ffffffff80105f53 <memset>

  for (n = 0; n < 256; n++)
ffffffff8010966c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80109673:	eb 2b                	jmp    ffffffff801096a0 <seginit+0x5b>
    mkgate(idt, n, vectors[n], 0, 0);
ffffffff80109675:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80109678:	48 98                	cltq
ffffffff8010967a:	48 8b 14 c5 a8 b6 10 	mov    -0x7fef4958(,%rax,8),%rdx
ffffffff80109681:	80 
ffffffff80109682:	8b 75 fc             	mov    -0x4(%rbp),%esi
ffffffff80109685:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80109689:	41 b8 00 00 00 00    	mov    $0x0,%r8d
ffffffff8010968f:	b9 00 00 00 00       	mov    $0x0,%ecx
ffffffff80109694:	48 89 c7             	mov    %rax,%rdi
ffffffff80109697:	e8 1e fe ff ff       	call   ffffffff801094ba <mkgate>
  for (n = 0; n < 256; n++)
ffffffff8010969c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff801096a0:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffffffff801096a7:	7e cc                	jle    ffffffff80109675 <seginit+0x30>
  mkgate(idt, 64, vectors[64], 3, 1);
ffffffff801096a9:	48 8b 15 f8 21 00 00 	mov    0x21f8(%rip),%rdx        # ffffffff8010b8a8 <vectors+0x200>
ffffffff801096b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801096b4:	41 b8 01 00 00 00    	mov    $0x1,%r8d
ffffffff801096ba:	b9 03 00 00 00       	mov    $0x3,%ecx
ffffffff801096bf:	be 40 00 00 00       	mov    $0x40,%esi
ffffffff801096c4:	48 89 c7             	mov    %rax,%rdi
ffffffff801096c7:	e8 ee fd ff ff       	call   ffffffff801094ba <mkgate>

  lidt((void*) idt, PGSIZE);
ffffffff801096cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801096d0:	be 00 10 00 00       	mov    $0x1000,%esi
ffffffff801096d5:	48 89 c7             	mov    %rax,%rdi
ffffffff801096d8:	e8 38 fd ff ff       	call   ffffffff80109415 <lidt>

  // create a page for cpu local storage 
  local = kalloc();
ffffffff801096dd:	e8 f7 9b ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff801096e2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  memset(local, 0, PGSIZE);
ffffffff801096e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801096ea:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801096ef:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801096f4:	48 89 c7             	mov    %rax,%rdi
ffffffff801096f7:	e8 57 c8 ff ff       	call   ffffffff80105f53 <memset>

  gdt = (uint64*) local;
ffffffff801096fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109700:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  tss = (uint*) (((char*) local) + 1024);
ffffffff80109704:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109708:	48 05 00 04 00 00    	add    $0x400,%rax
ffffffff8010970e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  tss[16] = 0x00680000; // IO Map Base = End of TSS
ffffffff80109712:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80109716:	48 83 c0 40          	add    $0x40,%rax
ffffffff8010971a:	c7 00 00 00 68 00    	movl   $0x680000,(%rax)

  // point FS smack in the middle of our local storage page
  wrmsr(0xC0000100, ((uint64) local) + (PGSIZE / 2));
ffffffff80109720:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109724:	48 05 00 08 00 00    	add    $0x800,%rax
ffffffff8010972a:	48 89 c6             	mov    %rax,%rsi
ffffffff8010972d:	bf 00 01 00 c0       	mov    $0xc0000100,%edi
ffffffff80109732:	e8 e4 69 ff ff       	call   ffffffff8010011b <wrmsr>

  c = &cpus[cpunum()];
ffffffff80109737:	e8 0f 9f ff ff       	call   ffffffff8010364b <cpunum>
ffffffff8010973c:	48 63 d0             	movslq %eax,%rdx
ffffffff8010973f:	48 89 d0             	mov    %rdx,%rax
ffffffff80109742:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff80109746:	48 29 d0             	sub    %rdx,%rax
ffffffff80109749:	48 c1 e0 04          	shl    $0x4,%rax
ffffffff8010974d:	48 05 60 fc 10 80    	add    $0xffffffff8010fc60,%rax
ffffffff80109753:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  c->local = local;
ffffffff80109757:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010975b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffffffff8010975f:	48 89 90 e8 00 00 00 	mov    %rdx,0xe8(%rax)

  cpu = c;
ffffffff80109766:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffffffff8010976a:	64 48 89 04 25 f0 ff 	mov    %rax,%fs:0xfffffffffffffff0
ffffffff80109771:	ff ff 
  proc = 0;
ffffffff80109773:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
ffffffff8010977a:	ff ff 00 00 00 00 

  addr = (uint64) tss;
ffffffff80109780:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffffffff80109784:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  gdt[0] =         0x0000000000000000;
ffffffff80109788:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010978c:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_KCODE] = 0x0020980000000000;  // Code, DPL=0, R/X
ffffffff80109793:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109797:	48 83 c0 08          	add    $0x8,%rax
ffffffff8010979b:	48 b9 00 00 00 00 00 	movabs $0x20980000000000,%rcx
ffffffff801097a2:	98 20 00 
ffffffff801097a5:	48 89 08             	mov    %rcx,(%rax)
  gdt[SEG_UCODE] = 0x0020F80000000000;  // Code, DPL=3, R/X
ffffffff801097a8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801097ac:	48 83 c0 20          	add    $0x20,%rax
ffffffff801097b0:	48 bf 00 00 00 00 00 	movabs $0x20f80000000000,%rdi
ffffffff801097b7:	f8 20 00 
ffffffff801097ba:	48 89 38             	mov    %rdi,(%rax)
  gdt[SEG_KDATA] = 0x0000920000000000;  // Data, DPL=0, W
ffffffff801097bd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801097c1:	48 83 c0 10          	add    $0x10,%rax
ffffffff801097c5:	48 b9 00 00 00 00 00 	movabs $0x920000000000,%rcx
ffffffff801097cc:	92 00 00 
ffffffff801097cf:	48 89 08             	mov    %rcx,(%rax)
  gdt[SEG_KCPU]  = 0x0000000000000000;  // unused
ffffffff801097d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801097d6:	48 83 c0 18          	add    $0x18,%rax
ffffffff801097da:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_UDATA] = 0x0000F20000000000;  // Data, DPL=3, W
ffffffff801097e1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff801097e5:	48 83 c0 28          	add    $0x28,%rax
ffffffff801097e9:	48 be 00 00 00 00 00 	movabs $0xf20000000000,%rsi
ffffffff801097f0:	f2 00 00 
ffffffff801097f3:	48 89 30             	mov    %rsi,(%rax)
  gdt[SEG_TSS+0] = (0x0067) | ((addr & 0xFFFFFF) << 16) |
ffffffff801097f6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff801097fa:	48 c1 e0 10          	shl    $0x10,%rax
ffffffff801097fe:	48 89 c2             	mov    %rax,%rdx
ffffffff80109801:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
ffffffff80109808:	00 00 00 
ffffffff8010980b:	48 21 c2             	and    %rax,%rdx
                   (0x00E9LL << 40) | (((addr >> 24) & 0xFF) << 56);
ffffffff8010980e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff80109812:	48 c1 e8 18          	shr    $0x18,%rax
ffffffff80109816:	48 c1 e0 38          	shl    $0x38,%rax
ffffffff8010981a:	48 89 d1             	mov    %rdx,%rcx
ffffffff8010981d:	48 09 c1             	or     %rax,%rcx
  gdt[SEG_TSS+0] = (0x0067) | ((addr & 0xFFFFFF) << 16) |
ffffffff80109820:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff80109824:	48 83 c0 30          	add    $0x30,%rax
                   (0x00E9LL << 40) | (((addr >> 24) & 0xFF) << 56);
ffffffff80109828:	48 ba 67 00 00 00 00 	movabs $0xe90000000067,%rdx
ffffffff8010982f:	e9 00 00 
ffffffff80109832:	48 09 ca             	or     %rcx,%rdx
  gdt[SEG_TSS+0] = (0x0067) | ((addr & 0xFFFFFF) << 16) |
ffffffff80109835:	48 89 10             	mov    %rdx,(%rax)
  gdt[SEG_TSS+1] = (addr >> 32);
ffffffff80109838:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010983c:	48 83 c0 38          	add    $0x38,%rax
ffffffff80109840:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
ffffffff80109844:	48 c1 ea 20          	shr    $0x20,%rdx
ffffffff80109848:	48 89 10             	mov    %rdx,(%rax)

  lgdt((void*) gdt, 8 * sizeof(uint64));
ffffffff8010984b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffffffff8010984f:	be 40 00 00 00       	mov    $0x40,%esi
ffffffff80109854:	48 89 c7             	mov    %rax,%rdi
ffffffff80109857:	e8 6a fb ff ff       	call   ffffffff801093c6 <lgdt>

  ltr(SEG_TSS << 3);
ffffffff8010985c:	bf 30 00 00 00       	mov    $0x30,%edi
ffffffff80109861:	e8 fe fb ff ff       	call   ffffffff80109464 <ltr>
};
ffffffff80109866:	90                   	nop
ffffffff80109867:	c9                   	leave
ffffffff80109868:	c3                   	ret

ffffffff80109869 <setupkvm>:
// because we need to find the other levels later, we'll stash
// backpointers to them in the top two entries of the level two
// table.
pde_t*
setupkvm(void)
{
ffffffff80109869:	55                   	push   %rbp
ffffffff8010986a:	48 89 e5             	mov    %rsp,%rbp
ffffffff8010986d:	48 83 ec 20          	sub    $0x20,%rsp
  pde_t *pml4 = (pde_t*) kalloc();
ffffffff80109871:	e8 63 9a ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80109876:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pde_t *pdpt = (pde_t*) kalloc();
ffffffff8010987a:	e8 5a 9a ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff8010987f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  pde_t *pgdir = (pde_t*) kalloc();
ffffffff80109883:	e8 51 9a ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80109888:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

  memset(pml4, 0, PGSIZE);
ffffffff8010988c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109890:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff80109895:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff8010989a:	48 89 c7             	mov    %rax,%rdi
ffffffff8010989d:	e8 b1 c6 ff ff       	call   ffffffff80105f53 <memset>
  memset(pdpt, 0, PGSIZE);
ffffffff801098a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801098a6:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801098ab:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801098b0:	48 89 c7             	mov    %rax,%rdi
ffffffff801098b3:	e8 9b c6 ff ff       	call   ffffffff80105f53 <memset>
  memset(pgdir, 0, PGSIZE);
ffffffff801098b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff801098bc:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801098c1:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801098c6:	48 89 c7             	mov    %rax,%rdi
ffffffff801098c9:	e8 85 c6 ff ff       	call   ffffffff80105f53 <memset>
  pml4[511] = v2p(kpdpt) | PTE_P | PTE_W | PTE_U;
ffffffff801098ce:	48 8b 05 0b b1 00 00 	mov    0xb10b(%rip),%rax        # ffffffff801149e0 <kpdpt>
ffffffff801098d5:	48 89 c7             	mov    %rax,%rdi
ffffffff801098d8:	e8 b5 fb ff ff       	call   ffffffff80109492 <v2p>
ffffffff801098dd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff801098e1:	48 81 c2 f8 0f 00 00 	add    $0xff8,%rdx
ffffffff801098e8:	48 83 c8 07          	or     $0x7,%rax
ffffffff801098ec:	48 89 02             	mov    %rax,(%rdx)
  pml4[0] = v2p(pdpt) | PTE_P | PTE_W | PTE_U;
ffffffff801098ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff801098f3:	48 89 c7             	mov    %rax,%rdi
ffffffff801098f6:	e8 97 fb ff ff       	call   ffffffff80109492 <v2p>
ffffffff801098fb:	48 83 c8 07          	or     $0x7,%rax
ffffffff801098ff:	48 89 c2             	mov    %rax,%rdx
ffffffff80109902:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109906:	48 89 10             	mov    %rdx,(%rax)
  pdpt[0] = v2p(pgdir) | PTE_P | PTE_W | PTE_U; 
ffffffff80109909:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010990d:	48 89 c7             	mov    %rax,%rdi
ffffffff80109910:	e8 7d fb ff ff       	call   ffffffff80109492 <v2p>
ffffffff80109915:	48 83 c8 07          	or     $0x7,%rax
ffffffff80109919:	48 89 c2             	mov    %rax,%rdx
ffffffff8010991c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80109920:	48 89 10             	mov    %rdx,(%rax)

  // virtual backpointers
  pgdir[511] = ((uintp) pml4) | PTE_P;
ffffffff80109923:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffffffff80109927:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff8010992b:	48 05 f8 0f 00 00    	add    $0xff8,%rax
ffffffff80109931:	48 83 ca 01          	or     $0x1,%rdx
ffffffff80109935:	48 89 10             	mov    %rdx,(%rax)
  pgdir[510] = ((uintp) pdpt) | PTE_P;
ffffffff80109938:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffffffff8010993c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109940:	48 05 f0 0f 00 00    	add    $0xff0,%rax
ffffffff80109946:	48 83 ca 01          	or     $0x1,%rdx
ffffffff8010994a:	48 89 10             	mov    %rdx,(%rax)

  return pgdir;
ffffffff8010994d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
};
ffffffff80109951:	c9                   	leave
ffffffff80109952:	c3                   	ret

ffffffff80109953 <kvmalloc>:
// space for scheduler processes.
//
// linear map the first 4GB of physical memory starting at 0xFFFFFFFF80000000
void
kvmalloc(void)
{
ffffffff80109953:	55                   	push   %rbp
ffffffff80109954:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109957:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  kpml4 = (pde_t*) kalloc();
ffffffff8010995b:	e8 79 99 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80109960:	48 89 05 71 b0 00 00 	mov    %rax,0xb071(%rip)        # ffffffff801149d8 <kpml4>
  kpdpt = (pde_t*) kalloc();
ffffffff80109967:	e8 6d 99 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff8010996c:	48 89 05 6d b0 00 00 	mov    %rax,0xb06d(%rip)        # ffffffff801149e0 <kpdpt>
  kpgdir0 = (pde_t*) kalloc();
ffffffff80109973:	e8 61 99 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80109978:	48 89 05 71 b0 00 00 	mov    %rax,0xb071(%rip)        # ffffffff801149f0 <kpgdir0>
  kpgdir1 = (pde_t*) kalloc();
ffffffff8010997f:	e8 55 99 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80109984:	48 89 05 6d b0 00 00 	mov    %rax,0xb06d(%rip)        # ffffffff801149f8 <kpgdir1>
  iopgdir = (pde_t*) kalloc();
ffffffff8010998b:	e8 49 99 ff ff       	call   ffffffff801032d9 <kalloc>
ffffffff80109990:	48 89 05 51 b0 00 00 	mov    %rax,0xb051(%rip)        # ffffffff801149e8 <iopgdir>
  memset(kpml4, 0, PGSIZE);
ffffffff80109997:	48 8b 05 3a b0 00 00 	mov    0xb03a(%rip),%rax        # ffffffff801149d8 <kpml4>
ffffffff8010999e:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801099a3:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801099a8:	48 89 c7             	mov    %rax,%rdi
ffffffff801099ab:	e8 a3 c5 ff ff       	call   ffffffff80105f53 <memset>
  memset(kpdpt, 0, PGSIZE);
ffffffff801099b0:	48 8b 05 29 b0 00 00 	mov    0xb029(%rip),%rax        # ffffffff801149e0 <kpdpt>
ffffffff801099b7:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801099bc:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801099c1:	48 89 c7             	mov    %rax,%rdi
ffffffff801099c4:	e8 8a c5 ff ff       	call   ffffffff80105f53 <memset>
  memset(iopgdir, 0, PGSIZE);
ffffffff801099c9:	48 8b 05 18 b0 00 00 	mov    0xb018(%rip),%rax        # ffffffff801149e8 <iopgdir>
ffffffff801099d0:	ba 00 10 00 00       	mov    $0x1000,%edx
ffffffff801099d5:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff801099da:	48 89 c7             	mov    %rax,%rdi
ffffffff801099dd:	e8 71 c5 ff ff       	call   ffffffff80105f53 <memset>
  kpml4[511] = v2p(kpdpt) | PTE_P | PTE_W;
ffffffff801099e2:	48 8b 05 f7 af 00 00 	mov    0xaff7(%rip),%rax        # ffffffff801149e0 <kpdpt>
ffffffff801099e9:	48 89 c7             	mov    %rax,%rdi
ffffffff801099ec:	e8 a1 fa ff ff       	call   ffffffff80109492 <v2p>
ffffffff801099f1:	48 8b 15 e0 af 00 00 	mov    0xafe0(%rip),%rdx        # ffffffff801149d8 <kpml4>
ffffffff801099f8:	48 81 c2 f8 0f 00 00 	add    $0xff8,%rdx
ffffffff801099ff:	48 83 c8 03          	or     $0x3,%rax
ffffffff80109a03:	48 89 02             	mov    %rax,(%rdx)
  kpdpt[511] = v2p(kpgdir1) | PTE_P | PTE_W;
ffffffff80109a06:	48 8b 05 eb af 00 00 	mov    0xafeb(%rip),%rax        # ffffffff801149f8 <kpgdir1>
ffffffff80109a0d:	48 89 c7             	mov    %rax,%rdi
ffffffff80109a10:	e8 7d fa ff ff       	call   ffffffff80109492 <v2p>
ffffffff80109a15:	48 8b 15 c4 af 00 00 	mov    0xafc4(%rip),%rdx        # ffffffff801149e0 <kpdpt>
ffffffff80109a1c:	48 81 c2 f8 0f 00 00 	add    $0xff8,%rdx
ffffffff80109a23:	48 83 c8 03          	or     $0x3,%rax
ffffffff80109a27:	48 89 02             	mov    %rax,(%rdx)
  kpdpt[510] = v2p(kpgdir0) | PTE_P | PTE_W;
ffffffff80109a2a:	48 8b 05 bf af 00 00 	mov    0xafbf(%rip),%rax        # ffffffff801149f0 <kpgdir0>
ffffffff80109a31:	48 89 c7             	mov    %rax,%rdi
ffffffff80109a34:	e8 59 fa ff ff       	call   ffffffff80109492 <v2p>
ffffffff80109a39:	48 8b 15 a0 af 00 00 	mov    0xafa0(%rip),%rdx        # ffffffff801149e0 <kpdpt>
ffffffff80109a40:	48 81 c2 f0 0f 00 00 	add    $0xff0,%rdx
ffffffff80109a47:	48 83 c8 03          	or     $0x3,%rax
ffffffff80109a4b:	48 89 02             	mov    %rax,(%rdx)
  kpdpt[509] = v2p(iopgdir) | PTE_P | PTE_W;
ffffffff80109a4e:	48 8b 05 93 af 00 00 	mov    0xaf93(%rip),%rax        # ffffffff801149e8 <iopgdir>
ffffffff80109a55:	48 89 c7             	mov    %rax,%rdi
ffffffff80109a58:	e8 35 fa ff ff       	call   ffffffff80109492 <v2p>
ffffffff80109a5d:	48 8b 15 7c af 00 00 	mov    0xaf7c(%rip),%rdx        # ffffffff801149e0 <kpdpt>
ffffffff80109a64:	48 81 c2 e8 0f 00 00 	add    $0xfe8,%rdx
ffffffff80109a6b:	48 83 c8 03          	or     $0x3,%rax
ffffffff80109a6f:	48 89 02             	mov    %rax,(%rdx)
  for (n = 0; n < NPDENTRIES; n++) {
ffffffff80109a72:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80109a79:	eb 51                	jmp    ffffffff80109acc <kvmalloc+0x179>
    kpgdir0[n] = (n << PDXSHIFT) | PTE_PS | PTE_P | PTE_W;
ffffffff80109a7b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80109a7e:	c1 e0 15             	shl    $0x15,%eax
ffffffff80109a81:	0c 83                	or     $0x83,%al
ffffffff80109a83:	89 c1                	mov    %eax,%ecx
ffffffff80109a85:	48 8b 05 64 af 00 00 	mov    0xaf64(%rip),%rax        # ffffffff801149f0 <kpgdir0>
ffffffff80109a8c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80109a8f:	48 63 d2             	movslq %edx,%rdx
ffffffff80109a92:	48 c1 e2 03          	shl    $0x3,%rdx
ffffffff80109a96:	48 01 c2             	add    %rax,%rdx
ffffffff80109a99:	48 63 c1             	movslq %ecx,%rax
ffffffff80109a9c:	48 89 02             	mov    %rax,(%rdx)
    kpgdir1[n] = ((n + 512) << PDXSHIFT) | PTE_PS | PTE_P | PTE_W;
ffffffff80109a9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80109aa2:	05 00 02 00 00       	add    $0x200,%eax
ffffffff80109aa7:	c1 e0 15             	shl    $0x15,%eax
ffffffff80109aaa:	0c 83                	or     $0x83,%al
ffffffff80109aac:	89 c1                	mov    %eax,%ecx
ffffffff80109aae:	48 8b 05 43 af 00 00 	mov    0xaf43(%rip),%rax        # ffffffff801149f8 <kpgdir1>
ffffffff80109ab5:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80109ab8:	48 63 d2             	movslq %edx,%rdx
ffffffff80109abb:	48 c1 e2 03          	shl    $0x3,%rdx
ffffffff80109abf:	48 01 c2             	add    %rax,%rdx
ffffffff80109ac2:	48 63 c1             	movslq %ecx,%rax
ffffffff80109ac5:	48 89 02             	mov    %rax,(%rdx)
  for (n = 0; n < NPDENTRIES; n++) {
ffffffff80109ac8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80109acc:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
ffffffff80109ad3:	7e a6                	jle    ffffffff80109a7b <kvmalloc+0x128>
  }
  for (n = 0; n < 16; n++)
ffffffff80109ad5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffffffff80109adc:	eb 2c                	jmp    ffffffff80109b0a <kvmalloc+0x1b7>
    iopgdir[n] = (DEVSPACE + (n << PDXSHIFT)) | PTE_PS | PTE_P | PTE_W | PTE_PWT | PTE_PCD;
ffffffff80109ade:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffffffff80109ae1:	c1 e0 15             	shl    $0x15,%eax
ffffffff80109ae4:	2d 00 00 00 02       	sub    $0x2000000,%eax
ffffffff80109ae9:	0c 9b                	or     $0x9b,%al
ffffffff80109aeb:	89 c1                	mov    %eax,%ecx
ffffffff80109aed:	48 8b 05 f4 ae 00 00 	mov    0xaef4(%rip),%rax        # ffffffff801149e8 <iopgdir>
ffffffff80109af4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffffffff80109af7:	48 63 d2             	movslq %edx,%rdx
ffffffff80109afa:	48 c1 e2 03          	shl    $0x3,%rdx
ffffffff80109afe:	48 01 d0             	add    %rdx,%rax
ffffffff80109b01:	89 ca                	mov    %ecx,%edx
ffffffff80109b03:	48 89 10             	mov    %rdx,(%rax)
  for (n = 0; n < 16; n++)
ffffffff80109b06:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffffffff80109b0a:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffffffff80109b0e:	7e ce                	jle    ffffffff80109ade <kvmalloc+0x18b>
  switchkvm();
ffffffff80109b10:	e8 03 00 00 00       	call   ffffffff80109b18 <switchkvm>
}
ffffffff80109b15:	90                   	nop
ffffffff80109b16:	c9                   	leave
ffffffff80109b17:	c3                   	ret

ffffffff80109b18 <switchkvm>:

void
switchkvm(void)
{
ffffffff80109b18:	55                   	push   %rbp
ffffffff80109b19:	48 89 e5             	mov    %rsp,%rbp
  lcr3(v2p(kpml4));
ffffffff80109b1c:	48 8b 05 b5 ae 00 00 	mov    0xaeb5(%rip),%rax        # ffffffff801149d8 <kpml4>
ffffffff80109b23:	48 89 c7             	mov    %rax,%rdi
ffffffff80109b26:	e8 67 f9 ff ff       	call   ffffffff80109492 <v2p>
ffffffff80109b2b:	48 89 c7             	mov    %rax,%rdi
ffffffff80109b2e:	e8 49 f9 ff ff       	call   ffffffff8010947c <lcr3>
}
ffffffff80109b33:	90                   	nop
ffffffff80109b34:	5d                   	pop    %rbp
ffffffff80109b35:	c3                   	ret

ffffffff80109b36 <switchuvm>:

void
switchuvm(struct proc *p)
{
ffffffff80109b36:	55                   	push   %rbp
ffffffff80109b37:	48 89 e5             	mov    %rsp,%rbp
ffffffff80109b3a:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff80109b3e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  void *pml4;
  uint *tss;
  pushcli();
ffffffff80109b42:	e8 cf c2 ff ff       	call   ffffffff80105e16 <pushcli>
  if(p->pgdir == 0)
ffffffff80109b47:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109b4b:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80109b4f:	48 85 c0             	test   %rax,%rax
ffffffff80109b52:	75 0c                	jne    ffffffff80109b60 <switchuvm+0x2a>
    panic("switchuvm: no pgdir");
ffffffff80109b54:	48 c7 c7 9e a3 10 80 	mov    $0xffffffff8010a39e,%rdi
ffffffff80109b5b:	e8 cf 6d ff ff       	call   ffffffff8010092f <panic>
  tss = (uint*) (((char*) cpu->local) + 1024);
ffffffff80109b60:	64 48 8b 04 25 f0 ff 	mov    %fs:0xfffffffffffffff0,%rax
ffffffff80109b67:	ff ff 
ffffffff80109b69:	48 8b 80 e8 00 00 00 	mov    0xe8(%rax),%rax
ffffffff80109b70:	48 05 00 04 00 00    	add    $0x400,%rax
ffffffff80109b76:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  tss_set_rsp(tss, 0, (uintp)proc->kstack + KSTACKSIZE);
ffffffff80109b7a:	64 48 8b 04 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rax
ffffffff80109b81:	ff ff 
ffffffff80109b83:	48 8b 40 10          	mov    0x10(%rax),%rax
ffffffff80109b87:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffffffff80109b8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffffffff80109b92:	be 00 00 00 00       	mov    $0x0,%esi
ffffffff80109b97:	48 89 c7             	mov    %rax,%rdi
ffffffff80109b9a:	e8 f0 f9 ff ff       	call   ffffffff8010958f <tss_set_rsp>
  pml4 = (void*) PTE_ADDR(p->pgdir[511]);
ffffffff80109b9f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffffffff80109ba3:	48 8b 40 08          	mov    0x8(%rax),%rax
ffffffff80109ba7:	48 05 f8 0f 00 00    	add    $0xff8,%rax
ffffffff80109bad:	48 8b 00             	mov    (%rax),%rax
ffffffff80109bb0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffffffff80109bb6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  lcr3(v2p(pml4));
ffffffff80109bba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffffffff80109bbe:	48 89 c7             	mov    %rax,%rdi
ffffffff80109bc1:	e8 cc f8 ff ff       	call   ffffffff80109492 <v2p>
ffffffff80109bc6:	48 89 c7             	mov    %rax,%rdi
ffffffff80109bc9:	e8 ae f8 ff ff       	call   ffffffff8010947c <lcr3>
  popcli();
ffffffff80109bce:	e8 93 c2 ff ff       	call   ffffffff80105e66 <popcli>
}
ffffffff80109bd3:	90                   	nop
ffffffff80109bd4:	c9                   	leave
ffffffff80109bd5:	c3                   	ret
