package im.actor.core.api.updates;
/*
 *  Generated by the Actor API Scheme generator.  DO NOT EDIT!
 */

import im.actor.runtime.bser.*;
import im.actor.core.network.parser.*;

import org.jetbrains.annotations.NotNull;

import java.io.IOException;

import im.actor.core.api.*;

public class UpdateChatDelete extends Update {

    public static final int HEADER = 0x30;
    public static UpdateChatDelete fromBytes(byte[] data) throws IOException {
        return Bser.parse(new UpdateChatDelete(), data);
    }

    private Peer peer;

    public UpdateChatDelete(@NotNull Peer peer) {
        this.peer = peer;
    }

    public UpdateChatDelete() {

    }

    @NotNull
    public Peer getPeer() {
        return this.peer;
    }

    @Override
    public void parse(BserValues values) throws IOException {
        this.peer = values.getObj(1, new Peer());
    }

    @Override
    public void serialize(BserWriter writer) throws IOException {
        if (this.peer == null) {
            throw new IOException();
        }
        writer.writeObject(1, this.peer);
    }

    @Override
    public String toString() {
        String res = "update ChatDelete{";
        res += "peer=" + this.peer;
        res += "}";
        return res;
    }

    @Override
    public int getHeaderKey() {
        return HEADER;
    }
}